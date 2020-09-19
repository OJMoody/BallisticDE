//=============================================================================
// AP_KG16Clip.
//
// Clips for the KG16.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_KG16Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=48
     InventoryType=Class'BWBPArchivePackDE.Ammo_45HV'
     PickupMessage="You picked up .45 high velocity KG16 bullets."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWXWeaponArchiveStatics.KG16.KG16Mag'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=16.000000
}
