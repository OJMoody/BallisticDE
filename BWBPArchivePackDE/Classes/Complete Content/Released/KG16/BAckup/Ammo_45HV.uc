//=============================================================================
// Ammo_45HV.
//
// .45 Calibre High Velocity Pistol bullets.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_45HV extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=60
     InitialAmount=30
     IconFlashMaterial=Shader'BWBPArchivePackTex.Icons.AmmoIcon_KG16Flash'
     PickupClass=Class'BWBPArchivePackDE.AP_KG16Clip'
     IconMaterial=Texture'BWBPArchivePackTex.Icons.AmmoIcon_KG16'
     IconCoords=(X2=64,Y2=64)
     ItemName=".45 High Velocity Bullets"
}
