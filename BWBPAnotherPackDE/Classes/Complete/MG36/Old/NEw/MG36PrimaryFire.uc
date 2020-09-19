//=============================================================================
// MARSPrimaryFire.
//
// Very automatic, bullet style instant hit. Shots have medium range and good
// power. Accuracy and ammo goes quickly with its faster than normal rate of fire.
//
// Has damage drop off due to shorter barrel.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MG36PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=8144.000000
     CutOffStartRange=4096.000000
     TraceRange=(Min=15000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=32.000000
     MaxWalls=2
     Damage=25.000000
     DamageHead=40.000000
     DamageLimb=22.000000
     RangeAtten=0.600000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPArchivePackDE.DT_MG36Assault'
     DamageTypeHead=Class'BWBPArchivePackDE.DT_MG36AssaultHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DT_MG36Assault'
     PenetrateForce=150
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBPArchivePackDE.MG36FlashEmitter'
     FlashScaleFactor=0.250000
     BrassClass=Class'BallisticDE.Brass_MG'
     BrassOffset=(X=-80.000000,Y=1.000000)
     RecoilPerShot=150.000000
     FireChaos=0.075000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-RapidFire',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.090000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_545mmSTANAG'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
