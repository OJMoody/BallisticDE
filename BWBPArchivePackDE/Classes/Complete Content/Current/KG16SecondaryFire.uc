//=============================================================================
// KG16SecondaryFire.
//
// Activates laser sight for pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class KG16SecondaryFire extends BallisticFire;

event ModeDoFire()
{
	if (Weapon.Role == ROLE_Authority)
		KG16Pistol(Weapon).ServerSwitchlaser(!KG16Pistol(Weapon).bLaserOn);
}

defaultproperties
{
     bUseWeaponMag=False
     EffectString="Laser sight"
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.200000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_45HV'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
