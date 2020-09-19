//=============================================================================
// Johnson 71 Ammo Pickup
//
// Flares
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_Johnson71Ammo extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=9
     InventoryType=Class'BWBPArchivePackDE.Ammo_Johnson71'
     PickupMessage="You picked up 9 Johnson Combat Flares"
     PickupSound=Sound'BallisticSounds2.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.SK410.SK410Ammo'
     DrawScale=0.750000
     CollisionRadius=8.000000
     CollisionHeight=5.000000
}
