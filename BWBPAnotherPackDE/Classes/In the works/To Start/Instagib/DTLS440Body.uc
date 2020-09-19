//=============================================================================
// DTLS440Body
//
// DT for Super Laser Carbine body shots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTLS440Body extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="Red pulses from %k's LS440 reduced %o to ash."
     DeathStrings(1)="%k's LS-440 mercilessly lasered %o away."
     DeathStrings(2)="%o took a red storm of %k's lasers to the chest."
     DeathStrings(3)="%k singed %o's chest with a LS-440 laser fusilade."
     BloodManagerName="BWBPArchivePackPro2.BloodMan_HMCLaser"
     ShieldDamage=3
     bIgniteFires=True
     DamageDescription=",Laser,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=2.000000
     WeaponClass=Class'BWBPArchivePackPro2.LS440Instagib'
     DeathString="Red pulses from %k's LS440 reduced %o to ash."
     FemaleSuicide="%o cannot use a carbine effectively."
     MaleSuicide="%o stinks at using laser carbines."
     bInstantHit=True
     GibPerterbation=1.200000
     KDamageImpulse=1000.000000
}
