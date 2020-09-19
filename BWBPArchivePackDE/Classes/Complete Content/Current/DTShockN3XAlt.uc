//=============================================================================
// DTMRS138Tazer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTShockN3XAlt extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k's meaty uppercut knocked %o the hell out."
     DeathStrings(1)="%k's thunderous strike drove %o's jaw into his skull."
     DeathStrings(2)="%k fed %o RAW, CHUNKY VOLTS to the FACE."
     DeathStrings(3)="%k's hellish blow shot %o into the skybox."
     DeathStrings(4)="%k struck down %o with the fist of Thor."
     FlashThreshold=45
     FlashV=(X=400.000000,Y=400.000000,Z=1000.000000)
     FlashF=0.100000
     bCanBeBlocked=True
     ShieldDamage=15
     DamageIdent="Melee"
     DamageDescription=",Blunt,Electro"
     ImpactManager=Class'BallisticDE.IM_MRS138TazerHit'
     WeaponClass=Class'BWBPArchivePackDE.N3XPlaz'
     DeathString="%k administered a healthy dose of ass-whuppin' to %o."
     FemaleSuicide="%o zapped herself."
     MaleSuicide="%o zapped himself."
     bArmorStops=False
     bInstantHit=True
     bCauseConvulsions=True
     bNeverSevers=True
     PawnDamageSounds(0)=SoundGroup'BWAddPack-RS-Sounds.MRS38.RSS-ElectroFlesh'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     VehicleDamageScaling=0.350000
     VehicleMomentumScaling=0.050000
}
