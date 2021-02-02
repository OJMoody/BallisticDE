//=============================================================================
// SARPickup.
//=============================================================================
class M7A3Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_JCF_Static.M7A3.M7A3'
     PickupDrawScale=0.540000
     InventoryType=Class'BWBPArchivePackDE.M7A3AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the M7A3 Assault Rifle"
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWBP_JCF_Static.M7A3.M7A3'
     Physics=PHYS_None
     DrawScale=0.540000
     CollisionHeight=4.000000
}
