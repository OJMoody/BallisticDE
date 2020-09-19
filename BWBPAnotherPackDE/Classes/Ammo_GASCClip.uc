//=============================================================================
// Ammo_GASCClip.
//
// .45 Calibre High Velocity Pistol bullets.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_GASCClip extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=160
     InitialAmount=80
     IconFlashMaterial=Shader'BallisticTextures_25.MD24.AmmoIcon_MD24Flash'
     PickupClass=Class'BWBPAnotherPackDE.AP_GASCClip'
     IconMaterial=Texture'BallisticTextures_25.MD24.AmmoIcon_MD24'
     IconCoords=(X2=64,Y2=64)
     ItemName="9mm super Gaucho Bullets"
}
