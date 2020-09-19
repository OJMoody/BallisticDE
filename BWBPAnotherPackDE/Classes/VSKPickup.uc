//=============================================================================
// VSKPickup.
//=============================================================================
class VSKPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.M50.M50PickupLo'
     InventoryType=Class'BWBPAnotherPackDE.VSKTranqRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the VSK-42 Tranquilizer"
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBPAnotherPackStatics.552Commando.Pickup_552Commando'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
