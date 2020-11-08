//=============================================================================
// CYLOPickup.
//=============================================================================
class M30Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPAnotherPackStatics2.AR.AR_Pickup_Main'
     InventoryType=Class'BWBPAnotherPackDE.M30AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the ZX98 Reaper Gauss Minigun."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBPAnotherPackStatics2.AR.AR_Pickup_Main'
     Physics=PHYS_None
	 DrawScale=0.1
     CollisionHeight=4.000000
}
