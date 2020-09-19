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
class MP44PrimaryFire extends BallisticInstantFire;

defaultproperties
{
     TraceRange=(Min=12000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=70.000000
     MaxWalls=4
     Damage=(Min=25.000000,Max=35.000000)
     DamageHead=(Min=90.000000,Max=110.000000)
     DamageLimb=(Min=15.000000,Max=20.000000)
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPArchivePackDE.DT_MP44Assault'
     DamageTypeHead=Class'BWBPArchivePackDE.DT_MP44AssaultHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DT_MP44Assault'
     KickForce=22000
     PenetrateForce=180
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticDE.M50FlashEmitter'
     FlashScaleFactor=0.300000
     BrassClass=Class'BallisticDE.Brass_Rifle'
     BrassBone="tip"
     BrassOffset=(X=-80.000000,Y=1.000000)
     RecoilPerShot=200.000000
     XInaccuracy=1.200000
     YInaccuracy=4.300000
     BallisticFireSound=(Sound=SoundGroup'PackageSounds4.MP44.MP44-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireAnim="SightFire"
     FireEndAnim=
     TweenTime=0.000000
     FireRate=0.150000
     AmmoClass=Class'BallisticDE.Ammo_RS762mm'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
