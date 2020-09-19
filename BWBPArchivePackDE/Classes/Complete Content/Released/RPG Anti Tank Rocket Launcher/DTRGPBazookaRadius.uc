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
     DeathStrings(0)="%o is now a bloody splotch thanks to %k's RPG-7."
     DeathStrings(1)="%o was blasted to bits by %k's RPG rocket."
     DeathStrings(2)="%k's spiraling rocket tagged unfortunate %o."
     DeathStrings(3)="%k's corkscrewing RPG rocket reduced %o to paste."
     FemaleSuicides(0)="%o blew herself to bits with an RPG-7."
     FemaleSuicides(1)="%o underestimated the power of her RPG-7."
     FemaleSuicides(2)="%o failed to use her RPG-7 correctly."
     MaleSuicides(0)="%o blew himself to bits with an RPG-7."
     MaleSuicides(1)="%o underestimated the power of his RPG-7."
     MaleSuicides(2)="%o failed to use his RPG-7 correctly."
     WeaponClass=Class'BWBPArchivePackDE.RGPBazooka'
     DeathString="%o is now a bloody splotch thanks to %k's RPG-7."
     FemaleSuicide="%o blew herself to bits with an RPG-7."
     MaleSuicide="%o blew himself to bits with an RPG-7."
     bDelayedDamage=False
	 bExtraMomentumZ=True
     VehicleDamageScaling=5.000000
     VehicleMomentumScaling=3.000000
}
