//=============================================================================
// DT_SkrithStaff.
//
// Damage type for A73B projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_SkrithStaff extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k fused together parts of %o with the A73-E."
     DeathStrings(1)="%o was melted by %k's A73-E."
     DeathStrings(2)="%o was caught in the red glare of %k's A73-E."
     DeathStrings(3)="%k gave %o a red tint with the A73-E."
     BloodManagerName="BWBPArchivePackDE.BloodMan_A73B"
     bIgniteFires=True
     DamageDescription=",Flame,Plasma,"
     bOnlySeverLimbs=True
     WeaponClass=Class'BWBPArchivePackDE.SkrithStaff'
     DeathString="%k fused parts of %o with the A73-E."
     FemaleSuicide="%o's A73-E turned on her."
     MaleSuicide="%o's A73-E turned on him."
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.900000
}
