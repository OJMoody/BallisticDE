//=============================================================================
// LAWGrenade.
//
// Damage Over Time missile fired by LAW.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class F2000Grenade extends BallisticGrenade;

var Actor StuckActor;
var bool bPlaced;

simulated event ProcessTouch(Actor Other, vector HitLocation )
{
	if (Other == Instigator && (!bCanHitOwner))
		return;
	if (Base != None)
		return;

	if(Pawn(Other) != None)
	{
		StuckActor = Other;
		HitActor = Other;
		Explode(HitLocation, Normal(HitLocation-Other.Location));
		class'BallisticDamageType'.static.GenericHurt(Other, ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
	}
	else
		Super.ProcessTouch(Other,HitLocation);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	if(Pawn(Wall) != None)
		StuckActor = Wall;
	Explode(Location, HitNormal);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local Actor 	LastTrace;
	local Vector	Start, End, LastHitLoc, LastHitNorm;
	local Rotator R;
	local Projectile Proj;
	local float BoneDist;

	if(bPlaced)
		return;

	bPlaced = true;
    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController());
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	if(Role != ROLE_Authority)
	{
		Destroy();
		Return;
	}

	// Check for wall
	if(StuckActor == None)
	{
		Start = HitLocation - (Normal(Velocity) *16.0);
		End = Start + (Normal(Velocity) * 128);
		LastTrace = Trace(LastHitLoc, LastHitNorm, End, Start, false);
		if (LastTrace == None || (!LastTrace.bWorldGeometry && Mover(LastTrace) == None))
			return;

		if (LastTrace == None)
			return;

		LastHitLoc += (5.0 * LastHitNorm);
		LastHitNorm = -LastHitNorm;
	}
	else
	{
		R = Rotation;
		LastHitLoc = Location;
		LastHitNorm = Normal(Velocity);
	}
	R = Rotator(LastHitNorm);
	R.Roll = Rand(65536);
	if(StuckActor == None)
	{
		Proj = Spawn (class'F2000Mine',,, LastHitLoc, R);
		Proj.Instigator = Instigator;
		Proj.bHardAttach = true;
		Proj.SetBase(LastTrace);
	}
	else
	{
		Proj = Spawn (class'F2000Mine',,, LastHitLoc, R);
		Proj.Instigator = Instigator;
		Proj.SetPhysics(PHYS_None);
		Proj.bHardAttach = true;
		if (StuckActor != Instigator && StuckActor.DrawType == DT_Mesh)
			StuckActor.AttachToBone(Proj, StuckActor.GetClosestBone(LastHitLoc, Velocity, BoneDist));
		else
			Proj.SetBase(StuckActor);
	}
	Proj.SetRotation(R);
	Proj.Velocity = vect(0,0,0);

	Destroy();
}

defaultproperties
{
     DetonateOn=DT_Impact
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=0.000000
     ImpactDamage=20
     ImpactDamageType=Class'BWBPArchivePackDE.DT_MARSMineDet'
     ImpactManager=Class'BallisticDE.IM_M46GrenadeImpact'
     TrailClass=Class'BallisticDE.M50GrenadeTrail'
     TrailOffset=(X=-8.000000)
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     Speed=1800.000000
     MyDamageType=None
     StaticMesh=StaticMesh'BallisticRecolors4StaticA.MARS.MARS3Grenade'
     DrawScale=0.500000
}
