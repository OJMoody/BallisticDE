//=============================================================================
// DT_RSDarkStab.
//
// Damagetype for the DarkStar saw attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_ChainsawStab extends DT_BWBlade;

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
 	if (xPawn(Victim) != None)
 	{
		if (default.PawnDamageSounds.Length > 0)
			Victim.PlaySound(default.PawnDamageSounds[Rand(default.PawnDamageSounds.Length)],SLOT_None,default.TransientSoundVolume,false,default.TransientSoundRadius);
		if (default.EffectChance > 0 && default.EffectChance > FRand())
			DoBloodEffects(HitLocation, Damage, Momentum, Victim, bLowDetail);
	}
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     DeathStrings(0)="%o was sawed in half by %k's chainsaw longsword."
     DeathStrings(1)="%k's MAG-SAW ripped %o open."
     DeathStrings(2)="%o was dismembered by %k's chainsaw-assisted slashes."
     BloodManagerName="BWBPSomeOtherPackDE.BloodMan_Chainsaw"
     DamageIdent="Melee"
     DamageDescription=",Slash,Hack,"
     WeaponClass=Class'BWBPSomeOtherPackDE.MAG78Longsword'
     DeathString="%o screeched and lept onto %k's Dark Star saw."
     FemaleSuicide="%o somehow managed to end herself with her MAG-SAW."
     MaleSuicide="%o somehow managed to end himself with his MAG-SAW."
     bAlwaysSevers=True
     PawnDamageSounds(0)=SoundGroup'BWBP4-Sounds.DarkStar.Dark-Flesh'
     KDamageImpulse=2000.000000
     TransientSoundVolume=0.900000
	 GibModifier=2
	 EffectChance=1.00
}
