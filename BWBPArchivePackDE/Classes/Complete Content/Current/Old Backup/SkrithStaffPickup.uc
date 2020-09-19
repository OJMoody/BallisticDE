//=============================================================================
// A73Pickup.
//=============================================================================
class SkrithStaffPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=..\Textures\BWSkrithRecolors2Tex.utx
#exec OBJ LOAD FILE=..\StaticMeshes\BWSkrithRecolors2Static.usx


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors2Tex.SkrithStaff.SkrithStaffBladeSkin');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors2Tex.SkrithStaff.SkrithStaffSkinA');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors2Tex.SkrithStaff.SkrithStaffSkinB');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolors2Static.SkrithStaff.SkrithStaffPick');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.A73.A73PickupLo'
     InventoryType=Class'BWBPArchivePackDE.SkrithStaff'
     RespawnTime=20.000000
     PickupMessage="You picked up the Skrith Shillelagh"
     PickupSound=Sound'BallisticSounds2.A73.A73Putaway'
     StaticMesh=StaticMesh'BWSkrithRecolors2Static.SkrithStaff.SkrithStaffPick'
     Physics=PHYS_None
     DrawScale=0.500000
     CollisionHeight=4.500000
}
