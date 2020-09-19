//=============================================================================
// DTA73bStab.
//
// Damagetype for the A73b bayonette attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_SkrithStaffStab extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%o was impaled on the blades of %k's Elite A73."
     DeathStrings(1)="%o was split like a pear by %k's Elite A73 blades."
     DeathStrings(2)="%k skewered %o with the Elite A73."
     DamageDescription=",Stab,"
     WeaponClass=Class'BWBPArchivePackDE.SkrithStaff'
     DeathString="%o was impaled on the blades of %k's Elite A73."
     FemaleSuicide="%o cut herself on her Elite A73."
     MaleSuicide="%o cut himself on his Elite A73."
     bArmorStops=False
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'BallisticSounds2.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.500000
}
