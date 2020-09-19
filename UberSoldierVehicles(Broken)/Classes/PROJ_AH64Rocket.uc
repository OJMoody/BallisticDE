class PROJ_AH64Rocket extends DKProjectile;

//var   float		FuelOutTime;
var	vector		StrafeVelocity;
var	float		StrafeEndTime;
var     bool		bSideWinder;
var     int		RollRange;
var     float		ScrewRadius;
var     bool		bCrazy;
var()	float		DudChance;
var()	float		SideWinderChance;
var()	float		MaxStrafeSpeed;

var() int		ImpactDamage;
var() Class<DamageType>	ImpactDamageType;

var FX_FireEffect_MI48 Fire;
var FX_Tracer_MI48NG Tracer;

delegate OnDie(Actor Cam);

simulated event PostNetBeginPlay()
{
	local vector X,Y,Z;
	super.PostNetBeginPlay();

	GetAxes(Rotation, X,Y,Z);
//	StrafeVelocity = Y * (Rand(200)-100);
	StrafeVelocity = Y * (FRand()*2-1)*MaxStrafeSpeed;
	Velocity += StrafeVelocity;
	StrafeEndTime = level.TimeSeconds + FRand()*0.5;
	if (bCrazy)
		Velocity += vect(0,0,300);
}

simulated function PostBeginPlay()
{
	local Rotator R;

          Fire = Spawn(class'FX_FireEffect_MI48',self,,Location); 
          Tracer = Spawn(class'FX_Tracer_MI48NG',self,,Location);

	if (DudChance > FRand())
//	if (FRand() > 0.95)
	{
		bCrazy = true;

		AccelSpeed = 6000 + Rand(2000);
		Speed += Rand(1000);
		MaxSpeed = 4000 + Rand(2000);

//		SetPhysics(PHYS_Falling);

//		RotationRate.Pitch = -256000 + Rand(512000);
//		RotationRate.Yaw = -256000 + Rand(512000);
//		RotationRate.Roll = 128000;

		RotationRate.Pitch = RollRange*(FRand()*2-1.0);
		RotationRate.Yaw = RollRange*(FRand()*2-1.0);
		RotationRate.Roll = RollRange*(FRand()*2-1.0);

		R.Yaw   = -4000 + Rand(8000);
		R.Pitch = -4000 + Rand(8000);
		SetRotation(R+Rotation);

		bSideWinder = true;
		ScrewRadius = ScrewRadius*4 + Rand(ScrewRadius*24);
	}
	else
	{
		RotationRate.Roll = RollRange*(FRand()*2-1.0);
//		if (FRand() > 0.3)
		if (SideWinderChance >= FRand())
		{
			bSideWinder = true;
			ScrewRadius += Rand(ScrewRadius*3);
		}
		AccelSpeed += Rand(1000);
		Speed += Rand(500);
		MaxSpeed += Rand(1000);
	}
	SetTimer(1.0 + FRand()*2.0, false); 

	Super.PostBeginPlay();
}

simulated event Tick(float DT)
{
	local vector X,Y,Z, ScrewCenter;
	local Rotator R;

	if (bCrazy)
	{
		Acceleration = vsize(Acceleration) * vector(Rotation);
//		Velocity = vsize(velocity) * vector(rotation);
	}
	if (bSideWinder)
	{
		R = Rotation;
		R.Roll -= RotationRate.Roll * DT;
		GetAxes(R, X, Y, Z);
		ScrewCenter = Location + Y * ScrewRadius;

		GetAxes(Rotation, X, Y, Z);
		SetLocation(ScrewCenter - Y * ScrewRadius);
	}
	else if (StrafeEndTime != 0 && level.TimeSeconds >= StrafeEndTime)
	{
		StrafeEndTime = 0;
		Velocity -=	StrafeVelocity;

		AccelSpeed += 3000;
    	Acceleration = Vector(Rotation) * AccelSpeed;

//    	Speed += 1000;
  //  	Velocity += Vector(Rotation) * Speed;
	}
}

simulated event Timer()
{
	SetPhysics(PHYS_Falling);
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, Level );
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
    local Vector X;

	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;

	if (Role == ROLE_Authority)		// Do damage for direct hits
	{
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
		DoDamage(Other, HitLocation);
	}
	if (CanPenetrate(Other) && Other != HitActor)
	{	// Projectile can go right through enemies
		HitActor = Other;
		X = Normal(Velocity);
		SetLocation(HitLocation + (X * (Other.CollisionHeight*2*X.Z + Other.CollisionRadius*2*(1-X.Z)) * 1.2));
	    if ( EffectIsRelevant(Location,false) && PenetrateManager != None)
			PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, Other.SurfaceType, Owner, 4/*HF_NoDecals*/);
	}
	else
	{	// Spawn projectile death effects and try radius damage
		HitActor = Other;
		Explode(HitLocation, vect(0,0,1));
	}
}

simulated function Destroyed()
{
        Tracer.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     RollRange=100000
     ScrewRadius=8.000000
     SideWinderChance=5.000000
     MaxStrafeSpeed=2.000000
     ImpactManager=Class'UberSoldierVehicles.IM_Rocket28FG'
     AccelSpeed=2000.000000
     TrailClass=Class'UberSoldierVehicles.FX_RoketTrailSmall'
     TrailOffset=(X=-10.000000)
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=128.000000
     MotionBlurRadius=128.000000
     MotionBlurFactor=10.000000
     Speed=6000.000000
     MaxSpeed=6000.000000
     Damage=128.000000
     DamageRadius=168.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FG'
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
