//=============================================================================
// DTMGA88MG.
//
// Damage type for the M353 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMGA88MG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o died in a MGX4 bullet holocaust."
     DeathStrings(1)="%o was ripped apart in %k's MGX4 bullet hail."
     DeathStrings(2)="%k's Schwarzspecht hammered 7.92 mm rounds into %o's stoned face."
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBPArchivePackDE.MGA88Machinegun'
     DeathString="%o died in a MGX4 bullet holocaust."
     FemaleSuicide="%o shot herself in the foot with the MGX4."
     MaleSuicide="%o shot himself in the foot with the MGX4."
     bFastInstantHit=True
     VehicleDamageScaling=0.000000
}
