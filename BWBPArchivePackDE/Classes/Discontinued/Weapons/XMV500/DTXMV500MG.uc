//=============================================================================
// DTXMV500MG.
//
// Damage type for the XMV500 Minigun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXMV500MG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was gunned down by %k's VL-500."
     DeathStrings(1)="%k filled %o with VL-500 lead."
     DeathStrings(2)="%o was shredded by %k's VL-500 minigun."
     DeathStrings(3)="%o was at the business end of %k's minigun."
     bIgniteFires=True
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBPArchivePackDE.XMV500Minigun'
     DeathString="%o was gunned down by %k's VL-500."
     FemaleSuicide="%o was rejected by her own minigun."
     MaleSuicide="%o was rejected by his own minigun."
     bFastInstantHit=True
     VehicleDamageScaling=0.100000
     VehicleMomentumScaling=0.050000
}
