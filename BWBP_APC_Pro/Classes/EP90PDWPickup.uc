//=============================================================================
// EP90PDWPickup.
//=============================================================================
class EP90PDWPickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M806.M806_Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyPistolRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M806.PistolMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.M806Clip');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.Pickup_Bullpup'
     PickupDrawScale=0.070000
     InventoryType=Class'BWBP_APC_Pro.EP90PDW'
     RespawnTime=10.000000
     PickupMessage="You picked up the EP110 Photon Bullpup."
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.Pickup_Bullpup'
     Physics=PHYS_None
     DrawScale=0.250000
     CollisionHeight=4.000000
}
