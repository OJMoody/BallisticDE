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
     DeathStrings(0)="%o was utterly obliterated by %k's direct RGP hit."
     DeathStrings(1)="%o was directly hit by %k's RGP-7 rocket."
     DeathStrings(2)="%k spiraled a RGP into %o's chest."
     WeaponClass=Class'BWBP_JCF_Pro.RGPBazooka'
     DeathString="%o was utterly obliterated by %k's direct RGP hit."
     FemaleSuicide="%o splattered the walls with her gibs using a RGP."
     MaleSuicide="%o splattered the walls with his gibs using a RGP."
     bDelayedDamage=False
	 bExtraMomentumZ=True
     VehicleDamageScaling=5.000000
     VehicleMomentumScaling=3.000000
}
