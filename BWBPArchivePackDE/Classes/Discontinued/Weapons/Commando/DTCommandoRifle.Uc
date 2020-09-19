//=============================================================================
// DTSARRifle.
//
// Damage type for the SAR12
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCommandoRifle extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o's light was snuffed out by %k's 552 Commando."
     DeathStrings(1)="%k tore through %o with %kh 552 Commando."
     DeathStrings(2)="%k's 552 Commando riddled %o with holes."
     DeathStrings(3)="%k's 552 Commando consecrated it's way through %o."
     DeathStrings(4)="%k assaulted %o with %kh 552 Commando."
     DeathStrings(5)="%k dispatched %o with 552 Commando rounds."
     DeathStrings(6)="%k's 552 Commando cleared the room %o was hiding in."
     EffectChance=0.500000
     WeaponClass=Class'BWBPArchivePackDE.CommandoAssaultRifle'
     DeathString="%o's light was snuffed out by %k's 552 Commando."
     FemaleSuicide="%o consecrated herself."
     MaleSuicide="%o consecrated himself."
     bFastInstantHit=True
     VehicleDamageScaling=0.600000
}
