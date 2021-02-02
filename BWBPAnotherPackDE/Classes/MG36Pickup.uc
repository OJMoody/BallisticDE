//=============================================================================
// red bullets.
//=============================================================================
class MG36Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.MG36.MG36_Weapon'
     InventoryType=Class'BWBPAnotherPackDE.MG36Carbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the MG36 Night Ops Machinegun"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.MG36.MG36_Weapon'
     Physics=PHYS_None
     CollisionHeight=4.000000
	 DrawScale=0.100000
}
