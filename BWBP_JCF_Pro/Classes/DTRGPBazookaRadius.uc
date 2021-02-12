//=============================================================================
// DTRPGBazookaRadius.
//
// DamageType for the RPG Bazooka radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRGPBazookaRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o is now a bloody splotch thanks to %k's RGP-7."
     DeathStrings(1)="%o was blasted to bits by %k's RGP rocket."
     DeathStrings(2)="%k's spiraling rocket tagged unfortunate %o."
     DeathStrings(3)="%k's corkscrewing RGP rocket reduced %o to paste."
     FemaleSuicides(0)="%o blew herself to bits with an RGP-7."
     FemaleSuicides(1)="%o underestimated the power of her RGP-7."
     FemaleSuicides(2)="%o failed to use her RGP-7 correctly."
     MaleSuicides(0)="%o blew himself to bits with an RGP-7."
     MaleSuicides(1)="%o underestimated the power of his RGP-7."
     MaleSuicides(2)="%o failed to use his RGP-7 correctly."
     WeaponClass=Class'BWBP_JCF_Pro.RGPBazooka'
     DeathString="%o is now a bloody splotch thanks to %k's RGP-7."
     FemaleSuicide="%o blew herself to bits with an RGP-7."
     MaleSuicide="%o blew himself to bits with an RGP-7."
     bDelayedDamage=False
	 bExtraMomentumZ=True
     VehicleDamageScaling=5.000000
     VehicleMomentumScaling=3.000000
}
