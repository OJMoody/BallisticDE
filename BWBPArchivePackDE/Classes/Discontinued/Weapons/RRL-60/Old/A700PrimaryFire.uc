//=============================================================================
// G5PrimaryFire.
//
// Rocket launching primary fire for G5
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A700PrimaryFire extends BallisticProProjectileFire;

var() class<Actor>	HatchSmokeClass;
var   Actor			HatchSmoke;
var() Sound			SteamSound;

simulated function bool AllowFire()
{
    return Super.AllowFire();
}

simulated event ModeDoFire()
{
    if (!AllowFire())
        return;

	if (class'BallisticReplicationInfo'.default.bNoReloading && BW.AmmoAmount(0) > 1)
	{
		Weapon.SetBoneScale (0, 1.0, 'RocketBone');
		Weapon.ThirdPersonActor.SetBoneScale (0, 1.0, 'RocketBone');
	}
	else if (BW.MagAmmo < 2)
	{
		Weapon.SetBoneScale (0, 0.0, 'RocketBone');
		Weapon.ThirdPersonActor.SetBoneScale (0, 0.0, 'RocketBone');
	}
	Super.ModeDoFire();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	Proj.Instigator = Instigator;

}

defaultproperties
{
     HatchSmokeClass=Class'BallisticDE.G5HatchEmitter'
     SteamSound=Sound'BallisticSounds2.G5.G5-Steam'
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     bCockAfterFire=True
     MuzzleFlashClass=Class'BWBPArchivePackDE.A700FlashEmitter'
     RecoilPerShot=64.000000
     XInaccuracy=128.000000
     YInaccuracy=128.000000
	 FireChaos=0.2
     BallisticFireSound=(Sound=Sound'BWSkrithRecolors2Sounds.SkrithRL.rocket_fire2')
     bSplashDamage=True
     bRecommendSplashDamage=True
     FireEndAnim=
     TweenTime=0.000000
     FireRate=0.800000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_A700Rockets'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.500000
     ProjectileClass=Class'BWBPArchivePackDE.A700Rocket'
     BotRefireRate=0.500000
     WarnTargetPct=0.300000
}
