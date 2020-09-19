//=============================================================================
// AP_556mmClip.
//
// A 30 round 5.56mm magazine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_556mmClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=125
     InventoryType=Class'BWBPAnotherPackDE.Ammo_68mm'
     PickupMessage="You got 125 MG36 HV Rounds."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBPAnotherPackStatics.MG36.MG36_Mag'
     DrawScale=0.100000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
