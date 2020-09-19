//=============================================================================
// GASCPickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class GASCPickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPAnotherPackStatics2.GASC.GASC_Pickup_Weapon'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBPAnotherPackDE.GASCPistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the Gaucho and Stallion"
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBPAnotherPackStatics2.GASC.GASC_Pickup_Weapon'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
