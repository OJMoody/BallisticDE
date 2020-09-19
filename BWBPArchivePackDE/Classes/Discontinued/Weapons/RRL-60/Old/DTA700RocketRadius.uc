//=============================================================================
// DTA700BazookaRadius.
//
// DamageType for the A700 Bazooka radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA700RocketRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o almost escaped %k's A700 rocket."
     DeathStrings(1)="%o was blown in half by %k's A700 rocket."
     DeathStrings(2)="%k completely vaporized %o with a A700 rocket."
     DeathStrings(3)="%k's A700 rocket turned %o into tomato soup."
     FemaleSuicides(0)="%o splattered the walls with her gibs using a A700."
     FemaleSuicides(1)="%o blasted herself across the map with a A700."
     FemaleSuicides(2)="%o blew herself into a chunky haze with the A700."
     MaleSuicides(0)="%o splattered the walls with his gibs using a A700."
     MaleSuicides(1)="%o blasted himself across the map with a A700."
     MaleSuicides(2)="%o blew himself into a chunky haze with the A700."
     WeaponClass=Class'BWBPArchivePackDE.A700SkrithRocketLauncher'
     DeathString="%o almost escaped %k's A700 rocket."
     FemaleSuicide="%o splattered the walls with her gibs using a A700."
     MaleSuicide="%o splattered the walls with his gibs using a A700."
     bDelayedDamage=True
     VehicleDamageScaling=2.000000
     VehicleMomentumScaling=1.500000
}
