//=============================================================================
// KG16Pickup.
//
// by Paul "Grum" Haack.
// Copyright(c) 2013 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class KG16Pickup extends BallisticHandgunPickup
    placeable;

#exec OBJ LOAD FILE=BWBPArchivePackTex.utx
#exec OBJ LOAD FILE=BWXWeaponArchiveStatics.usx

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Texture'BWBPArchivePackTex.KG16.KG16_Main');
    Level.AddPrecacheMaterial(Texture'BWBPArchivePackTex.KG16.KG16_Clip');
}
simulated function UpdatePrecacheStaticMeshes()
{
    Level.AddPrecacheStaticMesh(StaticMesh'BWXWeaponArchiveStatics.KG16.KG16Brass');
    Level.AddPrecacheStaticMesh(StaticMesh'BWXWeaponArchiveStatics.KG16.KG16Pickup');
    Level.AddPrecacheStaticMesh(StaticMesh'BWXWeaponArchiveStatics.KG16.KG16Mag');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWXWeaponArchiveStatics.KG16.KG16Pickup'
     PickupDrawScale=0.150000
     InventoryType=Class'BWBPArchivePackDE.KG16Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the KG16 Pistol"
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BWXWeaponArchiveStatics.KG16.KG16Pickup'
     Physics=PHYS_None
     DrawScale=0.150000
     CollisionHeight=4.000000
}
