//=============================================================================
// MJ51Pickup.
//=============================================================================
class MJ51Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4ArchiveStaticA.MJ51.MJ51Pickup'
     InventoryType=Class'BWBPArchivePackDE.MJ51Carbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the MJ53 Carbine"
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4ArchiveStaticA.MJ51.MJ51Pickup'
     Physics=PHYS_None
     DrawScale=0.260000
     CollisionHeight=4.000000
}
