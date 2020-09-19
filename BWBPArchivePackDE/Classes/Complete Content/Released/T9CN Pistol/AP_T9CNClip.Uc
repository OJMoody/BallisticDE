//=============================================================================
// AP_XK2Clip.
//
// 2 40 round 9mm clips for the XK2.
//
// by Nolan "Dark Carnivour" Richert. Uses Sarge's CYLO ammo pickup.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_T9CNClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=24
     InventoryType=Class'BWBPArchivePackDE.Ammo_9mmT9CN'
     PickupMessage="You got 2 12 round 9mm clips"
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP4-Hardware.Glock.Glock-Ammo'
     DrawScale=0.160000
	 PrePivot=(Z=50.000000)
     CollisionRadius=8.000000
     CollisionHeight=16.00000
}
