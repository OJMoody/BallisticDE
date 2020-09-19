//=============================================================================
// XMV850Pickup.
//=============================================================================
class A800MinigunPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=..\Textures\BWSkrithRecolors2Tex.utx
#exec OBJ LOAD FILE=..\StaticMeshes\BWSkrithRecolors2Static.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors2Tex.SkrithMinigun.A800SkinA');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors2Tex.SkrithMinigun.A800SkinB');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors2Tex.SkrithMinigun.A800_Exp');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolors2Static.SkrithMinigun.SkrithMinigunPickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolors2Static.SkrithMinigun.SkrithMinigunPickupHi');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWSkrithRecolors2Static.SkrithMinigun.SkrithMinigunPickupLo'
     PickupDrawScale=0.350000
     InventoryType=Class'BWBPArchivePackDE.A800SkrithMinigun'
     RespawnTime=20.000000
     PickupMessage="You picked up the Y11 Skrith Warthog"
     PickupSound=Sound'BallisticSounds2.XMV-850.XMV-Putaway'
     StaticMesh=StaticMesh'BWSkrithRecolors2Static.SkrithMinigun.SkrithMinigunPickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.350000
     PrePivot=(Z=35.000000)
     CollisionHeight=8.000000
}
