//=============================================================================
// DTRPGMortar.
//
// DamageType for the RPG Bazooka mortar rockets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRGPMortar extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o caught %k's RGP mortar."
     DeathStrings(1)="%k's RGP mortar took %o to heaven."
     DeathStrings(2)="%o took an express trip to hell thanks to %k's RGP mortar."
     WeaponClass=Class'BWBPArchivePackDE.RGPBazooka'
     DeathString="%o caught %k's RGP mortar."
     FemaleSuicide="%o caught one of her own RGP mortars."
     MaleSuicide="%o caught one of his own RGP mortars."
     bDelayedDamage=False
	 bExtraMomentumZ=True
     GibPerterbation=0.800000
     VehicleDamageScaling=5.000000
     VehicleMomentumScaling=3.000000
}
