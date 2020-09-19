//=============================================================================
// JohnsonPickup.
//=============================================================================
class JohnsonPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors5Static.Bulldog.BulldogPickupLow'
     PickupDrawScale=4.000000
     InventoryType=Class'BWBPAnotherPackDE.JohnsonRifle'
     RespawnTime=10.000000
     PickupMessage="You picked up the 'Hell Shredder' Stake Launcher"
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BallisticRecolors5Static.Bulldog.BulldogPickupHi'
     Physics=PHYS_None
     DrawScale=8.000000
//     PrePivot=(Y=-26.000000)
     CollisionHeight=4.000000
}
