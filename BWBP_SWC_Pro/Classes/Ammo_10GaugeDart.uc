//=============================================================================
// Ammo_10GaugeDart.
//
// 10 Gauge Flechette shotgun ammo. Used by Mk781
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_10GaugeDart extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=60
     InitialAmount=30
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_12GaugeFlash'
     PickupClass=Class'BWBP_SWC_Pro.AP_10GaugeDartBox'
     IconMaterial=Texture'BWBP_SKC_Tex.M1014.AmmoIcon_10GaugeDartBox'
     IconCoords=(X2=63,Y2=63)
     ItemName="Gauge Flechette Shells"
}
