//=============================================================================
//PUGUP
//class BulldogPickup extends BallisticHandgunPickup
//[8:53:20 PM] Marc Moylan: this has been here forever
//[8:53:37 PM] Marc Moylan: I think it still thinks it is an AH104
//=============================================================================
class PUGPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPAnotherPackStatics.PUG.Pickup_PUG12_Weapon'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBPAnotherPackDE.PUGAssaultCannon'
     RespawnTime=10.000000
     PickupMessage="You picked up the PUG-M2 Riot Suppression Cannon"
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBPAnotherPackStatics.PUG.Pickup_PUG12_Weapon'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
