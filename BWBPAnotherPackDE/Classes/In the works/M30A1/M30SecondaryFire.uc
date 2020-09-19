//=============================================================================
// CYLOPrimaryFire.
//
// For some really odd reason my UDE isn't liking the class names, so I have to
// change the names for UDE to recognize them every once in a while...
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M30SecondaryFire extends BallisticProInstantFire;

var		float 	ChargePower, ChargeGainPerSecond;
var()	Name	ChargeAnim;

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, true, WaterHitLoc);
}


simulated function PlayStartHold()
{	
	BW.SafeLoopAnim(ChargeAnim, 1.0, TweenTime, ,"IDLE");
}

simulated event ModeDoFire()
{
	if (ChargePower >= 1 && !M30AssaultRifle(BW).bLockFire)
	{
		super.ModeDoFire();
		
		if (M30AssaultRifle(BW).ModeSpinning != 0)
			M30AssaultRifle(BW).ModeSpinning = 0;
	}
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim.bProjTarget)
	{
		if (BallisticShield(Victim) != None)
			BW.TargetedHurtRadius(Damage, 20, DamageType, 200, HitLocation, Pawn(Victim));
		else
			BW.TargetedHurtRadius(Damage, 80, DamageType, 200, HitLocation, Pawn(Victim));
	}
}

simulated function ModeTick(float dt)
{
	if (bIsFiring && !M30AssaultRifle(BW).bLockFire)
	{
		ChargePower = FMin(1, ChargePower + ChargeGainperSecond * dt);
		M30AssaultRifle(BW).SetRotationSpeeds(M30AssaultRifle(BW).BaseFireRate - ((M30AssaultRifle(BW).BaseFireRate - M30AssaultRifle(BW).DesiredFireRate)*ChargePower));
		
		if (M30AssaultRifle(BW).ModeSpinning != 1)
			M30AssaultRifle(BW).ModeSpinning = 1;
		
		if (ChargePower >= 1)
			bIsFiring = false;
	}
	else if (ChargePower > 0)
	{
		ChargePower = 0;
		if (M30AssaultRifle(BW).ModeSpinning != 0)
			M30AssaultRifle(BW).ModeSpinning = 0;
	}

	super.ModeTick(dt);
}

simulated function bool AllowFire()
{
	if (M30AssaultRifle(BW).bLockFire)
		return false;
	
	if (!super.AllowFire())
		return false;
		
	return true;
}

defaultproperties
{
	 ChargeAnim="ChargingUp"
	 ChargeGainPerSecond=1.8f
	 TraceRange=(Min=15000.000000,Max=20000.000000)
     WallPenetrationForce=128.000000
     Damage=80.000000
     DamageHead=135.000000
     DamageLimb=60.000000
     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DTCYLORifle'
     DamageTypeHead=Class'BWBPRecolorsPro.DTCYLORifleHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTCYLORifle'
     PenetrateForce=512
     bPenetrate=True
     RunningSpeedThresh=1000.000000
     ClipFinishSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBPRecolorsPro.M2020FlashEmitter'
     FlashBone="tip"
     FlashScaleFactor=0.500000
     RecoilPerShot=180.000000
     FireChaos=0.032000
	 bFireOnRelease=True
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=64.000000
     YInaccuracy=64.000000
	 FireRate=0.700000
	 AmmoPerFire=8
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.M50A2.M50A2-SilenceFire',Volume=6.700000)
     bPawnRapidFireAnim=True
	 FireAnim="ChargedFire"
     PreFireAnim=
     FireEndAnim=
     AmmoClass=Class'BWBPRecolorsPro.Ammo_CYLO'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
