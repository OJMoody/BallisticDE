//=============================================================================
// Ammo_HVCCells.
//
// Ammo for the Nexron plasma cannons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_HMCCells extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=100
     InitialAmount=100
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_LGFlash'
     PickupClass=Class'BWBPArchivePackDE.AP_HMCCell'
     IconMaterial=Texture'BallisticRecolors4.XavPlasCannon.AmmoIconXav'
     IconCoords=(X2=63,Y2=63)
     ItemName="E-115 Plasma Cells"
}
