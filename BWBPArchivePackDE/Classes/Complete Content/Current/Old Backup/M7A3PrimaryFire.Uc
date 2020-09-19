//=============================================================================
// SARPrimaryFire.
//
// Average power, 600RpM, rifle range, low accuracy assault rifle fire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class M7A3PrimaryFire extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=10000.000000,Max=12000.000000)
     WaterRangeFactor=0.800000
     Damage=18.000000
     DamageHead=24.000000
     DamageLimb=14.000000
     RangeAtten=0.800000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPArchivePackDE.DTM7A3Rifle'
     DamageTypeHead=Class'BWBPArchivePackDE.DTM7A3RifleHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTM7A3Rifle'
     KickForce=10000
     PenetrateForce=450
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBPArchivePackDE.M7A3FlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BWBPArchivePackDE.Brass_M7A3AR'
     BrassBone="tip"
     BrassOffset=(X=-105.000000,Y=-10.000000,Z=-1.000000)
     RecoilPerShot=60.000000
     FireChaos=0.10000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     BallisticFireSound=(Sound=Sound'BWWeaponPack2-Sounds.M7A3.Fire_M7A3',Volume=1.200000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.090000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_447mm'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-300.000000)
     ShakeOffsetTime=1.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
