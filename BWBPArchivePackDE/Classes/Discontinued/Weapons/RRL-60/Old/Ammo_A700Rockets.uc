//=============================================================================
// Ammo_RPG.
//
// Ammo for the G5 RPG launcher
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_A700Rockets extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=6
     InitialAmount=2
     IconFlashMaterial=Shader'BWSkrithRecolors2Tex.SkrithRL.AmmoIcon_SkrithRocketsFlash'
     PickupClass=Class'BWBPArchivePackDE.AP_A700Ammo'
     IconMaterial=Texture'BWSkrithRecolors2Tex.SkrithRL.AmmoIcon_SkrithRockets'
     IconCoords=(X1=128,Y1=64,X2=191,Y2=127)
     ItemName="A700 Rockets"
}
