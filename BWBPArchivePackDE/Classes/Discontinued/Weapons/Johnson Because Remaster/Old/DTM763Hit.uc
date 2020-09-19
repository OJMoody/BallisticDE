//=============================================================================
// DTM763Hit.
//
// Damagetype for M763 Melee attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM763Hit extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k bludgeoned %o to death in a wild frenzy with the M763."
     DeathStrings(1)="%o was pummelled into a heap by %k with the M763."
     DeathStrings(2)="%k beat %o to a pulp with the M763."
     DamageIdent="Melee"
     bDisplaceAim=True
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=1.700000
     WeaponClass=Class'BWBPArchivePackDE.M763Shotgun'
     DeathString="%k bludgeoned %o to death in a wild frenzy with the M763."
     FemaleSuicide="%o beat herself to death with the M763."
     MaleSuicide="%o beat himself to death with the M763."
}
