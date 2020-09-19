//=============================================================================
// R9Pickup.
//=============================================================================
class LS440Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4.utx
#exec OBJ LOAD FILE=BallisticRecolors4Static.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4.LS14.LS14-Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4Static.LaserCarbine.LaserCarbinePickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4Static.LaserCarbine.PlasmaMuzzleFlash');

}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4Static.LaserCarbine.LaserCarbinePickup'
     PickupDrawScale=1.400000
     InventoryType=Class'BWBPArchivePackPro2.LS440Instagib'
     RespawnTime=60.000000
     PickupMessage="You picked up the LS-440M Instagib Rifle"
     PickupSound=Sound'PackageSounds4.LS14.Gauss-Pickup'
     StaticMesh=StaticMesh'BallisticRecolors4Static.LaserCarbine.LaserCarbinePickup'
     Physics=PHYS_None
     DrawScale=1.400000
     Skins(2)=Shader'BallisticRecolors4.LS440M.LS440_SD'
     Skins(4)=Shader'BallisticRecolors4.LS440M.LS440_SD'
     CollisionHeight=3.000000
}
