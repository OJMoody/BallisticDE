//=============================================================================
// PumaPickup.
//[1:25:41 AM] Marc Moylan: I HATE POSELIB
//[1:25:43 AM] Captain Xavious: lol
//[1:25:44 AM] Marc Moylan: TOO MUCH MOVEMENT
//[1:25:50 AM] Captain Xavious: noooooooo
//=============================================================================
class PumaPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4A.utx
#exec OBJ LOAD FILE=BallisticRecolors4StaticA.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4A.PUMA.PUMA-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4A.PUMA.PUMA-Mag');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4A.PUMA.PUMA-Misc');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticA.PUMA.PUMAPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticA.PUMA.PumaPickup'
     PickupDrawScale=0.200000
     InventoryType=Class'BWBPArchivePackDE.PumaRepeater'
     RespawnTime=20.000000
     PickupMessage="You picked up the PUMA-77 Repeater"
     PickupSound=Sound'PackageSounds4A.PUMA.PUMA-Pickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticA.PUMA.PumaPickup'
     Physics=PHYS_None
     DrawScale=0.220000
     CollisionHeight=4.000000
}
