//=============================================================================
// EKS43Pickup.
//=============================================================================
class N3XPlazPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticRecolors4Static.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4.NEX.NEX-Main');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4Static.PlasEdge.PlasEdgePickup');

}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4Static.PlasEdge.PlasEdgePickup'
     PickupDrawScale=0.220000
     InventoryType=Class'BWBPArchivePackDE.N3XPlaz'
     RespawnTime=10.000000
     PickupMessage="You picked up the NEX Plas-Edge Sword"
     StaticMesh=StaticMesh'BallisticRecolors4Static.PlasEdge.PlasEdgePickup'
     Physics=PHYS_None
     DrawScale=0.220000
     CollisionHeight=4.000000
}
