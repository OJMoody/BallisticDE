class PROJ_IFBMain extends DKProjectile;

var() Sound FlySound;
var() float ShellTime;
var FX_Tracer_IFB Tracer;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	if ( Level.NetMode != NM_DedicatedServer)
	{
          Tracer = Spawn(class'FX_Tracer_IFB',self,,Location); 
	}

	super.PostBeginPlay();
	SetTimer(0.15, false);
	if (FastTrace(Location + vector(rotation) * 0, Location))
		PlaySound(FlySound, SLOT_Interact, 1.0, , 512, , false);
}

simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, None);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
    PlaySound(Sound'A3.v130dama',SLOT_None,TransientSoundVolume*0.6,,TransientSoundRadius);

	Explode(Location, HitNormal);
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner || ( vehicle(Instigator)!=None&&Other==Vehicle(Instigator).Driver ) )))
		return;

	if (Role == ROLE_Authority)
		DoDamage(Other, HitLocation);

	HitActor = Other;
	Explode(HitLocation, vect(0,0,1));
}

simulated function Destroyed()
{
        Tracer.Destroy();
        Trail.Destroy();

	Super.Destroyed();
}

defaultproperties
{
     FlySound=Sound'BWBP4-Sounds.Artillery.Art-FlyBy'
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo200FG'
     SplashManager=Class'UberSoldierVehicles.IM_DK_ProjWater'
     ShakeRadius=2000.000000
     MotionBlurRadius=2000.000000
     MotionBlurFactor=15.000000
     ShakeRotMag=(X=512.000000,Y=400.000000,Z=350.000000)
     ShakeRotRate=(X=7000.000000,Y=7000.000000,Z=5500.000000)
     ShakeRotTime=8.000000
     ShakeOffsetMag=(X=30.000000,Y=30.000000,Z=30.000000)
     ShakeOffsetRate=(X=600.000000,Y=600.000000,Z=600.000000)
     ShakeOffsetTime=10.000000
     Speed=8000.000000
     MaxSpeed=8000.000000
     Damage=1000.000000
     DamageRadius=1000.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FearFG'
     StaticMesh=StaticMesh'DKVehiclesMesh.RocketShell'
     DrawScale=0.500000
     SoundRadius=128.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=10000.000000
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
