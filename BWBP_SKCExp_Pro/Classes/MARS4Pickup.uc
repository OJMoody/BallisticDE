//=============================================================================
// MRASPickup. Jason MRAS.
//=============================================================================
class MARS4Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

simulated function PostNetReceive()
{
	/*if (CamoIndex != OldCamoIndex)
	{
		OldCamoIndex = CamoIndex;
		Skins[0] = class<BallisticCamoWeapon>(InventoryType).default.CamoMaterials[CamoIndex];
		if (CamoIndex == 3)
     			PickupMessage="You picked up the MARS-3 CQB-LE Assault Rifle";
	}*/
		
	Super.PostNetReceive();
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.M30A2.M30A2-SA');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.M30A2.M30A2-SB');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.M30A2.M30A2-Laser');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.M30A2.M30A2-Gauss');
	Level.AddPrecacheMaterial(Texture'ONSstructureTextures.CoreGroup.Invisible');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M900.M900Grenade');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M900.M900MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.M50Magazine');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M50.M50PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M50.M50PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.MARS.MARS3_Pickup'
     PickupDrawScale=0.140000
     InventoryType=Class'BWBP_SKCExp_Pro.MARS4AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the MARS-4 'Duststorm' XCIII"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MARS.MARS3_Pickup'
     Physics=PHYS_None
     DrawScale=0.250000
     Skins(0)=Texture'BWBP_SKC_TexExp.MARS.F2000-Irons'
     Skins(1)=Texture'BWBP_SKC_Tex.LK05.LK05-EOTech-RDS'
     Skins(2)=Texture'BWBP_SKC_Tex.MARS.F2000-Misc'
     CollisionHeight=4.000000
}
