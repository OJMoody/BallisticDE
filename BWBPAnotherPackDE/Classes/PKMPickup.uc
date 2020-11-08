//=============================================================================
// M353Pickup.
//=============================================================================
class PKMPickup extends BallisticWeaponPickup
	placeable;
	
/*
#exec OBJ LOAD FILE=BWBPAnotherPackTex.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BWBPAnotherPackStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBPAnotherPackTex.PKM.PKM-Main');
	L.AddPrecacheMaterial(Texture'BWBPAnotherPackTex.PKM.PKM-Spec');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M353.M353MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBPAnotherPackTex.PKM.PKM-Main');
	Level.AddPrecacheMaterial(Texture'BWBPAnotherPackTex.PKM.PKM-Spec');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M353.M353MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.MachinegunBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M353.M353PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M353.M353PickupLo');
}
*/

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBPAnotherPackStatics.PKMA.PKMA-Main'
     PickupDrawScale=0.100000
     StandUp=(Y=0.800000)
     InventoryType=Class'BWBPAnotherPackDE.PKMMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the PKMA machinegun."
     PickupSound=Sound'BallisticSounds2.M353.M353-Putaway'
     StaticMesh=StaticMesh'BWBPAnotherPackStatics.PKMA.PKMA-Main'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=12.000000
}
