//=============================================================================
// AH104Pickup.
//=============================================================================
class AH104Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx

simulated function UpdatePrecacheMaterials()
{
//	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AH104.AH104-MainMk2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M806.PistolMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.AM67.AM67Clips');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.AM67.PickupLD'
     PickupDrawScale=0.190000
     InventoryType=Class'BWBP_SKCExp_Pro.AH104Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the AH104 Handcannon"
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.AM67.PickupLD'
     Physics=PHYS_None
     DrawScale=0.400000
     PrePivot=(Y=-26.000000)
     CollisionHeight=4.000000
}
