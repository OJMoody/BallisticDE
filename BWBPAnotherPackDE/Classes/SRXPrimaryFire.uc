//=============================================================================
// SRXPrimaryFire.
//
// Automatic fire. Battle rifle class - has a longer range and better accuracy than ARs, but main class has
// inferior hipfire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SRXPrimaryFire extends BallisticRangeAttenFire;

var() sound		SuperFireSound;
var() sound		MegaFireSound;
var() sound		ExtraFireSound;
var() sound		SilentFireSound;
var() sound		BlackFireSound;

var() sound		Amp1FireSound; //Incendiary Red
var() sound		Amp2FireSound; //???
var() sound		RegularFireSound;
var bool		bFlashAmp1;
var bool		bFlashAmp2;
var() Actor						MuzzleFlashAmp1;		
var() class<Actor>				MuzzleFlashClassAmp1;	
var() Actor						MuzzleFlashAmp2;		
var() class<Actor>				MuzzleFlashClassAmp2;	
var() Name						AmpFlashBone;
var() float						Amp1FlashScaleFactor, Amp2FlashScaleFactor;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>				SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;

simulated function bool AllowFire()
{
	if (level.TimeSeconds < SRXRifle(Weapon).SilencerSwitchTime || level.TimeSeconds < SRXRifle(Weapon).AmplifierSwitchTime)
		return false;
		
	return super.AllowFire();
}

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((SMuzzleFlashClass != None) && ((SMuzzleFlash == None) || SMuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (SMuzzleFlash, SMuzzleFlashClass, Weapon.DrawScale*SFlashScaleFactor, weapon, SFlashBone);
	if ((MuzzleFlashClassAmp1 != None) && ((MuzzleFlashAmp1 == None) || MuzzleFlashAmp1.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp1, MuzzleFlashClassAmp1, Weapon.DrawScale*Amp1FlashScaleFactor, weapon, FlashBone);
    if ((MuzzleFlashClassAmp2 != None) && ((MuzzleFlashAmp2 == None) || MuzzleFlashAmp2.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp2, MuzzleFlashClassAmp2, Weapon.DrawScale*Amp2FlashScaleFactor, weapon, FlashBone);
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
		
    if (SRXRifle(Weapon).bSilenced && SMuzzleFlash != None)
        SMuzzleFlash.Trigger(Weapon, Instigator);
    else if (MuzzleFlashAmp1 != None && bFlashAmp1)
       	MuzzleFlashAmp1.Trigger(Weapon, Instigator);
    else if (MuzzleFlashAmp2 != None && bFlashAmp2)
        MuzzleFlashAmp2.Trigger(Weapon, Instigator);
	else
		MuzzleFlash.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();
	class'BUtil'.static.KillEmitterEffect (SMuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashAmp1);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashAmp2);
}

simulated function SwitchWeaponMode (byte NewMode)
{
	if (NewMode == 0) //Standard Fire
	{
		BallisticFireSound.Sound=default.BallisticFireSound.sound;
		BallisticFireSound.Volume=default.BallisticFireSound.Volume;
		FireRecoil=default.FireRecoil;
		Damage = default.Damage;
		DamageType=default.DamageType;
		DamageTypeHead=default.DamageTypeHead;
		DamageTypeArm=default.DamageTypeArm;
		FireRate=Default.FireRate;
		FlashScaleFactor=default.FlashScaleFactor;
		bFlashAmp1=false;
		bFlashAmp2=false;
		RangeAtten=default.RangeAtten;
	}
	else if (NewMode == 3) //Incendiary Amp
	{
		BallisticFireSound.Sound=Amp1FireSound;
		BallisticFireSound.Volume=1.500000;
		FireRecoil=512.000000;
		Damage=50.000000;
		DamageType=class'DTSRXRifle_Incendiary';
		DamageTypeHead=class'DTSRXRifleHead_Incendiary';
		DamageTypeArm=class'DTSRXRifle_Incendiary';
		FireRate=0.280000;
		FlashScaleFactor=1.100000;
		bFlashAmp1=true;
		bFlashAmp2=false;
		RangeAtten=1.000000;
	}
	else if (NewMode == 4) //Acid Amp
	{
		BallisticFireSound.Sound=Amp2FireSound;
		BallisticFireSound.Volume=1.200000;
		FireRecoil=128.000000;
		Damage=20.000000;
		DamageType=class'DTSRXRifle_Corrosive';
		DamageTypeHead=class'DTSRXRifleHead_Corrosive';
		DamageTypeArm=class'DTSRXRifle_Corrosive';
		FireRate=0.120000;
		FlashScaleFactor=0.400000;
		bFlashAmp1=false;
		bFlashAmp2=true;
		RangeAtten=1.000000;
	}
	else
	{
		BallisticFireSound.Sound=default.BallisticFireSound.sound;
		BallisticFireSound.Volume=default.BallisticFireSound.Volume;
		FireRecoil=default.FireRecoil;
		Damage = default.Damage;
		DamageType=default.DamageType;
		DamageTypeHead=default.DamageTypeHead;
		DamageTypeArm=default.DamageTypeArm;
		FireRate=Default.FireRate;
		FlashScaleFactor=default.FlashScaleFactor;
		bFlashAmp1=false;
		bFlashAmp2=false;
		RangeAtten=default.RangeAtten;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

}

//Disable fire anim when scoped
function PlayFiring()
{
	if (SRXRifle(Weapon).bSilenced)
	{
		//SRXRifle(Weapon).StealthImpulse(0.3);
		Weapon.SetBoneScale (0, 1.0, SRXRifle(Weapon).SilencerBone);
	}
	else
	{
		Weapon.SetBoneScale (0, 0.0, SRXRifle(Weapon).SilencerBone);
	}
    if (ScopeDownOn == SDO_Fire)
        BW.TemporaryScopeDown(0.5, 0.9);
        
    if (AimedFireAnim != '')
    {
        BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
        if (BW.BlendFire())        
            BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
    }

    else
    {
        if (FireCount == 0 && Weapon.HasAnim(FireLoopAnim))
            BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
        else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    }
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (SRXRifle(Weapon) != None && SRXRifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (SRXRifle(Weapon) != None && bFlashAmp1 && Amp1FireSound != None)
		Weapon.PlayOwnedSound(Amp1FireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
	else if (SRXRifle(Weapon) != None && bFlashAmp2 && Amp2FireSound != None)
		Weapon.PlayOwnedSound(Amp2FireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}

function SetSilenced(bool bSilenced)
{
	if (bSilenced)
	{
		FireRecoil *= 0.8;
		RangeAtten *= 1.2;
		XInaccuracy *= 0.75;
		YInaccuracy *= 0.75;

		BW.SightingTime = BW.default.SightingTime * 1.25;
	}
		
	else
	{
		FireRecoil = default.FireRecoil;
		RangeAtten = default.RangeAtten;
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;

		BW.SightingTime = BW.default.SightingTime;
	}
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim.bProjTarget && BallisticShield(Victim) == None && bFlashAmp1)
		BW.TargetedHurtRadius(Damage, 384, class'DTSRXRifle_Incendiary', 200, HitLocation, Pawn(Victim));
}

// Does something to make the effects appear
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;

	if ((!Other.bWorldGeometry && Mover(Other) == None && Pawn(Other) == None) || level.NetMode == NM_Client)
		return false;

	if (Vehicle(Other) != None)
		Surf = 3;
	else if (HitMat == None)
		Surf = int(Other.SurfaceType);
	else
		Surf = int(HitMat.SurfaceType);
		
	if ((Other == None || Other.bWorldGeometry) && bFlashAmp1)
		BW.TargetedHurtRadius(5, 150, class'DTSRXRifle_Incendiary', 50, HitLocation);

	// Tell the attachment to spawn effects and so on
	SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	if (!bAISilent)
		Instigator.MakeNoise(1.0);
	return true;
}

defaultproperties
{
     Amp1FireSound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-LoudFire'
     Amp2FireSound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-SpecialFire'
	 AmpFlashBone="tip2"
     Amp1FlashScaleFactor=0.100000
	 Amp2FlashScaleFactor=0.400000
	 
	 SMuzzleFlashClass=Class'BWBPAnotherPackDE.SRXSilencedFlash'
	 MuzzleFlashClassAmp1=Class'BWBPRecolorsDE.FG50FlashEmitter'
     MuzzleFlashClassAmp2=Class'BallisticDE.A500FlashEmitter'
     SFlashBone="tip2"
     SFlashScaleFactor=0.750000
     CutOffDistance=6144.000000
     CutOffStartRange=3072.000000
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WallPenetrationForce=24.000000
     
     Damage=36.000000
     HeadMult=1.4f
     LimbMult=0.8f
     
     RangeAtten=0.450000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPAnotherPackDE.DTSRXRifle'
     DamageTypeHead=Class'BWBPAnotherPackDE.DTSRXRifleHead'
     DamageTypeArm=Class'BWBPAnotherPackDE.DTSRXRifle'
     KickForce=2000
     PenetrateForce=120
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBPAnotherPackDE.SRXFlashEmitter'
     FlashScaleFactor=0.2500000
     BrassClass=Class'BallisticDE.Brass_Rifle'
     BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
     AimedFireAnim="SightFire"
     FireRecoil=160.000000
     FireChaos=0.065000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     SilencedFireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire2',Volume=0.500000,Radius=500.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire',Radius=1536.000000,Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.20000
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_SRXBullets'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=800.000000
	 BurstFireRateFactor=0.55
}
