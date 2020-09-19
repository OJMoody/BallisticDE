//=============================================================================
// Rs04SecondaryFire.
//
// Activates flashlight
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RS04SecondaryFire extends BallisticFire;

simulated event ModeDoFire()
{
    if (!Instigator.IsLocallyControlled())
    	return;
	if (AllowFire())
		CYLOAssaultWeapon(Weapon).WeaponSpecial();
}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.200000
	 AmmoClass=Class'BWBPAnotherPackDE.Ammo_CYLOInc'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
