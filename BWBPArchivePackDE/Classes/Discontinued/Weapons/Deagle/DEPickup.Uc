//=============================================================================
// M806Pickup. Uses Sarge's AH208 model.
//=============================================================================
class DEPickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     PickupDrawScale=0.400000
     InventoryType=Class'BWBPArchivePackDE.DEPistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the Desert Eagle .50 Pistol"
     PickupSound=Sound'BallisticSounds2.MRT6.MRT6Pullout'
     StaticMesh=StaticMesh'BWWeaponPack-Static.DE.DE'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=4.000000
}
