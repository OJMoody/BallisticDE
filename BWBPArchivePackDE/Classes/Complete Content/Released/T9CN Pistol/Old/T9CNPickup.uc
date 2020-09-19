//=============================================================================
// T9CNPickup.
//=============================================================================
class T9CNPickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4.utx
#exec OBJ LOAD FILE=BWBP4-Tex.utx
#exec OBJ LOAD FILE=BWBP4-Hardware.usx
#exec OBJ LOAD FILE=BallisticRecolors4Static.usx

/*simulated function PostNetReceive()
{
	if (CamoIndex != OldCamoIndex)
	{
		OldCamoIndex = CamoIndex;
		if (CamoIndex == 4) //BB
		{
			Skins[0]=class<BallisticCamoHandgun>(InventoryType).default.CamoMaterials[2];
			Skins[1]=class<BallisticCamoHandgun>(InventoryType).default.CamoMaterials[6];
		}
		else if (CamoIndex == 3) //CA
		{
			Skins[0]=class<BallisticCamoHandgun>(InventoryType).default.CamoMaterials[3];
			Skins[1]=class<BallisticCamoHandgun>(InventoryType).default.CamoMaterials[5];
		}
		else if (CamoIndex == 2) //DA
		{
			Skins[0]=class<BallisticCamoHandgun>(InventoryType).default.CamoMaterials[4];
			Skins[1]=class<BallisticCamoHandgun>(InventoryType).default.CamoMaterials[5];
		}
		else if (CamoIndex == 1) //DC
		{
     			PickupMessage="You picked up the T9CN-R Machine Pistol";
			Skins[0]=class<BallisticCamoHandgun>(InventoryType).default.CamoMaterials[4];
			Skins[1]=class<BallisticCamoHandgun>(InventoryType).default.CamoMaterials[7];
		}
		else
		{
			Skins[0]=class<BallisticCamoHandgun>(InventoryType).default.CamoMaterials[1];
			Skins[1]=class<BallisticCamoHandgun>(InventoryType).default.CamoMaterials[5];
		}
	}
		
	Super(BallisticHandgunPickup).PostNetReceive();
}*/

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Brass.Cart_Silver');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4.T9CN.Ber-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4.T9CN.Ber-Slide');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4.T9CN.Ber-Mag');

	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4Static.M9.M9Pickup');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Glock.Glock-Ammo');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Brass.Cart_Silver');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4.T9CN.Ber-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4.T9CN.Ber-Slide');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4.T9CN.Ber-Mag');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4Static.M9.M9Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Glock.Glock-Ammo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4Static.M9.M9Pickup'
     PickupDrawScale=0.900000
     InventoryType=Class'BWBPArchivePackDE.T9CNMachinePistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the T9CN Machine Pistol"
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4Static.M9.M9Pickup'
     Physics=PHYS_None
     DrawScale=0.900000
     Skins(0)=Shader'BallisticRecolors4.T9CN.Ber-MainShine'
     Skins(1)=Shader'BallisticRecolors4.T9CN.Ber-SlideShine'
     Skins(2)=Texture'BallisticRecolors4.T9CN.Ber-Mag'
     CollisionHeight=4.000000
}
