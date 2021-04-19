//=============================================================================
// AY90PrimaryFire.
//
// Uncharged: Projectile with gravity that sticks and explodes after impact
// Charged: Instant hit that spawns sticky projectile with timed explosion
// Full Charge: Instant hit and instant explosion
//
// by Sarge based on code by RS and Jiffy
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90PrimaryFire extends BallisticProjectileFire;
var() float ChargeTime;
var() Sound	ChargeSound;
var() float AutoFireTime;

var() sound		ChargeFireSound;
var() sound		MaxChargeFireSound;

simulated function PlayPreFire()
{
	Weapon.AmbientSound = ChargeSound;
	//if (!BW.bScopeView)
		BW.SafeLoopAnim('PreFire', 0.15, TweenTime, ,"IDLE");
}

simulated event ModeDoFire()
{

	if (HoldTime >= ChargeTime && AY90SkrithBoltcaster(BW).MagAmmo >= 20)
	{
		ProjectileClass=Class'AY90TestProjectile';
//		AmmoPerFire=30;
		BallisticFireSound.Sound=MaxChargeFireSound;
	}
	else if (HoldTime >= (ChargeTime/2) && AY90SkrithBoltcaster(BW).MagAmmo >= 10)
	{
		ProjectileClass=Class'HVPCMk5Projectile';
//		AmmoPerFire=15;
		BallisticFireSound.Sound=ChargeFireSound;
	}
	else
	{
		ProjectileClass=default.ProjectileClass;
		AmmoPerFire=default.AmmoPerFire;
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
	}

	Weapon.AmbientSound = None;
	super.ModeDoFire();
	
	
	ProjectileClass=default.ProjectileClass;
	AmmoPerFire=default.AmmoPerFire;
	BallisticFireSound.Sound=default.BallisticFireSound.Sound;
	
}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);

    if (bIsFiring && HoldTime >= AutoFireTime)
    {
        Weapon.StopFire(ThisModeNum);
		Weapon.AmbientSound = None;
    }
}

defaultproperties
{
     ChargeTime=4.000000
     AutoFireTime=5.000000
     ChargeSound=Sound'BWBP_SKC_SoundsExpX.SkrithBow.SkrithBow-BoltCharge'
     ChargeFireSound=Sound'BWBP_SKC_SoundsExpX.SkrithBow.SkrithBow-BoltBlast'
     MaxChargeFireSound=Sound'BWBP_SKC_SoundsExpX.SkrithBow.SkrithBow-BoltBlastMax'
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BWBP_SKCExp_Pro.A73BFlashEmitter'
     //RecoilPerShot=256.000000
     //XInaccuracy=9.000000
     //YInaccuracy=6.000000
     AmmoPerFire=5
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_SoundsExpX.SkrithBow.SkrithBow-BoltFire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	      bFireOnRelease=True
     FireEndAnim=
     TweenTime=0.000000
     FireRate=1.000000
     AmmoClass=Class'BallisticProV55.Ammo_Cells'
     ShakeRotMag=(X=32.000000,Y=10.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.750000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.750000
     ProjectileClass=Class'BWBP_SKCExp_Pro.AY90BoltProjectile'
     WarnTargetPct=0.200000
}
