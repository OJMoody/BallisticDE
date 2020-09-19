//=============================================================================
// DTRPGBazooka.
//
// DamageType for the RPG Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRGPBazooka extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was utterly obliterated by %k's direct RPG hit."
     DeathStrings(1)="%o was directly hit by %k's RPG-7 rocket."
     DeathStrings(2)="%k spiraled a RPG into %o's chest."
     WeaponClass=Class'BWBPArchivePackDE.RGPBazooka'
     DeathString="%o was utterly obliterated by %k's direct RPG hit."
     FemaleSuicide="%o splattered the walls with her gibs using a RPG."
     MaleSuicide="%o splattered the walls with his gibs using a RPG."
     bDelayedDamage=True
     VehicleDamageScaling=5.000000
     VehicleMomentumScaling=3.000000
}
