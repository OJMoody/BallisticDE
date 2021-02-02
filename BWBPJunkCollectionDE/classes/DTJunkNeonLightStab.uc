//=============================================================================
// DTJunkNeonLightStab.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkNeonLightStab extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k skewered %o with a shattered neon light."
     DeathStrings(1)="%o was impaled on %k's broken neon light."
     ShieldDamage=15
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkNeonBroken'
     DeathString="%k skewered %o with a shattered neon light."
     FemaleSuicide="%o cracked herself with a neon light."
     MaleSuicide="%o cracked himself with a neon light."
}
