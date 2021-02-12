//=============================================================================
// XMV850Pickup.
//=============================================================================
class A800MinigunPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=..\Textures\BWBP_SWC_Tex.utx
#exec OBJ LOAD FILE=..\StaticMeshes\BWBP_SWC_Static.usx
/*
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.SkrithMinigun.A800SkinB');
	Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.SkrithMinigun.A800_Exp');
}
*/
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.SkrithMinigun.SME_SM_Main');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.SkrithMinigun.SME_SM_Main');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_SWC_Static.SkrithMinigun.SME_SM_Main'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_SWC_Pro.A800SkrithMinigun'
     RespawnTime=20.000000
     PickupMessage="You picked up the Y11 Skrith Warthog"
     PickupSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Putaway'
     StaticMesh=StaticMesh'BWBP_SWC_Static.SkrithMinigun.SME_SM_Main'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.100000
     PrePivot=(Z=35.000000)
     CollisionHeight=8.000000
}
