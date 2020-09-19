//=============================================================================
// DTG5Bazooka.
//
// DamageType for the G5 Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA700Rocket extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was blown to pieces by %k's A700."
     DeathStrings(1)="%o caught %k's A700 rocket."
     DeathStrings(2)="%k launched %kh A700 rocket into %o's face."
     WeaponClass=Class'BWBPArchivePackDE.A700SkrithRocketLauncher'
     DeathString="%o was blown to pieces by %k's A700."
     FemaleSuicide="%o splattered the walls with her gibs using an A700."
     MaleSuicide="%o splattered the walls with his gibs using an A700."
     bDelayedDamage=True
     VehicleDamageScaling=2.000000
     VehicleMomentumScaling=1.500000
}
