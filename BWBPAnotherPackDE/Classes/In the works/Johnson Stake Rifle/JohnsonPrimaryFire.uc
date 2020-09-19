//  =============================================================================
//   JohnsonPrimaryFire.
//  
//   Powerful projectile attack.
//  
//  =============================================================================
class JohnsonPrimaryFire extends BallisticInstantFire;


defaultproperties
{
     TraceRange=(Min=5500.000000,Max=7000.000000)
     WaterRangeFactor=0.300000
     MaxWallSize=4.000000
     MaxWalls=1
     Damage=80
     DamageHead=145
     DamageLimb=60
     RangeAtten=1.000000
     WaterRangeAtten=0.600000
     DamageType=Class'BWBPAnotherPackDE.DTBulldog'
     DamageTypeHead=Class'BWBPAnotherPackDE.DTBulldogHead'
     DamageTypeArm=Class'BWBPAnotherPackDE.DTBulldog'
     KickForce=35000
     PenetrateForce=250
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     bDryUncock=True
     MuzzleFlashClass=Class'BallisticDE.M925FlashEmitter'
     FlashScaleFactor=1.100000
     BrassClass=Class'BWBPAnotherPackDE.Brass_BOLT'
     BrassBone="ejector"
     BrassOffset=(X=-30.000000,Y=1.000000)
     RecoilPerShot=2048.000000
     VelocityRecoil=200.000000
//     FireChaos=10.000000
     FireRate=0.550000
     FireAnimRate=1.5
     XInaccuracy=16.500000
     YInaccuracy=9.500000
     BallisticFireSound=(Sound=SoundGroup'PackageSounds5A.Johnson.Johnson-Fire',Volume=7.500000)
     FireEndAnim=
     TweenTime=0.000000
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_75BOLT'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
