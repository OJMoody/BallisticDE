//=============================================================================
// DTdart.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTDart extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k turned %o into a sieve."
     DeathStrings(1)="%o got some new holes now."
     DeathStrings(2)="BULLSEYE! Aka. %k killed %o with a dart."
     DeathStrings(3)="%o knows what it feels like to be killed by %k's dart now."
     ShieldDamage=2
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkScrewDriver'
     DeathString="%k punctured %o into sponge with %kh dart."
     FemaleSuicide="%o cracked herself with a dart."
     MaleSuicide="%o cracked himself with a dart."
}
