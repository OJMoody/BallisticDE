//=============================================================================
// G5SeekerRocket.
//
// A G5 rocket that can be guided to a given point
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HydraSeekerRocket extends HydraRocket;

var   vector	LastLoc;	// Place where target was last seen
var() float		TurnRate;			// Rate of rotation towards target. Rotator units per seconds.
var() bool		bSeeking;			// Seeking mode on. Trying to get to our target point
var   bool		bHasImpacted;		// Hit a wall. Stop seeking, because rocket has either exploded or ricocheted
var() float		LastSendTargetTime; // Time when a target location has been set, used for difference formula

var() HydraBazooka  Weapon;

replication
{
	reliable if (Role == ROLE_Authority)
		LastLoc, bSeeking, SetTargetLocation;	
}

function HitWall(vector HitNormal, actor Wall)
{
	bHasImpacted=True;
	bSeeking=False;

	super.HitWall(HitNormal, Wall);
}

function SetTargetLocation()
{
	if (bHasImpacted)
		return;

	if (Role == ROLE_Authority && Weapon.bLaserOn)
		LastLoc = Weapon.GetRocketDir();

	bSeeking=True;
}

simulated function Tick(float DT)
{	
	local Vector V, X,Y,Z;
	local Rotator R, AxisDir;
	local float TurnNeeded;

	if (Role == ROLE_Authority && level.TimeSeconds - LastSendTargetTime > 0.02)
	{
		LastSendTargetTime = level.TimeSeconds;
		SetTargetLocation();
	}

	if (bExploded)
		Destroy();

	// Guide the projectile
	if (bSeeking)
	{
		V = LastLoc - Location;

		// Align velocity towards target, but limit how fast rocket can turn. Use a tricky units per second rate limit.
		X = Normal(Velocity);
		Y = Normal(V cross Velocity);
		Z = Normal(X cross Y);
		AxisDir = OrthoRotation(X,Y,Z);

		TurnNeeded = acos(Normal(V) Dot Normal(Velocity)) * (32768 / Pi);

		R.Pitch = FMin( TurnRate*DT, TurnNeeded );
		GetAxes(R,X,Y,Z);
		X = X >> AxisDir;
		Y = Y >> AxisDir;
		Z = Z >> AxisDir;
        R = OrthoRotation(X,Y,Z);
		Velocity = Normal(Vector(R)) * Speed;

		if (Normal(Velocity) Dot Normal (V) > 0.6 && VSize(V) < Speed * 0.1)
			bSeeking = false;
	}
	R = Rotation;
	R = Rotator(Velocity);
	R.Roll = Rotation.Roll;
	SetRotation(R);
}

defaultproperties
{
    TurnRate=24576.000000
    LifeSpan=0.000000
	bTearOff=False
	MyDamageType=Class'BWBP_APC_Pro.DTHydraBazookaSeeker'
	bNetTemporary=False
	bUpdateSimulatedPosition=True
}
