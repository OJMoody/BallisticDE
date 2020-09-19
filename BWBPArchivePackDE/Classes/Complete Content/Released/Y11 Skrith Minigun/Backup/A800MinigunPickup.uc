//=============================================================================
// XMV850Pickup.
//=============================================================================
class A800MinigunPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=..\Textures\BWSkrithRecolorsArchive2Tex.utx
#exec OBJ LOAD FILE=..\StaticMeshes\BWSkrithRecolorsArchive2Static.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolorsArchive2Tex.SkrithMinigun.A800SkinA');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolorsArchive2Tex.SkrithMinigun.A800SkinB');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolorsArchive2Tex.SkrithMinigun.A800_Exp');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolorsArchive2Static.SkrithMinigun.SkrithMinigunPickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolorsArchive2Static.SkrithMinigun.SkrithMinigunPickupHi');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWSkrithRecolorsArchive2Static.SkrithMinigun.SkrithMinigunPickupLo'
     PickupDrawScale=0.350000
     InventoryType=Class'BWBPArchivePackDE.A800SkrithMinigun'
     RespawnTime=20.000000
     PickupMessage="You picked up the Y11 Skrith Warthog"
     PickupSound=Sound'BallisticSounds2.XMV-850.XMV-Putaway'
     StaticMesh=StaticMesh'BWSkrithRecolorsArchive2Static.SkrithMinigun.SkrithMinigunPickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.350000
     PrePivot=(Z=35.000000)
     CollisionHeight=8.000000
}
