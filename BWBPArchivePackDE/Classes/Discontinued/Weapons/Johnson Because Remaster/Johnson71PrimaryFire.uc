//=============================================================================
// FLASHPrimaryFire.
//
// A buring rocket that streaks through the air like a flaming man sans clothes
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Johnson71PrimaryFire extends BallisticProjectileFire;

var() class<Actor>	HatchSmokeClass;
var   Actor			HatchSmoke;
var() Sound			SteamSound;

defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     MuzzleFlashClass=Class'BallisticDE.G5FlashEmitter'
	 FlashBone="Muzzle"
	 FlashScaleFactor=0.100000
     RecoilPerShot=1024.000000
     XInaccuracy=400.000000
     YInaccuracy=400.000000
	 FireChaos=0.4
     BallisticFireSound=(Sound=Sound'PackageSounds4A.Flash.M202-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bSplashDamage=True
     bRecommendSplashDamage=True
	 AimedFireAnim="SightFire"
     TweenTime=0.000000
     FireRate=0.700000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_Johnson71'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-50.000000)
     ShakeOffsetRate=(X=-2000.000000)
     ShakeOffsetTime=5.000000
     ProjectileClass=Class'BWBPArchivePackDE.Johnson71Projectile'
     BotRefireRate=0.500000
     WarnTargetPct=0.300000
}
