//=============================================================================
// A42PrimaryFire.
//
// Rapid fire projectiles. Ammo regen timer is also here.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A85PrimaryFire extends BallisticProProjectileFire;

simulated event ModeDoFire()
{
	if (Weapon.GetFireMode(1).IsFiring())
		return;
	FireAnim = 'Fire';

	super.ModeDoFire();
}

defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
     MuzzleFlashClass=Class'BWBPArchivePackDE.A85FlashEmitter'
     RecoilPerShot=80.000000
     XInaccuracy=30.000000
     YInaccuracy=24.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.A42.A42-Fire',Volume=1.000000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     TweenTime=0.000000
     FireRate=0.252000
     AmmoClass=Class'BallisticDE.Ammo_A42Charge'
     AmmoPerFire=4
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBPArchivePackDE.A85Projectile'
     WarnTargetPct=0.300000
}
