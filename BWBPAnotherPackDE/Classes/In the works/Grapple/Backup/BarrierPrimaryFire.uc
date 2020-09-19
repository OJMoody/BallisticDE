//=============================================================================
// AK47PrimaryFire.
//
// High powered automatic fire. Hits like the SRS but has less accuracy.
// Good for close and mid range, bad at long range.
// Has better than average penetration.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BarrierPrimaryFire extends BallisticProjectileFire;

defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
     MuzzleFlashClass=Class'BallisticDE.A42FlashEmitter'
     RecoilPerShot=64.000000
     FireChaos=0.130000
	 FlashBone="Tip"
	 FlashScaleFactor=0.3
     BallisticFireSound=(Sound=Sound'BallisticSounds3.A42.A42-Fire',Volume=0.700000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.700000
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_KineticCharge'
     AmmoPerFire=15
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBPAnotherPackDE.BarrierPriProjectile'
     WarnTargetPct=0.300000
}
