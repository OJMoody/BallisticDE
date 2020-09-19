//=============================================================================
// Ammo_45HV.
//
// .45 Calibre High Velocity Pistol bullets.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_EP90HV extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=200
     InitialAmount=100
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_M806Flash'
     PickupClass=Class'BWBPAnotherPackDE.AP_EP90Clip'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIcon_M806'
     IconCoords=(X2=64,Y2=64)
     ItemName=".45 High Velocity Bullets"
}
