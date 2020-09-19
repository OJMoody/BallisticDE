//=============================================================================
// DTMG42MG.
//
// Damage type for the MG42 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMG42MG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k doesn’t need fancy tech to tear %o to pieces."
     DeathStrings(1)="%o's superior complex and his body was shattered by %k's MG43."
     DeathStrings(2)="%k's MG43 showed %o that it can still kill just as good as the other guns."
	 DeathStrings(3)="%o took all of %k's bullets like a champ, even if he perished."
	 DeathStrings(4)="%k went old school on %o."
	 DeathStrings(5)="%o couldn’t respect the past and was shot down by %k."
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBPArchivePackDE.MG42Machinegun'
     DeathString="%o was torn to shreds by %k's MG43."
     FemaleSuicide="%o shot herself in the foot with the MG43."
     MaleSuicide="%o shot himself in the foot with the MG43."
     bFastInstantHit=True
}
