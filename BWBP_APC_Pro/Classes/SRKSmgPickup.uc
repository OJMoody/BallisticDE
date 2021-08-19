//=============================================================================
// MJ51Pickup.
//=============================================================================
class SRKSmgPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.MJ51.MJ51Pickup'
     InventoryType=Class'BWBP_APC_Pro.SRKSubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the SRK-205 Carbine"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.MJ51.MJ51Pickup'
     Physics=PHYS_None
     DrawScale=0.260000
     CollisionHeight=4.000000
}
