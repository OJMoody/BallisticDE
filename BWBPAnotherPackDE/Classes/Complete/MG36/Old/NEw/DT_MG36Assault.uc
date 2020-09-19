//=============================================================================
// DT_MARSAssault.
//
// DamageType for the MASR assault rifle primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MG36Assault extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's MG36 riddled %o with bulletholes."
     DeathStrings(1)="%o failed to clear %k's MG36 crosshairs."
     DeathStrings(2)="%k savagely lit %o up with MG36 fire."
     DeathStrings(3)="%k terminated %o with an accurate MG36 burst."
     DamageIdent="Assault"
     WeaponClass=Class'BWBPArchivePackDE.MG36MachineGun'
     DeathString="%k's MG36 riddled %o with bulletholes."
     FemaleSuicide="%o tactically missed with the planet MG36."
     MaleSuicide="%o tactically missed with a MG36 bar."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
