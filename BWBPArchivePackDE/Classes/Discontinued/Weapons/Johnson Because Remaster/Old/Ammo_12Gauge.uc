//=============================================================================
// Ammo_12Gauge.
//
// 12 Gauge shotgun ammo. Used by archon shotguns.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_12Gauge extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=48
     InitialAmount=24
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_12GaugeFlash'
     PickupClass=Class'BWBPArchivePackDE.AP_12GaugeBox'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIcon_12GaugeBox'
     IconCoords=(X2=63,Y2=63)
     ItemName="12 Gauge Shells"
}
