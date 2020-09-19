//=============================================================================
// EKS43Pickup.
//=============================================================================
class BlackOpsWristBladePickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolorsArchive4.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticRecolors4ArchiveStatic.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolorsArchive4.BlkOpsBlade.BlkOpsBlade');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4ArchiveStatic.X5W.X5WPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4ArchiveStatic.X5W.X5WPickup'
     PickupDrawScale=0.500000
     InventoryType=Class'BWBPArchivePackDE.BlackOpsWristBlade'
     RespawnTime=10.000000
     PickupMessage="You picked up the X5W Black Ops Blade"
     PickupSound=Sound'BallisticSounds2.EKS43.EKS-Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4ArchiveStatic.X5W.X5WPickup'
     Physics=PHYS_None
     DrawScale=0.200000
     CollisionHeight=4.000000
}
