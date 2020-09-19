//=============================================================================
// Ammo_Cells.
//
// Ammo for the A73 Skrith Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_SSCells extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=240
     InitialAmount=120
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBPArchivePackDE.AP_SkrithStaffClip'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=256,Y1=64,X2=319,Y2=127)
     ItemName="Skrith Heavy Cell Ammo"
}
