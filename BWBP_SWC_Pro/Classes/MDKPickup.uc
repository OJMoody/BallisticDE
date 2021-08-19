//=============================================================================
// MDKPickup.
//=============================================================================
class MDKPickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.XK2.XK2PickupLo'
     PickupDrawScale=0.250000
     InventoryType=Class'BWBP_SWC_Pro.MDKSubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the MDK Modular SubMachine Gun."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.XK2.XK2PickupHi'
     Physics=PHYS_None
     DrawScale=0.190000
     CollisionHeight=4.000000
}
