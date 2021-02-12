//=============================================================================
// DTXK2SMG.
//
// Damage type for the XK2 SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTP90SMG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o danced through %k's P90 lead."
     DeathStrings(1)="%k cut short %o's cry with a P90 PDW."
     DeathStrings(2)="%k went spec-ops on %o with P90 rounds."
     DeathStrings(3)="%o couldn't match the efficiency of %k's P90."
     EffectChance=0.500000
     WeaponClass=Class'BWBP_JCF_Pro.P90SubMachinegun'
     DeathString="%o danced through %k's P90 lead."
     FemaleSuicide="%o silenced herself."
     MaleSuicide="%o silenced himself."
     bFastInstantHit=True
     VehicleDamageScaling=0.400000
}
