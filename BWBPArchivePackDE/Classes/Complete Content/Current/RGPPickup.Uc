//=============================================================================
// G5Pickup.
//=============================================================================
class RGPPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWWeaponPackArchive-Static.RPG.RPG'
     PickupDrawScale=0.500000
     InventoryType=Class'BWBPArchivePackDE.RGPBazooka'
     RespawnTime=20.000000
     PickupMessage="You picked up the RGP-7 Soldier Rocket Launcher"
     PickupSound=Sound'BallisticSounds2.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWWeaponPackArchive-Static.RPG.RPG'
     Physics=PHYS_None
     DrawScale=0.500000
     CollisionHeight=6.000000
}
