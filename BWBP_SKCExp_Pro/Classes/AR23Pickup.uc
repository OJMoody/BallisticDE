//=============================================================================
// AR23Pickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyrightę 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AR23Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware_25.OA-AR.OA-AR_PickupLo'
     PickupDrawScale=0.400000
     InventoryType=Class'BWBP_SKCExp_Pro.AR23HeavyRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the AR23 'Punisher' Heavy Rifle"
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticHardware_25.OA-AR.OA-AR_PickupHi'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=4.000000
}
