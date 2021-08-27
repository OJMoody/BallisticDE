//=============================================================================
// G5PrimaryFire.
//
// Rocket launching primary fire for G5
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RGPXSecondaryFire extends BallisticProProjectileFire;

defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     MuzzleFlashClass=Class'BWBP_JCF_Pro.RGPXFlashEmitter'
     FireRecoil=64.000000
     FireChaos=0.500000
     XInaccuracy=4.000000
     YInaccuracy=4.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Fire1')
     FireEndAnim=
     FireRate=0.800000
	 FlashScaleFactor=2.000000
	 FlashBone='tip2'
     AmmoClass=Class'BallisticProV55.Ammo_RPG'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.500000
     ProjectileClass=Class'BWBP_JCF_Pro.RGPXFlakGrenade'
	 
	 // AI
	 bInstantHit=False
	 bLeadTarget=True
	 bTossed=False
	 bSplashDamage=True
	 bRecommendSplashDamage=True
	 BotRefireRate=0.5
     WarnTargetPct=0.8
}
