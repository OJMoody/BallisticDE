//=============================================================================
// DTJunkBeerBottle.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkBeerBottle extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k beat %o down with a beer bottle."
     DeathStrings(1)="%o drank too much of %k's beer."
     DeathStrings(2)="%k showed %o how a bar-fight works."
     ShieldDamage=10
     ImpactManager=Class'JunkWarDE.IM_JunkBeerBottleBreak'
     DeathString="%k beat %o down with a beer bottle."
     FemaleSuicide="%o cracked herself with a beer bottle."
     MaleSuicide="%o cracked himself with a beer bottle."
}
