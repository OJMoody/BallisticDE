//=============================================================================
// A73Pickup.
//=============================================================================
class SkrithStaffPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=..\Textures\BWSkrithRecolorsArchive2Tex.utx
#exec OBJ LOAD FILE=..\StaticMeshes\BWSkrithRecolorsArchive2Static.usx


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolorsArchive2Tex.SkrithStaff.SkrithStaffBladeSkin');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolorsArchive2Tex.SkrithStaff.SkrithStaffSkinA');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolorsArchive2Tex.SkrithStaff.SkrithStaffSkinB');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolorsArchive2Static.SkrithStaff.SkrithStaffPick');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWSkrithRecolorsArchive2Static.SkrithStaff.SkrithStaff_Weapon'
     InventoryType=Class'BWBPArchivePackDE.SkrithStaff'
     RespawnTime=20.000000
     PickupMessage="You picked up the Skrith Shillelagh"
     PickupSound=Sound'BallisticSounds2.A73.A73Putaway'
     StaticMesh=StaticMesh'BWSkrithRecolorsArchive2Static.SkrithStaff.SkrithStaff_Weapon'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.500000
}
