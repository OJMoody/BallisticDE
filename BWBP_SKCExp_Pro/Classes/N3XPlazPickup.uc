//=============================================================================
// EKS43Pickup.
//=============================================================================
class N3XPlazPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_TexExp.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_SKC_StaticExp.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.NEX.NEX-Main');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_StaticExp.PlasEdge.PlasEdgePickup');

}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.PlasEdge.PlasEdgePickup'
     PickupDrawScale=0.220000
     InventoryType=Class'BWBP_SKCExp_Pro.N3XPlaz'
     RespawnTime=10.000000
     PickupMessage="You picked up the NEX Plas-Edge Sword"
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.PlasEdge.PlasEdgePickup'
     Physics=PHYS_None
     DrawScale=0.220000
     CollisionHeight=4.000000
}
