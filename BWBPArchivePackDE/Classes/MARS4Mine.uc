//=============================================================================
// MARS4Mine.
//
// A 40mm grenade that attaches to walls and stuff
//
// Will emit 3 damaging pulses that ignore walls. If shot or past 3 pulses,
// it will blow up. Detonation strength does NOT decay with each pulse.
//
//
// by MARC MARC SERGEANT KELLY
// Coding help by Azarael
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class MARS4Mine extends BallisticProjectile;

var   bool				bDetonated;		// Been detonated, waiting for net syncronization or something
var   bool				bDetonating;		// Been detonated, waiting for net syncronization or something
var() Sound				DetonateSound;
var     int				ShockRadius;

var() class<damageType>			MyShotDamageType;	// Damagetype to use when detonated by damage
var() class<BCImpactManager>		ImpactManager2;		// Impact manager to spawn on final hit


var   int				Health;			// Distance from his glorious holiness, the source. Wait, thats not what this is...
var   LAWSparkEmitter			TeamLight;		// A flare emitter to show the glowing core
var   float				TriggerStartTime;	// Time when trigger will be active
var   int				PulseNum;		// HOW MANY PULSES. WHAT DO THE NUMBERS MEAN?
var bool				bShot;			// you shot it
var bool				bPulse;
var bool				bOldPulse;

replication
{
	reliable if(Role == ROLE_Authority)
		bShot, bDetonated, bDetonating, bPulse;
}

simulated event PostNetReceive()
{
	Super.PostNetReceive();
	if (bShot || bDetonated)
		Explode(Location, vector(Rotation));
	if (bPulse != bOldPulse)
	{
		bOldPulse = bPulse;
		ShockwaveExplode(Location, vector(Rotation));
	}
}


simulated function InitProjectile()
{
	super.InitProjectile();

	if (Role==ROLE_Authority)
	{
		bDetonating = true;
		PlaySound(DetonateSound,,2.0,,256,,);
		SetTimer(0.75, false);
	}
	if (level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		TeamLight = Spawn(class'LAWSparkEmitter',self,,Location, Rotation);
		TeamLight.SetBase(self);
	}
}

simulated function Destroyed()
{

	if (TeamLight != None)
		TeamLight.Destroy();
	super.Destroyed();
}


simulated function Timer()
{
	if (StartDelay > 0)
	{
		super.Timer();
		return;
	}

	if (Role < ROLE_Authority)
		return;

	if (PulseNum < 3 && !bShot)
	{
		if (level.Netmode == NM_Standalone) //Standalone games just call the effect
		{
			ShockwaveExplode(Location, vector(Rotation));
		}
		else
		{
			Shockwave(Location);
			bPulse = !bPulse;
		}
	}
	else
	{
		//removed tearoff - use bTearOnExplode if you need it to tear off, but you shouldn't have to do that
		bDetonated = true;
		Explode(Location, vector(Rotation));
	}
}

simulated function ProcessTouch (Actor Other, vector HitLocation);
simulated singular function HitWall(vector HitNormal, actor Wall);

// Got hit, explode with a tiny delay
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bDetonatesBombs)
		return;
	if (class<DT_MARSPulse>(DamageType) != None)
		return;
	if (StartDelay > 0)
		return;
	if (bShot)
		return;
	Health-=Damage;
	if (Health > 0)
		return;
	bShot = true; //Here this applies only to damaged rockets

	SetTimer(0.1, false);
}


// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;

	if(DamageRadius > 0)
	{
		if (bShot) //it's been shot, play custom death messages
			TargetedHurtRadius(Damage, DamageRadius, MyShotDamageType, MomentumTransfer, HitLocation);
		else //it ran out of power on its own
			TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation);
	}

	MakeNoise(1.0);
}

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	if (bExploded)
		return;
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
    	if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (bCheckHitSurface)
			CheckSurface(HitLocation, HitNormal, Surf);
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
	}
	BlowUp(HitLocation);
	bExploded=true;

//	if (bTearOnExplode && (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer))
//		bTearOff = true;
	if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
		GotoState('NetTrapped');
	else
		Destroy();
}

// Do shockwave effects and run Shockwave.
simulated function ShockwaveExplode(vector HitLocation, vector HitNormal)
{
	local int Surf;

	if (bExploded)
		return;

	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);

    	if (ImpactManager2 != None && level.NetMode != NM_DedicatedServer)
	{
		if (bCheckHitSurface)
			CheckSurface(HitLocation, HitNormal, Surf);
		if (Instigator == None)
			ImpactManager2.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager2.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
	}
	Shockwave(HitLocation);

}

// Do shockwave damage
function Shockwave(vector HitLocation)
{

	local Actor A;
	
	if (Role < ROLE_Authority)
		return;
	foreach RadiusActors( class 'Actor', A, ShockRadius, Location )
	{

		if (A.bCanBeDamaged)
		{
			class'BallisticDamageType'.static.Hurt(A, 15.0, Instigator, A.Location, Normal(A.Location - Location)*500, class'DT_MARSPulse');
		}

	}
	PulseNum++;
	SetTimer(1.5, false);

}

function bool IsStationary()
{
	return true;
}

defaultproperties
{
     DetonateSound=Sound'BWBP_SKC_Sounds.MARS.MARS-MineAlarm'
     ShockRadius=768
     MyShotDamageType=Class'BWBPArchivePackDE.DT_MARSMineShot'
     ImpactManager2=Class'BWBPArchivePackDE.IM_MARS4Wave'
     Health=40
     ImpactManager=Class'BallisticDE.IM_Grenade'
     StartDelay=0.300000
     MyRadiusDamageType=Class'BWBPArchivePackDE.DT_MARSMineDet'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=1000.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=1.500000
     MotionBlurTime=3.000000
     Damage=60.000000
     DamageRadius=256.000000
     MyDamageType=Class'BWBPArchivePackDE.DT_MARSMineDet'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MARS.MARS3Grenade'
     CullDistance=2500.000000
     bNetTemporary=False
     Physics=PHYS_None
     LifeSpan=0.000000
     DrawScale=0.500000
     bUnlit=False
     CollisionRadius=16.000000
     CollisionHeight=16.000000
     bCollideWorld=False
     bProjTarget=True
     bNetNotify=True
}
