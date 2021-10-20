//=============================================================================
// PugPickup.
//=============================================================================
class PugPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.Pug.PUG_SM'
     PickupDrawScale=5.000000
     InventoryType=Class'BWBP_SKCExp_Pro.PugAssaultCannon'
     RespawnTime=10.000000
     PickupMessage="You picked up the PUG-M2 Riot Cannon."
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.Pug.PUG_SM'
     Physics=PHYS_None
     DrawScale=0.7000000
     CollisionHeight=4.000000
}
