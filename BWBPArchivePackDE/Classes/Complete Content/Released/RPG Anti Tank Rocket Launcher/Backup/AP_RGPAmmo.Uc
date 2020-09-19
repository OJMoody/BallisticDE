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
     InventoryType=Class'BWBPArchivePackDE.Ammo_RPG'
     PickupMessage="You picked up a PG-7VL HEAP Rocket"
     PickupSound=Sound'BallisticSounds2.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BWWeaponPackArchive-Static.RPG.Rocket'
     DrawScale=0.500000
     CollisionRadius=8.000000
     CollisionHeight=5.000000
}
