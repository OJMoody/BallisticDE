//=============================================================================
// E5Pickup.
//=============================================================================
class E5Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.VPR.VPRPickup-LD'
     PickupDrawScale=0.200000
     InventoryType=Class'BWBP_APC_Pro.E5PlasmaRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the E-5 'ViPeR'."
     PickupSound=Sound'BW_Core_WeaponSound.A73.A73Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.VPR.VPRPickup-HD'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=4.500000
}
