//=============================================================================
// red bullets.
//=============================================================================
class MG36Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPAnotherPackStatics.MG36.MG36_Weapon'
     InventoryType=Class'BWBPAnotherPackDE.MG36Carbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the MG36 Night Ops Machinegun"
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBPAnotherPackStatics.MG36.MG36_Weapon'
     Physics=PHYS_None
     CollisionHeight=4.000000
	 DrawScale=0.100000
}
