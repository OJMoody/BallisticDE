//=============================================================================
// DTMG42MG.
//
// Damage type for the MG42 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMG42MG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was torn to shreds by %k's MG42."
     DeathStrings(1)="%o was blasted into ribbons by %k's MG42."
     DeathStrings(2)="%o was machinegunned in half by %k's MG42."
     HipString="HIP SPAM"
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBPArchivePackDE.MG42Machinegun'
     DeathString="%o was torn to shreds by %k's MG42."
     FemaleSuicide="%o shot herself in the foot with the MG42."
     MaleSuicide="%o shot himself in the foot with the MG42."
     bFastInstantHit=True
}
