//=============================================================================
// DTXK2SMGHead.
//
// Damage type for the XK2 SMG headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTP90SMGHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o took a hail of %k's P90 bullets to the face."
     DeathStrings(1)="%k wiped the smile off %o's face with %kh P90."
     DeathStrings(2)="%o lost %vh dopey head to %k's P90 burst."
     EffectChance=0.500000
     bHeaddie=True
     WeaponClass=Class'BWBPArchivePackDE.P90SubMachinegun'
     DeathString="%o took a hail of %k's P90 bullets to the face."
     FemaleSuicide="%o silenced herself."
     MaleSuicide="%o silenced himself."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     VehicleDamageScaling=0.450000
}
