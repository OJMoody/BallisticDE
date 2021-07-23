//=============================================================================
// AH104Pickup.
//=============================================================================
class AH104Pickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.AH104.AH104_SM_Main'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_SKCExp_Pro.AH104Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the AH104 Handcannon"
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.AH104.AH104_SM_Main'
     Physics=PHYS_None
     DrawScale=0.100000
     PrePivot=(Y=-26.000000)
     CollisionHeight=4.000000
}
