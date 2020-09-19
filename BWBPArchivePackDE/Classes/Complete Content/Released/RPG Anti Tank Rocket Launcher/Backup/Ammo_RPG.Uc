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
     MaxAmmo=16
     InitialAmount=8
     IconFlashMaterial=Shader'BWWeaponPackArchive-Tex.rgp.AmmoIcon_RPG7Flash'
     PickupClass=Class'BWBPArchivePackDE.AP_RGPAmmo'
     IconMaterial=Texture'BWWeaponPackArchive-Tex.rgp.AmmoIcon_RPG7'
     IconCoords=(X2=63,Y2=63)
     ItemName="PG-7VL Rocket Propelled Grenades"
}
