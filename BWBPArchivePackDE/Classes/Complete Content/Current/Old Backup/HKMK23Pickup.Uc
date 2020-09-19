//=============================================================================
// HKMK23Pickup.
//=============================================================================
class HKMK23Pickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWWeaponPack-Static.MK23.Mk23_Pickup'
     PickupDrawScale=0.400000
     InventoryType=Class'BWBPArchivePackDE.HKMK23Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the HK MK23 Pistol"
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BWWeaponPack-Static.MK23.Mk23_Pickup'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=4.000000
}
