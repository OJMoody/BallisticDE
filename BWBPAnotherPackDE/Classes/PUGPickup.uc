//=============================================================================
//PUGUP
//class BulldogPickup extends BallisticHandgunPickup
//[8:53:20 PM] Marc Moylan: this has been here forever
//[8:53:37 PM] Marc Moylan: I think it still thinks it is an AH104
//=============================================================================
class PUGPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_TexExp.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.PUG.Pickup_PUG12_Weapon'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBPAnotherPackDE.PUGAssaultCannon'
     RespawnTime=10.000000
     PickupMessage="You picked up the PUG-M2 Riot Suppression Cannon"
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.PUG.Pickup_PUG12_Weapon'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
