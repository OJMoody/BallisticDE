//=============================================================================
// DTG5BazookaRadius.
//
// DamageType for the G5 Bazooka radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRGPXBazookaRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o almost escaped %k's G5 rocket."
     DeathStrings(1)="%o was blown in half by %k's G5 rocket."
     DeathStrings(2)="%k completely vaporized %o with a G5 rocket."
     DeathStrings(3)="%k's G5 rocket turned %o into tomato soup."
     FemaleSuicides(0)="%o splattered the walls with her gibs using a G5."
     FemaleSuicides(1)="%o blasted herself across the map with a G5."
     FemaleSuicides(2)="%o blew herself into a chunky haze with the G5."
     MaleSuicides(0)="%o splattered the walls with his gibs using a G5."
     MaleSuicides(1)="%o blasted himself across the map with a G5."
     MaleSuicides(2)="%o blew himself into a chunky haze with the G5."
     InvasionDamageScaling=3.000000
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBP_JCF_Pro.RGPXBazooka'
     DeathString="%o almost escaped %k's G5 rocket."
     FemaleSuicide="%o splattered the walls with her gibs using a G5."
     MaleSuicide="%o splattered the walls with his gibs using a G5."
     bDelayedDamage=True
     VehicleDamageScaling=2.500000
     VehicleMomentumScaling=2.500000
}
