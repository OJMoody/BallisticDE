//=============================================================================
// DTA42Skrith.
//
// Damage type for A42 projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA85Skrith extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k enlightened %o with A85 fire."
     DeathStrings(1)="%k fused %o into a corpse."
     BloodManagerName="BallisticDE.BloodMan_A73Burn"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BWBPArchivePackDE.A85SkrithShotgun'
     DeathString="%k enlightened %o with A85 fire."
     FemaleSuicide="%o's A85 fused her into a corpse."
     MaleSuicide="%o's A85 fused him into a corpse."
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
