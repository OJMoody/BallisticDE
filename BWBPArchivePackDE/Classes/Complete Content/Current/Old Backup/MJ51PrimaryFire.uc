//=============================================================================
// MJ51PrimaryFire.
//
// 3-Round burst. Shots are powerful and easy to follow up.
// Not very accurate at range, and hindered by burst fire up close.
// Excels at mid range combat.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MJ51PrimaryFire extends BallisticProInstantFire;

simulated event ModeDoFire()
{
	if (MJ51Carbine(Weapon).bLoaded)
	{
		MJ51Carbine(Weapon).IndirectLaunch();
		return;
	}
	if (!AllowFire())
		return;
		
	super.ModeDoFire();
    

}

defaultproperties
{
	 TraceRange=(Min=10000.000000,Max=13000.000000)
     WaterRangeFactor=0.800000
     Damage=25
     DamageHead=50
     DamageLimb=21
     RangeAtten=0.900000
     WaterRangeAtten=0.700000
     DamageType=Class'BWBPArchivePackDE.DTMJ51Assault'
     DamageTypeHead=Class'BWBPArchivePackDE.DTMJ51AssaultHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTMJ51AssaultLimb'
     KickForce=18000
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     MuzzleFlashClass=Class'BWBPArchivePackDE.MJ51FlashEmitter'
	 FlashScaleFactor=0.7
     BrassClass=Class'BallisticDE.Brass_Rifle'
     BrassOffset=(X=-20.000000,Y=1.000000)
     RecoilPerShot=128.000000
     XInaccuracy=48.000000
     YInaccuracy=48.000000
	 FireChaos=0.100000
     BallisticFireSound=(Sound=Sound'BWWeaponPack2-Sounds.CommandoFire')
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.1000
     AmmoClass=Class'BWBPRecolorsDE.Ammo_556mmSTANAG'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
}
