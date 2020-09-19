//=============================================================================
// Ammo_HKMK 23.
//
// 45.ACP Low Velocity Pistol bullets for the HKMK 23.
//
// by Fischer Felix
//=============================================================================
class Ammo_45ACP extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=64
     InitialAmount=32
     IconFlashMaterial=Shader'BWWeaponPackArchive-Tex.MK23.AmmoIcon_MK23Flash'
     PickupClass=Class'BWBPArchivePackDE.AP_45ACP'
     IconMaterial=Texture'BWWeaponPackArchive-Tex.MK23.AmmoIcon_MK23'
     IconCoords=(X2=63,Y2=63)
     ItemName="45. ACP Bullets"
}
