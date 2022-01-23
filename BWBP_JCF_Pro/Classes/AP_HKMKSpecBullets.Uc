//=============================================================================
// AP_HKMK23Clip.
//
// Clips for the HKMK 23
//
// by Fischer Felix
//=============================================================================
class AP_HKMKSpecBullets extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=32
     InventoryType=Class'BWBP_JCF_Pro.Ammo_HKMKSpecBullets'
     PickupMessage="You got 32 .45 ACP rounds for the Mk.23"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.M806Clip'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=16.000000
}
