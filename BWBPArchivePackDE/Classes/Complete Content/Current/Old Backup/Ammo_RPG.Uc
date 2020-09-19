//=============================================================================
// Ammo_RPG.
//
// Ammo for the G5 RPG launcher
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_RPG extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=5
     InitialAmount=2
     IconFlashMaterial=Shader'BWWeaponPack-Tex.rgp.AmmoIcon_RPG7Flash'
     PickupClass=Class'BWBPArchivePackDE.AP_RGPAmmo'
     IconMaterial=Texture'BWWeaponPack-Tex.rgp.AmmoIcon_RPG7'
     IconCoords=(X2=63,Y2=63)
     ItemName="PG-7VL Rocket Propelled Grenades"
}
