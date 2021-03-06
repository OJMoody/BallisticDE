//=============================================================================
// MJ51Pickup.
//=============================================================================
class MJ51Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.MJ51.MJ51Pickup'
     InventoryType=Class'BWBP_SKCExp_Pro.MJ51Carbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the MJ53 Carbine"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.MJ51.MJ51Pickup'
     Physics=PHYS_None
     DrawScale=0.260000
     CollisionHeight=4.000000
}
