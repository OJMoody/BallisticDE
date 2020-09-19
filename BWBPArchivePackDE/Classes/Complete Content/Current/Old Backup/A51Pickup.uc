//=============================================================================
// FP7Pickup.
//=============================================================================
class A51Pickup extends BallisticWeaponPickup
	placeable;
/*
#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx
*/

/*simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.FP7.FP7Grenade');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.FlameParts');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.BlazingSubdivide');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
}*/
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolors1Static.SkrithGrenadeProj');
	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolors1Static.SkrithGrenadePickupHi');

}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWSkrithRecolors1Static.SkrithGrenadePickupHi'
     PickupDrawScale=0.500000
     bWeaponStay=False
     InventoryType=Class'BWBPArchivePackDE.A51Grenade'
     RespawnTime=20.000000
     PickupMessage="You picked up the AD-51 Reptile Corossive Grenade"
     PickupSound=Sound'BallisticSounds2.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BWSkrithRecolors1Static.SkrithGrenadePickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     CollisionHeight=5.600000
}
