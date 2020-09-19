//=============================================================================
// EP90PDWPickup.
//=============================================================================
class EP90PDWPickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M806.M806_Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyPistolRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M806.PistolMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.M806Clip');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPAnotherPackStatics.Pickup_Bullpup'
     PickupDrawScale=0.070000
     InventoryType=Class'BWBPAnotherPackDE.EP90PDW'
     RespawnTime=10.000000
     PickupMessage="You picked up the EP110 Photon Bullpup."
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBPAnotherPackStatics.Pickup_Bullpup'
     Physics=PHYS_None
     DrawScale=0.250000
     CollisionHeight=4.000000
}
