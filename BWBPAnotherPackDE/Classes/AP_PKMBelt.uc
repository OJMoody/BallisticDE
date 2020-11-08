//=============================================================================
// AP_M353Belt.
//
// 150 Rounds of 5.56mm ammo on an M353 belt enclosed in a box.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_PKMBelt extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=75
     InventoryType=Class'BWBPAnotherPackDE.Ammo_PKMBelt'
     PickupMessage="You picked up a belt of PKM bullets."
     PickupSound=Sound'BallisticSounds2.Ammo.MGBoxPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.MachinegunBox'
     CollisionRadius=8.000000
     CollisionHeight=5.500000
}
