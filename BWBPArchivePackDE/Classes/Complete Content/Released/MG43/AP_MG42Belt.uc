//=============================================================================
// AP_M353Belt.
//
// 150 Rounds of 5.56mm ammo on an M353 belt enclosed in a box.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_MG42Belt extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=70
     InventoryType=Class'BWBPArchivePackDE.Ammo_556mmBelt'
     PickupMessage="You picked up a belt of MG42 bullets."
     PickupSound=Sound'BallisticSounds2.Ammo.MGBoxPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.MachinegunBox'
     CollisionRadius=8.000000
     CollisionHeight=5.500000
}
