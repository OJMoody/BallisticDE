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
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Glock.AmmoIcon_GlockClipsFlash'
     PickupClass=Class'BWBP_SKCExp_Pro.AP_T9CNClip'
     IconMaterial=Texture'BW_Core_WeaponTex.Glock.AmmoIcon_GlockClips'
     IconCoords=(X2=63,Y2=63)
     ItemName="9mm JHP Bullets"
}
