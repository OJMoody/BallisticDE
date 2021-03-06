//=============================================================================
// AP_XK2Clip.
//
// 2 40 round 9mm clips for the XK2.
//
// by Nolan "Dark Carnivour" Richert. Uses Sarge's CYLO ammo pickup.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_P90Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=100
     InventoryType=Class'BWBP_JCF_Pro.Ammo_57Nato'
     PickupMessage="You got 2 50 round 5.7mm clips"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_JCF_Static.P90.P90Ammo'
     DrawScale=2.350000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
