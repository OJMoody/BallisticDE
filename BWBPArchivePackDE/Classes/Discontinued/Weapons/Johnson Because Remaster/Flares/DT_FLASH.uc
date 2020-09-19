//=============================================================================
// FLASH.
//
// DamageType for the M202/FLASH-1 FLASH
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FLASH extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o rode %k's napalm rocket straight to hell."
     DeathStrings(1)="%o jumped in front of %k's STREAK rocket."
     DeathStrings(2)="%k lobbed an incendiary rocket onto %o's head."
     DeathStrings(3)="%k's screaming STREAK rocket blasted %o."
     DeathStrings(4)="%o took %k's rocket like a man and exploded in a fireball."
     WeaponClass=Class'BWBPArchivePackDE.SK410Shotgun'
     DeathString="%o took %k's incendiary rocket in the face."
     FemaleSuicide="%o skillfully shot her rocket up and caught it on the way down. Woo!"
     MaleSuicide="%o skillfully shot his rocket up and caught it on the way down. Congrats."
     bDelayedDamage=True
     VehicleDamageScaling=1.200000
}
