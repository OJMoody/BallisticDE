//=============================================================================
// MGA88Pickup.
//=============================================================================
class MG42Pickup extends BallisticWeaponPickup
    placeable;

#exec OBJ LOAD FILE=BWXWeaponStatics.usx
#exec OBJ LOAD FILE=BWBPArchivePackTex.utx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBPArchivePackTex.MG42.mg42_barrel');
    L.AddPrecacheMaterial(Texture'BWBPArchivePackTex.MG42.mg42_belt');
	L.AddPrecacheMaterial(Texture'BWBPArchivePackTex.MG42.mg42_bipod');
	L.AddPrecacheMaterial(Texture'BWBPArchivePackTex.MG42.mg42_Main');
	L.AddPrecacheMaterial(Texture'BWBPArchivePackTex.MG42.mg42_Shield');
    L.AddPrecacheMaterial(Texture'BWBPArchivePackTex.MG42.mg42_box');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWXWeaponStatics.MGA88s.MGA88sAmmoBox');
    L.AddPrecacheStaticMesh(StaticMesh'BWXWeaponStatics.MGA88s.MGA88sGun');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Texture'BWBPArchivePackTex.MG42.mg42_barrel');
    Level.AddPrecacheMaterial(Texture'BWBPArchivePackTex.MG42.mg42_belt');
	Level.AddPrecacheMaterial(Texture'BWBPArchivePackTex.MG42.mg42_bipod');
	Level.AddPrecacheMaterial(Texture'BWBPArchivePackTex.MG42.mg42_Main');
	Level.AddPrecacheMaterial(Texture'BWBPArchivePackTex.MG42.mg42_Shield');
    Level.AddPrecacheMaterial(Texture'BWBPArchivePackTex.MG42.mg42_box');
}
simulated function UpdatePrecacheStaticMeshes()
{
    //Level.AddPrecacheStaticMesh(StaticMesh'BWXWeaponStatics.MGA88s.MGA88sAmmoBox');
    Level.AddPrecacheStaticMesh(StaticMesh'BWXWeaponStatics.MGA88s.MGA88sGun');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWXWeaponStatics.MGA88s.MGA88sGun'
     PickupDrawScale=2.500000
     StandUp=(Y=0.800000)
     InventoryType=Class'BWBPArchivePackDE.MG42Machinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the MG42 machinegun."
     PickupSound=Sound'BallisticSounds2.M353.M353-Putaway'
     StaticMesh=StaticMesh'BWXWeaponStatics.MGA88s.MGA88sGun'
     bOrientOnSlope=True
     Physics=PHYS_None
     CollisionHeight=12.000000
}
