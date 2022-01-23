//=============================================================================
// HKMKSpecPickup.
//=============================================================================
class HKMKSpecPickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.RS8.RS8PickupLo'
     PickupDrawScale=0.210000
     InventoryType=Class'BWBP_JCF_Pro.HKMKSpecPistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the RS8 pistol."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.RS8.RS8PickupHi'
     Physics=PHYS_None
     DrawScale=0.600000
     PrePivot=(Y=-18.000000)
     CollisionHeight=4.000000
}
