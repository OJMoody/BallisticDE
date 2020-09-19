//=============================================================================
// Ammo_556mm.
//
// 5.56mm bullet ammo. Used by several of the ballistic weapons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_447mm extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=200
     InitialAmount=100
     IconFlashMaterial=Shader'BWWeaponPack-Tex.M7A3.AmmoIcon_M7A3Flash'
     PickupClass=Class'BWBPArchivePackDE.AP_M7A3Clip'
     IconMaterial=Texture'BWWeaponPack-Tex.M7A3.AmmoIcon_M7A3'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="4.77mm Ammo"
}
