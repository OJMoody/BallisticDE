//=============================================================================
// CYLOPrimaryFire.
//
// For some really odd reason my UDE isn't liking the class names, so I have to
// change the names for UDE to recognize them every once in a while...
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ZX98SecondaryFire extends BallisticProInstantFire;

var rotator OldLookDir, TurnVelocity;
var float	LastFireTime, MuzzleBTime, MuzzleCTime, OldFireRate;
var Actor	MuzzleFlashB, MuzzleFlashC;
var ZX98AssaultRifle ZX98Weapon;

var float	LagTime;

var	int		TraceCount;

var bool	bStarted;

var float	NextTVUpdateTime;
/*
//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);

	if (!bStarted)
	{
		bStarted = true;
		BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		BW.PlaySound(ZX98Weapon.BarrelStartSound, SLOT_None, 0.5, , 32, 1.0, true);
	}

	ClientPlayForceFeedback(FireForce);  // jdf
	FireCount++;

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
}

function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	if (!bStarted)
	{
		bStarted = true;
		BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		BW.PlayOwnedSound(ZX98Weapon.BarrelStartSound, SLOT_None, 0.5, , 32, 1.0, true);
	}
}

function StopFiring()
{
	bStarted = false;
}
*/
function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
	super.InitEffects();
	if ((MuzzleFlashClass != None) && ((MuzzleFlashB == None) || MuzzleFlashB.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashB, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
	if ((MuzzleFlashClass != None) && ((MuzzleFlashC == None) || MuzzleFlashC.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashC, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlashB);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashC);
}

// Returns the interpolated base aim with its offset, chaos, etc and view aim removed in the form of a single rotator
simulated function Rotator GetNewAimPivot(float ExtraTime, optional bool bIgnoreViewAim)
{
	return BW.CalcFutureAim(ExtraTime, bIgnoreViewAim);
}

/*
simulated function rotator GetNewAim(float ExtraTime)
{
	return class'BUtil'.static.RSmerp(FMin((BW.ReaimPhase+ExtraTime)/BW.ReaimTime, 1.0), BW.OldAim, BW.NewAim);
}

simulated function rotator GetNewAimOffset(float ExtraTime)
{
	return class'BUtil'.static.RSmerp(FMax(0.0,(BW.AimOffsetTime-(level.TimeSeconds+ExtraTime))/BW.AimAdjustTime), BW.NewAimOffset, BW.OldAimOffset);
}

// Returns the interpolated base aim with its offset, chaos, etc and view aim removed in the form of a single rotator
simulated function Rotator GetNewAimPivot(float ExtraTime, optional bool bIgnoreViewAim)
{
	if (bIgnoreViewAim || Instigator.Controller == None || PlayerController(Instigator.Controller) == None || PlayerController(Instigator.Controller).bBehindView)
		return GetNewAimOffset(ExtraTime) + GetNewAim(ExtraTime) + BW.AimOffset + BW.LongGunPivot * BW.LongGunFactor;
	return GetNewAimOffset(ExtraTime) + GetNewAim(ExtraTime) * (1-BW.ViewAimFactor) + BW.AimOffset + BW.LongGunPivot * BW.LongGunFactor;
}
*/

//FIXME, maybe lets not use adjust aim, cause it does some traces and target selecting!!!
simulated function vector GetNewFireDir(out Vector StartTrace, float ExtraTime)
{
    // the to-hit trace always starts right in front of the eye
    if (BallisticTurret(Instigator) != None)
    	StartTrace = Instigator.Location + Instigator.EyePosition() + Vector(Instigator.GetViewRotation()) * 64;
//    	StartTrace = Instigator.Location + BallisticTurret(Instigator).CameraElevation * vect(0,0,1);
	else if (StartTrace == vect(0,0,0))
		StartTrace = Instigator.Location + Instigator.EyePosition();
	if (AIController(Instigator.Controller) != None && BallisticTurret(Instigator) == None)
		return Vector(GetNewAimPivot(ExtraTime) + BW.GetRecoilPivot()) >> AdjustAim(StartTrace, AimError);
	else
		return Vector(GetNewAimPivot(ExtraTime) + BW.GetRecoilPivot()) >> BW.GetPlayerAim(true);
}

// Like GetFireDir, but returns a rotator instead
simulated function rotator GetNewFireAim(out Vector StartTrace, float ExtraTime)
{
	return Rotator(GetNewFireDir(StartTrace, ExtraTime));
}

event PostBeginPlay()
{
	OldLookDir = BW.GetPlayerAim();
	OldFireRate = FireRate;
	super.PostBeginPlay();
}



// Fire TraceCount each DoFireEvent
// FireRate = DesiredFireRate / TraceCount
// TraceCount
/*
DesiredFireRate = 1 / (60*BarrelSpeed);
DesiredFireRate = 60 * BarrelSpeed;
if  (1 / (60*BarrelSpeed))
FireRate = DesiredRate / TraceCount
DesiredFireRate = (FMin(1 / (60*BarrelSpeed), 1));
TraceCount = Ceil((level.TimeSeconds - level.LastRenderTime) / DesiredFireRate);
FireRate = DesiredFireRate / TraceCount;
*/




event ModeTick(float DT)
{
	local float DesiredFireRate;
	local Rotator BasePlayerView;

	BasePlayerView = BW.GetPlayerAim();
	
	if (Instigator.IsLocallyControlled())
	{
		TurnVelocity = (BasePlayerView - OldLookDir) / DT;
		OldLookDir = BasePlayerView;
		if (level.NetMode == NM_Client && level.TimeSeconds > NextTVUpdateTime)
		{
			ZX98Weapon.SetServerTurnVelocity(TurnVelocity.Yaw, TurnVelocity.Pitch);
			NextTVUpdateTime = level.TimeSeconds + 0.15;
		}
	}

	OldFireRate = FireRate;

	if (ZX98Weapon.BarrelSpeed <= 0)
	{
		FireRate = 1;
		TraceCount = 1;
	}
	else
	{
		DesiredFireRate = (FMin(1.0 / (12*ZX98Weapon.BarrelSpeed), 1));	//change 12 here to adjust factor of barrel speed. lower values = lower firerate. don't change this in primaryfire
		if (BW.CurrentWeaponMode == 0)
			TraceCount = 1;
		else
			TraceCount = Ceil((DT*1.5) / DesiredFireRate);
		FireRate = DesiredFireRate * TraceCount;
	}
	NextFireTime += FireRate - OldFireRate;

	if (MuzzleBTime != 0)
	{
		MuzzleBTime += FireRate / TraceCount - OldFireRate / TraceCount;
		if (level.TimeSeconds >= MuzzleBTime)
		{
			MuzzleBTime = 0;
		    if (MuzzleFlashB != None)
    		    MuzzleFlashB.Trigger(Weapon, Instigator);
			if (BallisticFireSound.Sound != None)
				Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
			EjectBrass();
		}
	}
	if (MuzzleCTime != 0)
	{
		MuzzleCTime += FireRate / TraceCount - OldFireRate / TraceCount;
		if (level.TimeSeconds >= MuzzleCTime)
		{
			MuzzleCTime = 0;
		    if (MuzzleFlashC != None)
    		    MuzzleFlashC.Trigger(Weapon, Instigator);
			if (BallisticFireSound.Sound != None)
				Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
			EjectBrass();
		}
	}

	super.ModeTick(DT);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	super.SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	if (level.NetMode != NM_StandAlone)
		ZX98Attachment(Weapon.ThirdPersonActor).UpdateTurnVelocity(TurnVelocity);
}

// Get aim then run several individual traces using different spread for each one
function DoFireEffect()
{
    local Vector StartTrace;
    local Rotator R, Aim, ExtraAim, AimInterval;
	local int i;
	local float Interval, ExtraTime;

	if (!bAISilent)
		Instigator.MakeNoise(1.0);

	if (TraceCount > 1)
	{
		Interval = FireRate / TraceCount;
		AimInterval = TurnVelocity * Interval;
	}

	for (i=0;i<TraceCount && ConsumedLoad < BW.MagAmmo ;i++)
	{
		ConsumedLoad += Load;
		Aim = GetNewFireAim(StartTrace, ExtraTime);
		Aim += ExtraAim;
		R = Rotator(GetFireSpread() >> Aim);
		DoTrace(StartTrace, R);
		if (i == 1)
			MuzzleBTime = Level.TimeSeconds + ExtraTime;
		else if (i == 2)
			MuzzleCTime = Level.TimeSeconds + ExtraTime;
		ExtraTime += Interval;
		ExtraAim += AimInterval;
	}
	SetTimer(FMin(0.1, FireRate/2), false);

//	SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);

	Super(BallisticFire).DoFireEffect();;
}

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire()) 
		return;
	
	// won't fire if spinning slower than lowest rotation speed
	if (ZX98Weapon.BarrelSpeed <  ZX98Weapon.DesiredSpeed)
        return;

	BW.bPreventReload=true;
	BW.FireCount++;
	
	if (BW.FireCount == 1)
		NextFireTime = Level.TimeSeconds;

	if (BW.ReloadState != RS_None)
		BW.ReloadState = RS_None;

    // server
    if (Weapon.Role == ROLE_Authority)
    {
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
        if(BallisticTurret(Weapon.Owner) == None  && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
			class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(load, BW.InventoryGroup);
    }
	
	BW.LastFireTime = Level.TimeSeconds;

    // client
    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else // server
        ServerPlayFiring();

	NextFireTime += FireRate;
	NextFireTime = FMax(NextFireTime, Level.TimeSeconds);

    Load = AmmoPerFire;
    HoldTime = 0;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

	BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
}

defaultproperties
{
	 FireRate=1.000000
	 TraceRange=(Min=15000.000000,Max=20000.000000)
     WallPenetrationForce=128.000000
     Damage=55.000000
     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBP_APC_Pro.DTZX98Gauss'
     DamageTypeHead=Class'BWBP_APC_Pro.DTZX98GaussHead'
     DamageTypeArm=Class'BWBP_APC_Pro.DTZX98Gauss'
     PenetrateForce=512
     bPenetrate=True
     RunningSpeedThresh=1000.000000
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBP_APC_Pro.ZX98SFlashEmitter'
     FlashBone="tip"
     FlashScaleFactor=0.500000
     FireRecoil=180.000000
     FireChaos=0.032000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=64.000000
     YInaccuracy=64.000000
	 AmmoPerFire=4
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.M30A2.M50A2-SilenceFire',Volume=6.700000)
     bPawnRapidFireAnim=True
	 FireAnim="ChargedFire"
     PreFireAnim=
     FireEndAnim=
     AmmoClass=Class'BWBP_APC_Pro.Ammo_ZX98'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
