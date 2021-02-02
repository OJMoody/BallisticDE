//=============================================================================
// AP_RS8Clip.
//
// 2 clips for th RS8.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_SX45Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=36
     InventoryType=Class'BWBPAnotherPackDE.Ammo_SX45Bullets'
     PickupMessage="You picked up four SX45 magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.SX45.Static_FNX_Mag'
     DrawScale=0.100000
     PrePivot=(Z=-12.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
