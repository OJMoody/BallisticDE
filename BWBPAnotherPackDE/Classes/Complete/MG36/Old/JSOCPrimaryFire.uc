//=============================================================================
// M154PrimaryFire.
//
// Very automatic, bullet style instant hit. Shots are long ranged, powerful
// and accurate when used carefully. The dissadvantages are severely screwed up
// accuracy after firing a shot or two and the rapid rate of fire means ammo
// dissapeares quick.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class JSOCPrimaryFire extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=12000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=32.000000
     MaxWalls=3
     Damage=18
     DamageHead=24
     DamageLimb=14
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPArchivePackDE.DT_MG33LMG'
     DamageTypeHead=Class'BWBPArchivePackDE.DT_MG33LMGHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DT_MG33LMG'
     KickForce=20000
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticDE.M50FlashEmitter'
     FlashScaleFactor=0.800000
     BrassClass=Class'BallisticDE.Brass_Rifle'
     BrassBone="tip"
     BrassOffset=(X=-80.000000,Y=1.000000)
     RecoilPerShot=128.000000
     XInaccuracy=16.000000
     YInaccuracy=16.000000
	 FireChaos=0.2
     BallisticFireSound=(Sound=Sound'PackageSounds4A.JSOC.JSOC-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.085000
     AmmoClass=Class'BallisticDE.Ammo_556mm'
     ShakeRotMag=(X=128.000000,Y=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
