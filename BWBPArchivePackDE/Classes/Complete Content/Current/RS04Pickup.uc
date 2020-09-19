//=============================================================================
// RS04Pickup.
//=============================================================================
class RS04Pickup extends BallisticHandGunPickup
	placeable;


#exec OBJ LOAD FILE=BallisticRecolorsArchive4.utx
#exec OBJ LOAD FILE=BallisticRecolors4ArchiveStatic.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolorsArchive4.M1911.RS04-Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4ArchiveStatic.RS04.RS04Pickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4ArchiveStatic.RS04.RS04Pickup'
     PickupDrawScale=0.600000
     InventoryType=Class'BWBPArchivePackDE.RS04Pistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the RS04 .45 Compact"
     PickupSound=Sound'BallisticSounds2.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4ArchiveStatic.RS04.RS04Pickup'
     Physics=PHYS_None
     DrawScale=0.620000
     CollisionHeight=4.000000
}
