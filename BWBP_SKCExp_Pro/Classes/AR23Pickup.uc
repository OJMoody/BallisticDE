//=============================================================================
// AR23Pickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AR23Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.AR23.AR23_SM_Main'
     PickupDrawScale=0.130000
     InventoryType=Class'BWBP_SKCExp_Pro.AR23HeavyRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the AR23 'Punisher' Heavy Rifle"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.AR23.AR23_SM_Main'
     Physics=PHYS_None
     DrawScale=0.130000
     CollisionHeight=4.000000
}
