//=============================================================================
// DTLS440Head.
//
// DT for LS440 headshots. Adds RED blinding effect and motion blur.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTLS440Head extends DT_BWMiscDamage;

var float	FlashF_1;
var vector	FlashV_1;

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF_1, default.FlashV_1);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     FlashF_1=0.300000
     FlashV_1=(X=2000.000000,Y=700.000000,Z=700.000000)
     DeathStrings(0)="%o's face was doctored up by %k's lethal LS-440."
     DeathStrings(1)="%k's laser eye surgery on %o went horribly wrong."
     DeathStrings(2)="%k submitted %o to LS-440 cranial surgery."
     DeathStrings(3)="%o's head is incompatible with %k's LS-440 wavelengths."
     BloodManagerName="BWBPArchivePackPro2.BloodMan_HMCLaser"
     ShieldDamage=5
     bIgniteFires=True
     DamageDescription=",Laser,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBPArchivePackPro2.LS440Instagib'
     DeathString="%o's face was doctored up by %k's lethal LS-440."
     FemaleSuicide="%o blasted her eyes out."
     MaleSuicide="%o blasted himself in the eye."
     bInstantHit=True
     bAlwaysSevers=True
     GibModifier=3.000000
     GibPerterbation=1.200000
     KDamageImpulse=1000.000000
}
