//=============================================================================
// AY90Pickup.
//=============================================================================
class AY90Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     bOnSide=False
	 LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.SkrithBow.SkrithBow_Main'
     InventoryType=Class'BWBP_SKCExp_Pro.AY90SkrithBoltcaster'
     RespawnTime=20.000000
     PickupMessage="You picked up the AY90 Skrith Boltcaster"
     PickupSound=Sound'BW_Core_WeaponSound.A73.A73Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.SkrithBow.SkrithBow_Main'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.500000
}
