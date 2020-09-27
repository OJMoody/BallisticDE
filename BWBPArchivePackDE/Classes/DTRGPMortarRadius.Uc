//=============================================================================
// DTRPGMortarRadius.
//
// DamageType for the RPG Bazooka mortar rocket radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRGPMortarRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was bombarded by %k's RGP."
     DeathStrings(1)="%o flung %vs into the path of %k's RGP mortar."
     FemaleSuicides(0)="%o forgot where she left one of her mortar rockets."
     MaleSuicides(0)="%o forgot where he left one of his mortar rockets."
     WeaponClass=Class'BWBPArchivePackDE.RGPBazooka'
     DeathString="%o was bombarded by %k's RGP."
     FemaleSuicide="%o forgot where she left one of her mortar rockets."
     MaleSuicide="%o forgot where he left one of his mortar rockets."
     bDelayedDamage=False
	 bExtraMomentumZ=True
     VehicleDamageScaling=5.000000
     VehicleMomentumScaling=3.000000
}
