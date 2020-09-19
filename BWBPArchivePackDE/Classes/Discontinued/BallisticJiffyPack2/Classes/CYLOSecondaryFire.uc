//=============================================================================
// SARSecondaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOSecondaryFire extends BallisticFire;

event ModeDoFire()
{
	if (Weapon.Role == ROLE_Authority)
		SARAssaultRifle(Weapon).ServerSwitchlaser(!SARAssaultRifle(Weapon).bLaserOn);
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BallisticJiffyPack2.Ammo_9mm'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
