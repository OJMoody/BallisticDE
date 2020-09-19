//=============================================================================
// AP_M806Clip.
//
// Clips for the M806A2.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_DEClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=14
     InventoryType=Class'BWBPArchivePackDE.Ammo_50AE'
     PickupMessage="You got 14 rounds of .50 AE ammo for the DE"
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.M806Clip'
     DrawScale=0.350000
     Skins(0)=Texture'BWWeaponPack-Tex.MK23.MK23_Ammo'
     CollisionRadius=8.000000
     CollisionHeight=16.000000
}
