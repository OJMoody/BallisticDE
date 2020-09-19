//=============================================================================
// SARSecondaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class M7A3SecondaryFire extends BallisticFire;

event ModeDoFire()
{
	if (Weapon.Role == ROLE_Authority)
		SARAssaultRifle(Weapon).ServerSwitchlaser(!SARAssaultRifle(Weapon).bLaserOn);
//	if (!Instigator.IsLocallyControlled())
//		return;
//	if (AllowFire())
//		SARAssaultRifle(Weapon).WeaponSpecial();
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_447mm'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
