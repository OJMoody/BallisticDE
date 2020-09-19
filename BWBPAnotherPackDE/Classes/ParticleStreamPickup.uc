//=============================================================================
// AK47Pickup.
//=============================================================================
class ParticleStreamPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBPOtherPackStatic.usx
#exec OBJ LOAD FILE=BWBPOtherPackTex2.utx
#exec OBJ LOAD FILE=R9A_tex.utx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWBPOtherPackTex2.ProtonPack.Proton_gun_SH1');
	L.AddPrecacheMaterial(Shader'BWBPOtherPackTex2.ProtonPack.Proton_pack_SH_1');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.ProtonPack.Proton_Pack_Static');
	L.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.ProtonPack.Proton_Pack_Static_Test');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWBPOtherPackTex2.ProtonPack.Proton_gun_SH1');
	Level.AddPrecacheMaterial(Shader'BWBPOtherPackTex2.ProtonPack.Proton_pack_SH_1');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.ProtonPack.Proton_Pack_Static');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.ProtonPack.Proton_Pack_Static_Test');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBPOtherPackStatic.ProtonPack.proton_pack_static'
     PickupDrawScale=0.750000
     InventoryType=Class'BWBPAnotherPackDE.ParticleStreamer'
     RespawnTime=20.000000
     PickupMessage="You picked up the mk.II E90-N particle accelerator."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBPOtherPackStatic.ProtonPack.proton_pack_static'
     Physics=PHYS_None
     DrawScale=0.750000
     CollisionHeight=4.500000
	 Skins(1)=Shader'BWBPOtherPackTex2.ProtonPack.proton_pack_SH_1'
}
