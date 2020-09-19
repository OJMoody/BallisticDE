//=============================================================================
// G5SecondaryFire.
//
// Activates laser sight for G5
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class G5SecondaryFire extends BallisticFire;

event ModeDoFire()
{
	if (Weapon.Role == ROLE_Authority)
		AkeronLauncher(Weapon).ServerSwitchlaser(!AkeronLauncher(Weapon).bLaserOn);
}

defaultproperties
{
     bUseWeaponMag=False
     EffectString="Laser guidance"
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.200000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_Akeron'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
