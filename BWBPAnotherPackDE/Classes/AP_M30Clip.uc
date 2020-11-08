//=============================================================================
// AP_CYLOClip.
//
// A 25 round 7.62mm caseless magazine.
//
// by Casey 'Xavious' Johnson
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_M30Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=80
     InventoryType=Class'BWBPAnotherPackDE.Ammo_M30'
     PickupMessage="You picked up ZX98 rounds."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBPAnotherPackStatics2.AR.AR_Pickup_Mag'
     DrawScale=0.100000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
