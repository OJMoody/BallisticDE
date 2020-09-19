//=============================================================================
// G5PrimaryFire.
//
// Rocket launching primary fire for G5
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RGPPrimaryFire extends BallisticProProjectileFire;


simulated function bool AllowFire()
{
//    if (Instigator.Base != none && VSize(Instigator.velocity - Instigator.base.velocity) > 220)
//    	return false;
//  if (BW.AimOffset!=rot(0,0,0))
//	{
//	bFireOnRelease=true;
//	return false;
//	}

    return super.AllowFire();
}

/*simulated event ModeDoFire()
{
    if (!AllowFire())
        return;

	if (class'BallisticReplicationInfo'.default.bNoReloading && BW.AmmoAmount(0) > 1)
		Weapon.SetBoneScale (0, 1.0, 'Rocket');
	else if (BW.MagAmmo < 2)
		Weapon.SetBoneScale (0, 0.0, 'Rocket');
	Super.ModeDoFire();
}*/

defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     MuzzleFlashClass=Class'BWBPArchivePackDE.RGPFlashEmitter'
     RecoilPerShot=64.000000
     XInaccuracy=64.000000
     YInaccuracy=64.000000
	 Firechaos=0.5
	 AimedFireAnim="SightFire"
     BallisticFireSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.RPG.Fire',Volume=450.500000)
     bSplashDamage=False
     bRecommendSplashDamage=True
     FireRate=0.800000
	 FlashScaleFactor=0.250000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_RPG'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.500000
     ProjectileClass=Class'BWBPArchivePackDE.RGPRock'
     BotRefireRate=0.500000
     WarnTargetPct=0.300000
}
