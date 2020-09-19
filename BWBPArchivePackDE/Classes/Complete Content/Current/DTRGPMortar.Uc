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
     DeathStrings(0)="%o caught %k's RPG mortar."
     DeathStrings(1)="%k's RPG mortar took %o to heaven."
     DeathStrings(2)="%o took an express trip to hell thanks to %k's RPG mortar."
     WeaponClass=Class'BWBPArchivePackDE.RGPBazooka'
     DeathString="%o caught %k's RPG mortar."
     FemaleSuicide="%o caught one of her own RPG mortars."
     MaleSuicide="%o caught one of his own RPG mortars."
     bDelayedDamage=True
     GibPerterbation=0.800000
	 VehicleDamageScaling=5.000000
     VehicleMomentumScaling=3.000000
}
