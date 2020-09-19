//=============================================================================
// GRS9SecondaryFire.
//
// Burning laser fire that fires while altfire is held. Uses a special recharging
// ammo counter with a small limiting delay after releasing fire.
// Switches on weapon's laser sight when firing for effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRS9SecondaryFire extends BallisticProInstantFire;

var() sound		FireSoundLoop;
var   float		StopFireTime;
var   bool		bLaserFiring;

simulated function bool AllowFire()
{
	if (level.TimeSeconds - StopFireTime < 0.8 || GRS9Pistol(Weapon).LaserAmmo <= 0 || !super.AllowFire())
	{
		if (bLaserFiring)
			StopFiring();
		return false;
	}
	return true;
}

simulated function bool HasAmmo()
{
	return GRS9Pistol(Weapon).LaserAmmo > 0;
}

simulated function bool CheckWeaponMode()
{
	if (Weapon.IsInState('DualAction') || Weapon.IsInState('PendingDualAction'))
		return false;
	return true;
}

function DoFireEffect()
{
	GRS9Pistol(Weapon).LaserAmmo -= 0.15;
	GRS9Pistol(Weapon).ServerSwitchLaser(true);
	bLaserFiring=true;
	super.DoFireEffect();
}

function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		FireAnim = 'OpenIdle';
	}
	else
	{
		FireAnim = 'Idle';
	}
	super.PlayFiring();
	if (FireSoundLoop != None)
		Instigator.AmbientSound = FireSoundLoop;
	bLaserFiring=true;
}

function StopFiring()
{
	bLaserFiring=false;
	Instigator.AmbientSound = None;
	GRS9Pistol(Weapon).ServerSwitchLaser(false);
	StopFireTime = level.TimeSeconds;
}

simulated event ModeDoFire()
{
	if (GRS9Pistol(Weapon).bBigLaser)
		BallisticFireSound.Sound = default.BallisticFireSound.Sound;
	else
		BallisticFireSound.Sound = None;
	super.ModeDoFire();
}

simulated function FireRecoil ()
{
	if (BW != None)
		BW.AddRecoil(RecoilPerShot, ThisModeNum);
}

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	BallisticWeapon(Weapon).TargetedHurtRadius(7, 20, class'DTGRS9Laser', 0, HitLocation, Pawn(Other));
	return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}

defaultproperties
{
     FireSoundLoop=Sound'BWBP4-Sounds.Glock.Glk-LaserBurn'
     WaterRangeFactor=0.700000
     Damage=10.000000
     DamageHead=10.000000
     DamageLimb=10.000000
     DamageType=Class'BallisticDE.DTGRS9Laser'
     DamageTypeHead=Class'BallisticDE.DTGRS9LaserHead'
     DamageTypeArm=Class'BallisticDE.DTGRS9Laser'
     PenetrateForce=200
     bPenetrate=True
     bUseWeaponMag=False
     FlashBone="Laser"
     FireChaos=0.000000
     XInaccuracy=2.000000
     YInaccuracy=2.000000
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.Glock.Glk-LaserFire')
     FireAnim="Idle"
     FireRate=0.080000
     AmmoClass=Class'BallisticDE.Ammo_GRSNine'
     AmmoPerFire=0
     BotRefireRate=0.999000
     WarnTargetPct=0.010000
     aimerror=900.000000
}
