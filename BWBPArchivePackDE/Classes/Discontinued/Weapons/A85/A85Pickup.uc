//=============================================================================
// A42Pickup.
//=============================================================================
class A85Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=..\StaticMeshes\BWSkrithRecolors1Static.usx
#exec OBJ LOAD FILE=..\Textures\BWSkrithRecolors1Tex.utx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors1Tex.Main.SkrithShotgunSkinA');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors1Tex.Main.SkrithShotgunSkinB');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors1Tex.Main.SkrithShotgunSkinC');
	//Level.AddPrecacheMaterial(Texture'BallisticWeapon2.A73.A73AmmoSkin');

}
simulated function UpdatePrecacheStaticMeshes()
{

	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolors1Static.SkrithShotgunPickupHi');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWSkrithRecolors1Static.SkrithShotgunPickupHi'
     PickupDrawScale=0.750000
     InventoryType=Class'BWBPArchivePackDE.A85SkrithShotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the A85 Skrith Shotgun"
     PickupSound=Sound'BallisticSounds2.A42.A42-Putaway'
     StaticMesh=StaticMesh'BWSkrithRecolors1Static.SkrithShotgunPickupHi'
     Physics=PHYS_None
     DrawScale=0.500000
     CollisionHeight=4.000000
}
