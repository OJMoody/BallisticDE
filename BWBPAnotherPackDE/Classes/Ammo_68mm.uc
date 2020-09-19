//=============================================================================
// Ammo_68mm.
//
// 6.8mm bullet ammo.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_68mm extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=125
     InitialAmount=125
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBPAnotherPackDE.AP_556mmClip'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="6.8mm HVHE ammo"
}
