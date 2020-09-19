//=============================================================================
// AP_G5Ammo.
//
// 4 loose rockets for the G5
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_A700Ammo extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=2
     InventoryType=Class'BWBPArchivePackDE.Ammo_A700Rockets'
     PickupMessage="You picked up 2 A700 Rockets"
     PickupSound=Sound'BallisticSounds2.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BWSkrithRecolors2Static.SkrithRL.SkrithRocketAmmo'
     DrawScale=0.500000
     CollisionRadius=8.000000
     CollisionHeight=5.000000
}
