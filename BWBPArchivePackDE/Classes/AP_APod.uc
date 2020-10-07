//=============================================================================
// AP_M75Clip.
//
// 2 x 7 round clip for the M75.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_APod extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=2
     InventoryType=Class'BWBPArchivePackDE.Ammo_APod'
     PickupMessage="You picked up 2 A-Pod Capsules"
     PickupSound=Sound'BallisticSounds2.Health.AdrenalinPickup'
     StaticMesh=StaticMesh'BWSkrithRecolorsArchive2Static.APod.APodPickup'
     DrawScale=0.150000
     Skins(0)=Texture'BWSkrithRecolorsArchive1Tex.APod.APodSkin'
     CollisionRadius=12.000000
     CollisionHeight=5.000000
}
