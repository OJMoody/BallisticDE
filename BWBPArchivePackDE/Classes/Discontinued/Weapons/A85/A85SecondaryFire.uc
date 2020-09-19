//=============================================================================
// A42SecondaryFire.
//
// Instant beam that varies in power depending on holdtime.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A85SecondaryFire extends BallisticProProjectileFire;


var int	ProjectileCount;


simulated event ModeDoFire()
{
	if (Weapon.GetFireMode(0).IsFiring())
		return;

	FireAnim = 'Fire2';

	super.ModeDoFire();
}

function DoFireEffect()
{
    local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
    local Rotator Aim;
	local actor Other;
	local int i;

    Weapon.GetViewAxes(X,Y,Z);
    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();
//	StartTrace = Start + X*SpawnOffset.X;
//	if (!Weapon.WeaponCentered())
//		StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y + Z*SpawnOffset.Z;

    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    if(!Weapon.WeaponCentered())
	    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

	for(i=0; i < ProjectileCount; i++)
	{
		Aim = GetFireAim(StartTrace);
		Aim = Rotator(GetFireSpread() >> Aim);

		End = Start + (Vector(Aim)*MaxRange());
		Other = Trace (HitLocation, HitNormal, End, Start, true);

		if (Other != None)
			Aim = Rotator(HitLocation-StartTrace);
		SpawnProjectile(StartTrace, Aim);
	}

	SendFireEffect(none, vect(0,0,0), StartTrace, 0);
	//Super.DoFireEffect();
}

/*

     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
*/

defaultproperties
{
     ProjectileCount=3
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
     MuzzleFlashClass=Class'BWBPArchivePackDE.A85FlashEmitter'
     RecoilPerShot=300.000000
     XInaccuracy=900.000000
     YInaccuracy=600.000000
     FireSpreadMode=FSM_Circle
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.A49.A49-ShockWave',Volume=2.000000)
     FireEndAnim=
     TweenTime=0.000000
     FireRate=0.780000
     AmmoClass=Class'BallisticDE.Ammo_A42Charge'
     AmmoPerFire=20
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBPArchivePackDE.A85Projectile'
     WarnTargetPct=0.300000
}
