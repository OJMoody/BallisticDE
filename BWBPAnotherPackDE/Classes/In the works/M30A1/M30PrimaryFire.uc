//=============================================================================
// CYLOPrimaryFire.
//
// For some really odd reason my UDE isn't liking the class names, so I have to
// change the names for UDE to recognize them every once in a while...
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M30PrimaryFire extends BallisticRangeAttenFire;

simulated function PostNetBeginPlay()
{
	FireRate = M30AssaultRifle(BW).BaseFireRate;
	super.PostNetBeginPlay();
}

//fire rate will accelerate with each shot
simulated function ModeDoFire()
{
	FireRate = FMax(M30AssaultRifle(BW).BaseFireRate - (M30AssaultRifle(BW).DecreasePerFire * FireCount), M30AssaultRifle(BW).DesiredFireRate);
	M30AssaultRifle(BW).SetRotationSpeeds(FireRate);
	
	if (M30AssaultRifle(BW).ModeSpinning != 0)
			M30AssaultRifle(BW).ModeSpinning = 0;

	super.ModeDoFire();
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
	 FireRate=0.270000
	 
     CutOffDistance=3072.000000
     CutOffStartRange=1280.000000
     TraceRange=(Min=8000.000000,Max=12000.000000)
     WallPenetrationForce=24.000000
     
     Damage=28.000000
     DamageHead=56.000000
     DamageLimb=28.000000
     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DTCYLORifle'
     DamageTypeHead=Class'BWBPRecolorsPro.DTCYLORifleHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTCYLORifle'
     PenetrateForce=180
     bPenetrate=True
     RunningSpeedThresh=1000.000000
     ClipFinishSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashBone="tip"
     FlashScaleFactor=0.500000
     RecoilPerShot=180.000000
     FireChaos=0.032000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=64.000000
     YInaccuracy=64.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.M50A2.M50A2-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
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
