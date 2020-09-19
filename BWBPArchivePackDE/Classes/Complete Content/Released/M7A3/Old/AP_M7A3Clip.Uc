//=============================================================================
// AP_M7A3Clip.
//
// 2 x 50 round clips for the M7A3.
//
// by Nolan "Dark Carnivour" Richert. Uses Sergeant Kelly's CYLO ammo model.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_M7A3Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=100
     InventoryType=Class'BWBPArchivePackDE.Ammo_447mm'
     PickupMessage="You got 100 rounds of 4.47mm ammo for the M7A3"
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWWeaponPackArchive-Static.P90.P90Ammo'
     DrawScale=2.350000
     Skins(0)=Texture'BWWeaponPackArchive-Tex.M7A3.M7A3Clip'
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
