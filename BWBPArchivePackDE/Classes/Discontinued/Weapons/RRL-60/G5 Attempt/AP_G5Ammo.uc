//=============================================================================
// AP_G5Ammo.
//
// 4 loose rockets for the G5
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_G5Ammo extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=2
     InventoryType=Class'BWBPArchivePackDE.Ammo_RPG'
     PickupMessage="You picked up a pair of G5 rocket propelled grenades."
     PickupSound=Sound'BallisticSounds2.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.G5Rockets'
     DrawScale=0.500000
     CollisionRadius=8.000000
     CollisionHeight=5.000000
}
