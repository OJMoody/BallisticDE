//=============================================================================
// M763Pickup.
//=============================================================================
class FM14Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.Dragon.Pitbull_Object'
     InventoryType=Class'BWBP_APC_Pro.FM14Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the FM14 Pitbull Blunderbuss."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.Pitbull.Pickup_Pitbull2'
     Physics=PHYS_None
     DrawScale=0.15000
     CollisionHeight=3.000000
}
