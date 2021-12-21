//=============================================================================
// G5Pickup.
//=============================================================================
class HydraPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.G5.G5PickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BWBP_APC_Pro.HydraBazooka'
     RespawnTime=60.000000
     PickupMessage="You picked up the Hydra missile launcher."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.G5.G5PickupHi'
     Physics=PHYS_None
     DrawScale=0.450000
     CollisionHeight=6.000000
}
