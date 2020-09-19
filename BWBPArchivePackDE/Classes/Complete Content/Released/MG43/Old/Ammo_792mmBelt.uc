//=============================================================================
// Ammo_792mmBelt.
//
// 7.92mm Rounds on belts for machineguns.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_792mmBelt extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=240
     InitialAmount=120
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticDE.AP_M353Belt'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=256,X2=319,Y2=63)
     ItemName="7.92mm MG Belt Ammo"
}
