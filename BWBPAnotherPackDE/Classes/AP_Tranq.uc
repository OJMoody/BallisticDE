//=============================================================================
// AP_Tranq
//
// A box of 20 tranquilizer darts.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_Tranq extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=60
     InventoryType=Class'BWBPAnotherPackDE.Ammo_Tranq'
     PickupMessage="You got 30 tranquilizer darts"
     PickupSound=Sound'BWBPAnotherPackSounds.VSK.VSK-Holster'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.PS9M.PS9MAmmo'
     DrawScale=0.400000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
