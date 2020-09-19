//=============================================================================
// R78PrimaryFire.
//
// Very accurate, long ranged and powerful bullet fire. Headshots are
// especially dangerous.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M99PrimaryFire extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=30000.000000,Max=30000.000000)
	 XInaccuracy=0
	 YInaccuracy=0
	 FireChaos=0.2
     WaterRangeFactor=0.800000
     Damage=125.000000
     DamageHead=250.000000
     DamageLimb=100.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPArchivePackDE.DTM99Rifle'
     DamageTypeHead=Class'BWBPArchivePackDE.DTM99RifleHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTM99Rifle'
     KickForce=95000
     PenetrateForce=50050
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticDE.M925FlashEmitter'
     BrassClass=Class'BWBPArchivePackDE.Brass_50BMG'
     bBrassOnCock=True
     BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
     RecoilPerShot=7000
     BallisticFireSound=(Sound=Sound'BWWeaponPack2-Sounds.M99.M99FireNew',Volume=10.00000)
     FireRate=2.000000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_50ECSRifle'
     ShakeRotMag=(X=400.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.300000
     WarnTargetPct=0.050000
}
