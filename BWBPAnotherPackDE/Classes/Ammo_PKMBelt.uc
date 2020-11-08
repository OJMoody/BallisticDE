//=============================================================================
// Ammo_556mmBelt.
//
// 5.56mm Rounds on belts for machineguns.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_PKMBelt extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=150
     InitialAmount=75
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBPAnotherPackDE.AP_PKMBelt'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=256,X2=319,Y2=63)
     ItemName="7.62mm MG Belt Ammo"
}
