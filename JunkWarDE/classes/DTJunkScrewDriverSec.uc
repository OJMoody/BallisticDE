//=============================================================================
// DTJunkScrewDriverSec.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkScrewDriverSec extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k punctured %o into sponge with %kh screw driver."
     DeathStrings(1)="%o got %vs ruptured on %k's brand new screw driver."
     ShieldDamage=15
     DamageDescription=",Stab,"
     ImpactManager=Class'JunkWarDE.IM_JunkScrewDriverSec'
     DeathString="%k punctured %o into sponge with %kh screw driver."
     FemaleSuicide="%o cracked herself with a screw driver."
     MaleSuicide="%o cracked himself with a screw driver."
}
