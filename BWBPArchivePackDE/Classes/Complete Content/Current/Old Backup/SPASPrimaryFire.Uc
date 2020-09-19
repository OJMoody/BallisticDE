//=============================================================================
// M763PrimaryFire.
//
// Powerful shotgun blast with moderate spread and fair range for a shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SPASPrimaryFire extends BallisticProShotgunFire;


simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
     AmmoPerFire=2
	 HipSpreadFactor=3.000000
	 MaxSpreadFactor=3.500000
     CutOffDistance=2536.000000
     CutOffStartRange=1280.000000
     TraceCount=12
     TracerClass=Class'BallisticDE.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticDE.IM_Shell'
     TraceRange=(Min=4000.000000,Max=6000.000000)
     Damage=10.000000
     DamageHead=10.000000
     DamageLimb=10.000000
     RangeAtten=0.300000
     DamageType=Class'BWBPArchivePackDE.DTSPASShotgun'
     DamageTypeHead=Class'BWBPArchivePackDE.DTSPASShotgunHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTSPASShotgun'
     KickForce=5000
     PenetrateForce=100
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticDE.MRT6FlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticDE.Brass_Shotgun'
     bBrassOnCock=True
     RecoilPerShot=240.000000
	 VelocityRecoil=180.000000
     FireChaos=0.500000
     XInaccuracy=150.000000
     YInaccuracy=150.000000
     BallisticFireSound=(Sound=Sound'BWWeaponPack2-Sounds.DE.Fire_SPAS_Cock',Volume=1.500000)
     FireEndAnim=
     FireRate=0.80000
     AmmoClass=Class'BallisticDE.Ammo_12Gauge'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.500000
}
