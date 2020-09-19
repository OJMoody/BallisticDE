//=============================================================================
// AP_HKMK23Clip.
//
// Clips for the HKMK 23
//
// by Fischer Felix
//=============================================================================
class AP_45ACP extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=24
     InventoryType=Class'BWBPArchivePackDE.Ammo_45ACP'
     PickupMessage="You got 24 .45 ACP rounds for the Mk.23"
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.M806Clip'
     DrawScale=0.300000
     Skins(0)=Texture'BWWeaponPack-Tex.MK23.MK23_Ammo'
     CollisionRadius=8.000000
     CollisionHeight=16.000000
}
