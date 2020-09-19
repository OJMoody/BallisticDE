//=============================================================================
// AP_M806Clip.
//
// Clips for the M806A2.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_EP90Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=50
     InventoryType=Class'BWBPAnotherPackDE.Ammo_EP90HV'
     PickupMessage="You picked up .45 high velocity M806 bullets."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.M806Clip'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=16.000000
}
