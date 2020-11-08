//=============================================================================
// Ammo_Tranq.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_Tranq extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=120
     InitialAmount=60
     bTryHeadShot=True
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBPAnotherPackDE.AP_Tranq'
     IconMaterial=Texture'BallisticRecolors4TexPro.M30A2.AmmoIcon_M30A2'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="Tranquilizer Darts"
}
