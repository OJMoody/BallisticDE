//=============================================================================
// RS8SecondaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SX45SecondaryFire extends BallisticFire;

event ModeDoFire()
{
	if (Weapon.Role == ROLE_Authority)
		SX45Pistol(Weapon).ToggleAmplifier();
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.700000
     AmmoClass=Class'BWBP_SKCExp_Pro.Ammo_SX45Bullets'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
