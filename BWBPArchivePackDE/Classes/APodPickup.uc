//=============================================================================
// FP7Pickup.
//=============================================================================
class APodPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWSkrithRecolorsArchive2Static.APod.APodPickup'
     PickupDrawScale=0.150000
     bWeaponStay=False
     InventoryType=Class'BWBPArchivePackDE.APodCapsule'
     RespawnTime=20.000000
     PickupMessage="You picked up the A-Pod Adrenaline Capsule"
     PickupSound=Sound'BallisticSounds2.Health.AdrenalinPickup'
     StaticMesh=StaticMesh'BWSkrithRecolorsArchive2Static.APod.APodPickup'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.150000
     CollisionRadius=8.000000
     CollisionHeight=3.500000
}
