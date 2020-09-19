//=============================================================================
// AK47Pickup.
//=============================================================================
class BarrierPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.A42.A42_Exp');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.A42Scorch');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A73MuzzleFlash');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A42Projectile');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A42Projectile2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42Projectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.A42.A42PickupLo'
     PickupDrawScale=0.187000
     InventoryType=Class'BWBPAnotherPackDE.BarrierRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the Rebounder"
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.A42.A42PickupHi'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=4.500000
}
