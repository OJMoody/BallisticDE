//=============================================================================
// Ammo_42HVG.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_45APC extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=180
     InitialAmount=36
     bTryHeadShot=True
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBP_SKC_Pro.AP_42MachineGun'
     IconMaterial=Texture'BWBP_SKC_Tex.M30A2.AmmoIcon_M30A2'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="45APC HV Rounds"
}
