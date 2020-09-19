//=============================================================================
// Ammo_9mm.
//
// 9mm pistol ammo.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_9mmT9CN extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=120
     InitialAmount=60
     IconFlashMaterial=Shader'BWBP4-Tex.Glock.AmmoIcon_GlockClipsFlash'
     PickupClass=Class'BWBPArchivePackDE.AP_T9CNClip'
     IconMaterial=Texture'BWBP4-Tex.Glock.AmmoIcon_GlockClips'
     IconCoords=(X2=63,Y2=63)
     ItemName="9mm JHP Bullets"
}
