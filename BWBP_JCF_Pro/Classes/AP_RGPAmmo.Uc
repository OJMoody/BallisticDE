//=============================================================================
// AP_RGPAmmo.
//
// 1 rocket for the RPG-7
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_RGPAmmo extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=1
     InventoryType=Class'BWBP_JCF_Pro.Ammo_RPG'
     PickupMessage="You picked up a PG-7VL HEAP Rocket"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BWBP_JCF_Static.RPG.Rocket'
     DrawScale=0.500000
     CollisionRadius=8.000000
     CollisionHeight=5.000000
}
