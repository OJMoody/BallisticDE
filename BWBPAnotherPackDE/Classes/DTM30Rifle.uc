//=============================================================================
// DTM30Rifle.
//
// Damage type for the CYLO
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM30Rifle extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was perforated by %k's CYLO fire."
     DeathStrings(1)="%o charged into a volley of %k's caseless CYLO rounds."
     DeathStrings(2)="%k pumped %o full of red hot CYLO metal."
     DamageIdent="Assault"
     WeaponClass=Class'BWBPAnotherPackDE.M30AssaultRifle'
     DeathString="%o was perforated by %k's CYLO fire."
     FemaleSuicide="OH NO YOU SOMEHOW SHOT YOURSELF. WHYYYY."
     MaleSuicide="OH GOD YOU SHOT YOURSELF. HOW DID YOU DO THAT."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
