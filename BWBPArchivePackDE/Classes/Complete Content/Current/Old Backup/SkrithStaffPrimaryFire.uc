//=============================================================================
// A73PrimaryFire.
//
// A73 primary fire is a fast moving projectile that goes through enemies and
// isn't hard to spot ITS ALSO A FIRE
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SkrithStaffPrimaryFire extends BallisticProProjectileFire;

var() sound		ChargeFireSound;
var() sound		PowerFireSound;

simulated event ModeTick(float DT)
{
	Super.ModeTick(DT);

	if (Weapon.SoundPitch != 36)
	{
		if (Instigator.DrivenVehicle!=None)
			Weapon.SoundPitch = 36;
		else
			Weapon.SoundPitch = Max(36, Weapon.SoundPitch - 8*DT);
	}
}

function PlayFiring()
{
	Super.PlayFiring();

	Weapon.SoundPitch = Min(120, Weapon.SoundPitch + 8);
}

simulated function SwitchCannonMode (byte NewMode)
{
    if (NewMode == 0)
    {
        ProjectileClass=Class'SkrithStaffProjectile';
        BallisticFireSound.Sound=ChargeFireSound;
        FireRate=default.FireRate;
        AmmoPerFire=default.AmmoPerFire;
        XInaccuracy=default.XInaccuracy;
        YInaccuracy=default.YInaccuracy;
		FireChaos=default.FireChaos;
        RecoilPerShot=default.RecoilPerShot;
        bSplashDamage=false;
        bRecommendSplashDamage=false;
    }
    
    else if (NewMode == 1)
    {
        ProjectileClass=Class'SkrithStaffPower';
        BallisticFireSound.Sound=PowerFireSound;
        FireRate=1.000000;
        AmmoPerFire=12;
        XInaccuracy=default.XInaccuracy;
        YInaccuracy=default.YInaccuracy;
		FireChaos=0.5;
        RecoilPerShot=241;
        bSplashDamage=true;
        bRecommendSplashDamage=true;
    }
    else
    if (Weapon.bBerserk)
        FireRate *= 0.75;
    if ( Level.GRI.WeaponBerserk > 1.0 )
        FireRate /= Level.GRI.WeaponBerserk;

    Load=AmmoPerFire;
}

/*function StartBerserk()
{

	if (BW.CurrentWeaponMode == 1)
    	FireRate = 0.85;
	else
    	FireRate = 0.15;
   	FireRate *= 0.75;
    FireAnimRate = default.FireAnimRate/0.75;
    ReloadAnimRate = default.ReloadAnimRate/0.75;
}

function StopBerserk()
{

	if (BW.CurrentWeaponMode == 1)
    	FireRate = 0.85;
	else
    	FireRate = 0.15;
    FireAnimRate = default.FireAnimRate;
    ReloadAnimRate = default.ReloadAnimRate;
}

function StartSuperBerserk()
{

	if (BW.CurrentWeaponMode == 1)
    	FireRate = 0.85;
	else
    	FireRate = 0.15;
    FireRate /= Level.GRI.WeaponBerserk;
    FireAnimRate = default.FireAnimRate * Level.GRI.WeaponBerserk;
    ReloadAnimRate = default.ReloadAnimRate * Level.GRI.WeaponBerserk;
}*/

defaultproperties
{
     ChargeFireSound=Sound'PackageSounds4.A73E.A73E-Fire'
     PowerFireSound=Sound'PackageSounds4.A73E.A73E-Power'
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BallisticDE.E23FlashEmitter'
     RecoilPerShot=100.000000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
	 FireChaos=0.1
     BallisticFireSound=(Sound=Sound'PackageSounds4.A73E.A73E-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
	 AimedFireAnim="Shield"
	 FireAnim="Shield"
     FireEndAnim=
     FireRate=0.157500
	 AmmoPerFire=2
     AmmoClass=Class'BWBPArchivePackDE.Ammo_SSCells'
     ShakeRotMag=(X=32.000000,Y=10.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.750000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.750000
     ProjectileClass=Class'BWBPArchivePackDE.SkrithStaffProjectile'
     WarnTargetPct=0.200000
}
