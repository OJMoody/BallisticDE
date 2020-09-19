//=============================================================================
// AP_GASCClip.
//
// Clips for the GASC.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_GASCClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=80
     InventoryType=Class'BWBPAnotherPackDE.Ammo_GASCClip'
     PickupMessage="You picked up two Gaucho magazines."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBPAnotherPackStatics2.GASC.GASC_Pickup_Ammo'
     DrawScale=0.100000
     CollisionRadius=8.000000
     CollisionHeight=16.000000
}
