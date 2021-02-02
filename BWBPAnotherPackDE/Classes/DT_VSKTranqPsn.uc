//=============================================================================
// DTMRS138Tazer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_VSKTranqPsn extends DT_BWMiscDamage;

var float	FlashF1;
var vector	FlashV1;

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF1, default.FlashV1);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     FlashF1=0.400000
     FlashV1=(Y=2000.000000)
     DeathStrings(0)="%o was knocked out by %k's VSK-42."
     DeathStrings(1)="%k's VSK put %o into a deep sleep."
     DeathStrings(2)="%o was pricked by %k's tranq dart."
     DeathStrings(3)="%k's tranq dart put %o out cold."
     DeathStrings(4)="%k nonlethally downed %o with a VSK."
     bDetonatesBombs=False
     DamageDescription=",Gas,GearSafe,Hazard,"
     MinMotionBlurDamage=1.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=3.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBPAnotherPackDE.VSKTranqRifle'
     DeathString="%o was knocked out by %k's VSK-42."
     FemaleSuicide="%o knocked herself out."
     MaleSuicide="%o knocked himself out."
     bArmorStops=False
     bInstantHit=True
     bCausesBlood=False
     bDelayedDamage=True
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'BWBP_SKC_SoundsExp.VSK.VSK-Poison'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.001000
     KDamageImpulse=90000.000000
     VehicleDamageScaling=0.001000
     VehicleMomentumScaling=0.001000
}
