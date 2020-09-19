//=============================================================================
// SARPickup.
//=============================================================================
class CommandoPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticTextures3.utx
#exec OBJ LOAD FILE=BallisticHardware3.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticTextures3.Weapons.SARSkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware3.SAR.SARClips');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware3.SAR.SARPickup-Hi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware3.SAR.SARPickup-Lo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware3.SAR.SARPickup-Lo'
     PickupDrawScale=0.140000
     InventoryType=Class'BWBPArchivePackDE.CommandoAssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the 522 Commando"
     PickupSound=Sound'BallisticSounds2.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BallisticHardware3.SAR.SARPickup-Hi'
     Physics=PHYS_None
     DrawScale=0.140000
     CollisionHeight=4.000000
}
