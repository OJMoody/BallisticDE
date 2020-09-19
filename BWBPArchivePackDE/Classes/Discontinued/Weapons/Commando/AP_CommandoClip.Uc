//=============================================================================
// AP_SARClip.
//
// 2 x 40 round clips for the SAR 12.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_CommandoClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=80
     InventoryType=Class'BallisticDE.Ammo_556mm'
     PickupMessage="You got 80 rounds of 5.56mm ammo for the S-AR 12"
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware3.SAR.SARClips'
     DrawScale=0.150000
     PrePivot=(Z=10.000000)
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
