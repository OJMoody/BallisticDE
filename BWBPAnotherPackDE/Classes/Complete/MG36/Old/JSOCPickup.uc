//=============================================================================
// M30A2Pickup.
//=============================================================================
class JSOCPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticRecolors5.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors5.M30A2.M30A2-SA');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors5.M30A2.M30A2-SB');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors5.M30A2.M30A2-Laser');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors5.M30A2.M30A2-Gauss');
	Level.AddPrecacheMaterial(Texture'ONSstructureTextures.CoreGroup.Invisible');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M900.M900Grenade');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M900.M900MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.M50Magazine');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M50.M50PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M50.M50PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.M50.M50PickupLo'
     InventoryType=Class'BWBPArchivePackDE.JSOCMachineGun'
     RespawnTime=20.000000
     PickupMessage="You picked up the JSOC Mk.88 LSW"
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.M50.M50PickupHi'
     Physics=PHYS_None
     DrawScale=0.350000
     Skins(0)=Texture'BallisticRecolors5.M30A2.M30A2-SA'
     Skins(1)=Texture'BallisticRecolors5.M30A2.M30A2-SB'
     Skins(2)=Combiner'BallisticRecolors5.M30A2.M30A2-GunScope'
     Skins(3)=Texture'BallisticRecolors5.M30A2.M30A2-Gauss'
     Skins(4)=Texture'BallisticRecolors5.M30A2.M30A2-Laser'
     CollisionHeight=4.000000
}
