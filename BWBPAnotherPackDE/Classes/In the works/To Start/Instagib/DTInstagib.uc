//=============================================================================
// DTInstagib.
//
// Damagetype for INSTADEATH LASER.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTInstagib extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k stripped the atoms from %o's bones!"
     DeathStrings(1)="%o was liquified by %k's super shock beam!"
     DeathStrings(2)="%k's super laser atomized helpless %o!"
     DeathStrings(3)="%o's body was completely disintegrated by %k's instagib beam!"
     WeaponClass=Class'BWBPArchivePackPro2.LS440Instagib'
     DeathString="%k stripped the atoms from %o's bones!"
     FemaleSuicide="%o EXPLODED IN ANGER."
     MaleSuicide="%o EXPLODED IN ANGER."
     bAlwaysGibs=True
     bLocationalHit=False
     bAlwaysSevers=True
     GibModifier=4.000000
     PawnDamageEmitter=Class'BWBPArchivePackPro2.IE_HVPCGeneral'
     PawnDamageSounds(0)=Sound'WeaponSounds.ShockRifle.ShockComboFire'
     GibPerterbation=5.000000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.200000
     VehicleMomentumScaling=1.300000
}
