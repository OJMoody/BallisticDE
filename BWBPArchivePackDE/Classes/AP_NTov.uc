//=============================================================================
// AP_M75Clip.
//
// 2 x 7 round clip for the M75.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_NTov extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=3
     InventoryType=Class'BWBPArchivePackDE.Ammo_NTov'
     PickupMessage="You picked up 3 N-TOV bandages"
     PickupSound=Sound'BallisticSounds2.Health.NTovPickup'
     StaticMesh=StaticMesh'BWSkrithRecolorsArchive2Static.NTOV.NTovPickup'
     DrawScale=0.500000
     Skins(0)=Texture'BWSkrithRecolorsArchive2Tex.NTOV.NTOVSkin'
     CollisionRadius=12.000000
     CollisionHeight=5.000000
}
