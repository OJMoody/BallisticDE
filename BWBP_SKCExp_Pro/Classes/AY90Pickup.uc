//=============================================================================
// AY90Pickup.
//=============================================================================
class AY90Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.A73.A73PickupLo'
     InventoryType=Class'BWBP_SKCExp_Pro.AY90SkrithBoltcaster'
     RespawnTime=20.000000
     PickupMessage="You picked up the AY90 Skrith Boltcaster"
     PickupSound=Sound'BW_Core_WeaponSound.A73.A73Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.A73.A73PickupHi'
     Physics=PHYS_None
     DrawScale=0.187500
     CollisionHeight=4.500000
}
