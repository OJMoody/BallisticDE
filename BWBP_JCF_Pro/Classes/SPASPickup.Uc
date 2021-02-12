//=============================================================================
// SPASPickup.
//=============================================================================
class SPASPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_JCF_Static.SPAS.SPAS12'
     PickupDrawScale=0.600000
     InventoryType=Class'BWBP_JCF_Pro.SPASShotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the SPAS Semi-Auto Shotgun"
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_JCF_Static.SPAS.SPAS12'
     Physics=PHYS_None
     CollisionHeight=3.000000
}
