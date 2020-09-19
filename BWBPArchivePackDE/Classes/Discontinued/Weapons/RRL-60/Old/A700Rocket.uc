//=============================================================================
// G5Rocket.
//
// Rocket projectile for the G5 RPG.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A700Rocket extends BallisticProjectile;


var   bool				bDetonate;		// Flaged for detonation next tick. Sent to net clients when detonated on server
var   bool				bDetonating;

replication
{
	reliable if (Role == ROLE_Authority)
		bDetonate, bDetonating;
}

simulated event PostNetReceive()
{
	if(bDetonate)
		SetTimer(0.1, false);
	else if(bDetonating)
	{
		//PlaySound(DetonateSound,,2.0,,256,,);
		SetTimer(1.0, false);
	}
}

//delegate OnDie(Actor Cam);//was uncommented

/*simulated function Explode(vector HitLocation, vector HitNormal)
{
	//OnDie(self);//was uncommented
	log("Exploding");
	Super.Explode(HitLocation, HitNormal);
}*/


// Call this to make it go BOOM...
simulated function Detonate()
{
	bDetonate = true;
	SetTimer(0.01+0.1*FRand(), false);
}


simulated event Timer()
{
	//local Rotator R;

	// Was damaged or detonated, now it can blow
	if (bDetonate)
		Explode(Location, vect(0,0,1));
	// Init after Delay
	else if (StartDelay > 0)
	{
		StartDelay = 0;
		bHidden=false;
		InitProjectile();
		return;
	}

}

// When start delay ends, set all the properties that make it visible
/*simulated function TimerOLD()
{
	if (StartDelay > 0)
	{
		StartDelay = 0;
		SetPhysics(default.Physics);
		bDynamicLight=default.bDynamicLight;
		bHidden=false;
		//InitProjectile();
		return;
	}
}*/

simulated function Tick(float DT)
{

	super(BallisticProjectile).Tick(DT);


	// It's time to blow
	if (bDetonate )//&& Level.NetMode == NM_Client)
	{
		log("Time to blow up");
		Explode(Location, vect(0,0,1));
	}

}


simulated function AddRocket()
{
	log("A700Rocket - AddRocket");
	A700SkrithRocketLauncher(Instigator.Weapon).SetCurrentRocket(Self);
}

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	bDynamicLight=default.bDynamicLight;
	/*if (A700SkrithRocketLauncher(Instigator.Weapon).CurrentRocket != Self)
	{
		log("InitEffects: Current rocket is not self; adding");
		AddRocket();
	}*/
	//log("InitEffects: A700 is: "$A700SkrithRocketLauncher(Instigator.Weapon));
	if (Level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(Rotation,X,Y,Z);
		Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		if (Emitter(Trail) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
		if (Trail != None)
			Trail.SetBase (self);
	}
}



// Initialize projectile stuff. This will be delayed by StartDelay
simulated function InitProjectile ()
{
	log("InitProjectile - should only see once");
	if (A700SkrithRocketLauncher(Instigator.Weapon).CurrentRocket != Self)
	{
		log("InitProjectile: Current rocket is not self; adding");
		AddRocket();
	}
	InitEffects();
}

// Do radius damage;
function BlowUp(vector HitLocation)
{
	//if (Role < ROLE_Authority)
	//	return;
	if(DamageRadius > 0)
		TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation);

	MakeNoise(1.0);
	Destroy();
}

defaultproperties
{
     ImpactManager=Class'BWBPArchivePackDE.IM_A700Rocket'
     bRandomStartRotaion=False
     AccelSpeed=1800.000000
     TrailClass=Class'BWBPArchivePackDE.A700RocketTrail'
     TrailOffset=(X=-14.000000)
     MyRadiusDamageType=Class'BWBPArchivePackDE.DTA700RocketRadius'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=1024.000000
     MotionBlurRadius=512.000000
     ShakeRotMag=(X=512.000000,Y=400.000000)
     ShakeRotRate=(X=3000.000000,Z=3000.000000)
     ShakeOffsetMag=(X=20.000000,Y=30.000000,Z=30.000000)
     Speed=1200.000000
     MaxSpeed=4200.000000
     Damage=100.000000
     DamageRadius=100.000000
     MomentumTransfer=90000.000000
     MyDamageType=Class'BWBPArchivePackDE.DTA700Rocket'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=145
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     StaticMesh=StaticMesh'BWSkrithRecolors2Static.SkrithRL.SkrithRocket'
     bDynamicLight=True
     AmbientSound=Sound'BallisticSounds2.G5.G5-RocketFly'
     DrawScale=0.500000
     SoundVolume=192
     SoundRadius=128.000000
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
