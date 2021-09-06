//=============================================================================
// Ammo_9mm.
//
// 9mm pistol ammo.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_9mmRoboT9CN extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=144
     InitialAmount=72
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Glock.AmmoIcon_GlockClipsFlash'
     PickupClass=Class'BWBP_SKCExp_Pro.AP_RoboT9CNClip'
     IconMaterial=Texture'BW_Core_WeaponTex.Glock.AmmoIcon_GlockClips'
     IconCoords=(X2=63,Y2=63)
     ItemName="9mm JHP Bullets"
}
