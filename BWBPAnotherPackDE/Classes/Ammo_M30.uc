//=============================================================================
// Ammo_CYLO.
//
// 7.62mm Caseless Ammo. Used by CYLO.
//
// by Casey 'Xavious' Johnson
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_M30 extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=120
     InitialAmount=80
     IconFlashMaterial=Shader'BWBPAnotherPackTex2.AR.ARAmmoIconFlash'
     PickupClass=Class'BWBPAnotherPackDE.AP_M30Clip'
     IconMaterial=Texture'BWBPAnotherPackTex2.AR.ARAmmoIcon'
     IconCoords=(X2=64,Y2=64)
     ItemName="7.62mm Caseless Ammo"
}
