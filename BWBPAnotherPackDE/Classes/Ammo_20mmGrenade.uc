//=============================================================================
// Ammo_20mmGrenade
//
// Ammo for the Bulldog Alt Fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_20mmGrenade extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=8
     InitialAmount=2
     IconFlashMaterial=Shader'BallisticRecolors3TexPro.SRAC.AmmoIcon_FRAGFlash'
     PickupClass=Class'BWBPAnotherPackDE.AP_Frag12Box'
     IconMaterial=Texture'BallisticRecolors3TexPro.SRAC.AmmoIcon_FRAG'
     IconCoords=(X2=64,Y2=64)
     ItemName="Riot Toxic Grenades"
}
