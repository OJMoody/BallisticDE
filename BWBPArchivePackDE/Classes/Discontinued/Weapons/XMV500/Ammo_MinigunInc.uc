//=============================================================================
// Ammo_MinigunINC.
//
// Incendiary Rounds for XMB-500 minigun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_MinigunINC extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=400
     InitialAmount=200
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_MinigunFlash'
     PickupClass=Class'BWBPArchivePackDE.AP_XMV500Ammo'
     IconMaterial=Texture'BallisticRecolors4.XMV500.AmmoIcon_MinigunInc'
     IconCoords=(X2=63,Y2=63)
     ItemName="7.62mm Incendiary Minigun Rounds"
}
