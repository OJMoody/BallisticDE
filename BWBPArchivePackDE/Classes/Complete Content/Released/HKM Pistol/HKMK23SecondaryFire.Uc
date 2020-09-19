//=============================================================================
// M806SecondaryFire.
//
// Activates laser sight for pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HKMK23SecondaryFire extends BallisticFire;

//event ModeDoFire()
//{
//	if (Weapon.Role == ROLE_Authority)
//		HKMK23Pistol(Weapon).ServerSwitchlaser(!HKMK23Pistol(Weapon).bLaserOn);
//}

defaultproperties
{
     bUseWeaponMag=False
     bWaitForRelease=True
     bModeExclusive=False
     FireRate=0.200000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_45ACP'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
