//=============================================================================
// GRSXXPrimaryFire.
//
// Med power, med range, low recoil pistol fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MP44SecondaryFire extends BallisticInstantFire;

defaultproperties
{
     TraceRange=(Max=6500.000000)
     WaterRangeFactor=0.600000
     MaxWallSize=32.000000
     MaxWalls=2
     Damage=(Min=25.000000,Max=45.000000)
     DamageHead=(Min=75.000000,Max=95.000000)
     DamageLimb=(Min=10.000000,Max=15.000000)
     WaterRangeAtten=0.500000
     DamageType=Class'BWBPArchivePackDE.DT_MP44Assault'
     DamageTypeHead=Class'BWBPArchivePackDE.DT_MP44AssaultHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DT_MP44Assault'
     KickForce=15000
     PenetrateForce=150
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticDE.XK2FlashEmitter'
     BrassClass=Class'BallisticDE.Brass_Pistol'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     RecoilPerShot=320.000000
     FireChaos=0.300000
     XInaccuracy=2.500000
     YInaccuracy=7.500000
     BallisticFireSound=(Sound=Sound'PackageSounds4.PK2000.PK2000-Fire',Volume=1.200000)
     bModeExclusive=False
     FireAnim="SightFire"
     FireEndAnim=
     TweenTime=0.000000
     FireRate=0.070000
     AmmoClass=Class'BallisticDE.Ammo_45HV'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.300000
     WarnTargetPct=0.100000
}
