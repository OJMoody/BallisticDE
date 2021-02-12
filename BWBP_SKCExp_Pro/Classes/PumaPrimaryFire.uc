//=============================================================================
// PumaSecondaryFire.
//
// A grenade that bonces off walls and detonates a certain time after impact
// Good for scaring enemies out of dark corners and not much else
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PumaPrimaryFire extends BallisticProProjectileFire;

var() class<Projectile> LastProjectileClass;
var float ModifiedDetonateDelay; //For manual distance det

simulated event ModeDoFire()
{

	if (!AllowFire())
		return;

	if (PumaRepeater(Weapon).bShieldUp)
		ProjectileClass=Class'PumaProjectileClose';
	else
		ProjectileClass=LastProjectileClass;
	
		super.ModeDoFire();

}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	local float DetonateDelay;

	Proj = Spawn (ProjectileClass,,, Start, Dir);
	Proj.Instigator = Instigator;
	if (PumaProjectileRShort(Proj) != None)
	{

		if (ModifiedDetonateDelay != default.ModifiedDetonateDelay)
			DetonateDelay = ModifiedDetonateDelay;
		else
			DetonateDelay = PumaProjectileRShort(Proj).DetonateDelay;
//		PumaProjectileRShort(Proj).InitProgramming(DetonateDelay);
		PumaProjectileRShort(Proj).NewDetonateDelay= FMax(DetonateDelay,0.1);
	}
}


function SetDet(float DetDist)
{ 
//	log("Range:"$ModifiedDetonateDelay);
	ModifiedDetonateDelay=DetDist;
}



simulated function AdjustProps(byte NewMode)
{
	if (NewMode == 2) //Range
	{
		if (PumaRepeater(Weapon).PriDetRangeM < 30)
			FireRate=0.900000;
		else
			FireRate=0.450000;
	}
	else if (NewMode == 1)//Proximity
	{
		
		FireRate=0.900000;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.50;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

}

simulated function SwitchCannonMode (byte NewMode)
{
	if (NewMode == 2) //Range
	{
		ProjectileClass=Class'PumaProjectileRShort';
		LastProjectileClass=Class'PumaProjectileRShort';
		if (PumaRepeater(Weapon).PriDetRangeM < 30)
		FireRate=0.900000;
		else
		FireRate=0.450000;
	}
	else if (NewMode == 1)//Proximity
	{
		ProjectileClass=Class'PumaProjectile';
		LastProjectileClass=Class'PumaProjectile';
		FireRate=0.900000;
	}
	else if (NewMode == 0)//Off
	{
		ProjectileClass=Class'PumaProjectileFast';
		LastProjectileClass=Class'PumaProjectileFast';
		FireRate=0.450000;
	}
	else
	{
		ProjectileClass=Class'PumaProjectile';
		LastProjectileClass=Class'PumaProjectile';
		FireRate=0.900000;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.50;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

	Load=AmmoPerFire;
}

function StartBerserk()
{

	if (BW.CurrentWeaponMode == 1)
    	FireRate = 0.90;
	else
    	FireRate = 0.45;
   	FireRate *= 0.50;
    FireAnimRate = default.FireAnimRate/0.75;
    ReloadAnimRate = default.ReloadAnimRate/0.75;
}

function StopBerserk()
{

	if (BW.CurrentWeaponMode == 1)
    	FireRate = 0.95;
	else
    	FireRate = 0.45;
    FireAnimRate = default.FireAnimRate;
    ReloadAnimRate = default.ReloadAnimRate;
}

function StartSuperBerserk()
{

	if (BW.CurrentWeaponMode == 1)
    	FireRate = 0.95;
	else
    	FireRate = 0.45;
    FireRate /= Level.GRI.WeaponBerserk;
    FireAnimRate = default.FireAnimRate * Level.GRI.WeaponBerserk;
    ReloadAnimRate = default.ReloadAnimRate * Level.GRI.WeaponBerserk;
}

defaultproperties
{
     LastProjectileClass=Class'BWBP_SKCExp_Pro.PumaProjectile'
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     BrassClass=Class'BWBP_SKCExp_Pro.Brass_PUMA'
     BrassOffset=(X=-20.000000)
     FireRecoil=128.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_SoundsExp.PUMA.PUMA-Fire')
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bModeExclusive=False
     FireForce="AssaultRifleAltFire"
     FireRate=0.9500000
	 AimedFireAnim="SightFire"
     AmmoClass=Class'BWBP_SKCExp_Pro.Ammo_20mmPuma'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_SKCExp_Pro.PumaProjectile'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
	 FireChaos=0.5
	 XInaccuracy=32.000000
     YInaccuracy=32.000000
}
