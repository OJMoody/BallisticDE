//=============================================================================
// SPASPickup.
//=============================================================================
class SPASPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWWeaponPack-Static.SPAS.SPAS12'
     PickupDrawScale=0.600000
     InventoryType=Class'BWBPArchivePackDE.SPASShotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the SPAS Semi-Auto Shotgun"
     PickupSound=Sound'BallisticSounds2.M763.M763Putaway'
     StaticMesh=StaticMesh'BWWeaponPack-Static.SPAS.SPAS12'
     Physics=PHYS_None
     CollisionHeight=3.000000
}
