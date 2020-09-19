//=============================================================================
// FP9PrimaryFire.
//
// Go close to wall to deploy bomb otherwise it is thrown. Hold fire to improve
// throw range.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP9PrimaryFireClassic extends BallisticProjectileFire;

event ModeDoFire()
{
	local Vector Start, HitLoc, HitNorm;

    if (!AllowFire())
        return;

	Start = Instigator.Location + Instigator.EyePosition();
	if (Trace(HitLoc,HitNorm,Start + vector(Instigator.GetViewRotation()) * 120, Start, true) == None)
    {
		BallisticFireSound.Sound = Sound'BallisticSounds2.FP9A5.FP9-Throw';
    	FireAnim = 'Throw';
    }
    else
    {
		BallisticFireSound.Sound = None;
    	FireAnim = 'Place';
    }
 	if (Weapon.AmmoAmount(0) > 0)
		Weapon.SetBoneScale (0, 1.0, FP9ExplosiveClassic(Weapon).BombBone);
	if (!FP9Explosive(Weapon).bHasDetonator)
	{
		Weapon.SetBoneScale (1, 0.0, FP9ExplosiveClassic(Weapon).DetHandBone);
		Weapon.SetBoneScale (2, 0.0, 'FP9Detonator');
	}

    super.ModeDoFire();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	local Actor T;
	local Vector TraceStart, End, HitLoc, HitNorm;

	// Check for wall
	TraceStart = Instigator.Location + Instigator.EyePosition();
	End = TraceStart + vector(Instigator.GetViewRotation()) * 120;
	T = Trace(HitLoc, HitNorm, End, TraceStart, true);
	if (T != None && (T.bWorldGeometry || Mover(T) != None || Vehicle(T) != None))
	{
		if (T.DrawType == DT_StaticMesh)
			HitLoc -= HitNorm*3;
		Proj = Spawn (ProjectileClass,,, HitLoc+HitNorm*2, Rotator(HitNorm));
		FP9BombClassic(Proj).InitBomb(false, FP9ExplosiveClassic(Weapon).bLaserMode, HoldTime);
		Proj.bHardAttach = true;
		Proj.SetBase(T);
	}
	else
	{
		Proj = Spawn (ProjectileClass,,, Start, Dir);
	 	if (AIController(Instigator.Controller) != None)
			FP9BombClassic(Proj).InitBomb(true, FP9ExplosiveClassic(Weapon).bLaserMode, 1.0);
		else
			FP9BombClassic(Proj).InitBomb(true, FP9ExplosiveClassic(Weapon).bLaserMode, HoldTime);
	}
	if (Proj != None)
	{
		Proj.Instigator = Instigator;
		FP9ExplosiveClassic(Weapon).AddBomb(FP9BombClassic(Proj));
		bIsFiring = false;
	}
}

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=-10.000000,Z=-5.000000)
     bUseWeaponMag=False
     BallisticFireSound=(Sound=Sound'BallisticSounds2.FP9A5.FP9-Throw')
     bAISilent=True
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bFireOnRelease=True
     bModeExclusive=False
     PreFireAnim="PrepThrow"
     FireAnim="Throw"
     TweenTime=0.200000
     FireForce="AssaultRifleAltFire"
     FireRate=1.500000
     AmmoClass=Class'BallisticDE.Ammo_FP9Ammo'
     ProjectileClass=Class'BWBPArchivePackDE.FP9BombClassic'
     BotRefireRate=0.300000
	 WarnTargetPct=0.9
}
