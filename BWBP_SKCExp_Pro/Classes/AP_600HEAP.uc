//=============================================================================
// AP_600HEAP.
//
// 14 massive .600 HEAP rounds.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_600HEAP extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=14
     InventoryType=Class'BWBP_SKCExp_Pro.Ammo_600HEAP'
     PickupMessage="You got 14 .600 HEAP rounds"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.D49.D49AmmoBox'
     DrawScale=0.400000
     PrePivot=(Z=75.000000)
     Skins(0)=Texture'BWBP_SKC_TexExp.AH104.AH104AmmoSkin'
     CollisionRadius=8.000000
     CollisionHeight=18.000000
}
