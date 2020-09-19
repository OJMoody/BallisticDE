//=============================================================================
// XK2Pickup.
//=============================================================================
class P90Pickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWWeaponPackArchive-Static.P90.P90'
     PickupDrawScale=0.600000
     InventoryType=Class'BWBPArchivePackDE.P90SubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the P90 ACU"
     PickupSound=Sound'BallisticSounds2.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWWeaponPackArchive-Static.P90.P90'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=4.000000
}
