//=============================================================================
// PumaPickup.
//[1:25:41 AM] Marc Moylan: I HATE POSELIB
//[1:25:43 AM] Captain Xavious: lol
//[1:25:44 AM] Marc Moylan: TOO MUCH MOVEMENT
//[1:25:50 AM] Captain Xavious: noooooooo
//=============================================================================
class PumaPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4ArchiveStaticA.PUMA.PumaPickup'
     PickupDrawScale=0.200000
     InventoryType=Class'BWBPArchivePackDE.PumaRepeater'
     RespawnTime=20.000000
     PickupMessage="You picked up the PUMA-77 Repeater"
     PickupSound=Sound'PackageSoundsArchive4A.PUMA.PUMA-Pickup'
     StaticMesh=StaticMesh'BallisticRecolors4ArchiveStaticA.PUMA.PumaPickup'
     Physics=PHYS_None
     DrawScale=0.220000
     CollisionHeight=4.000000
}
