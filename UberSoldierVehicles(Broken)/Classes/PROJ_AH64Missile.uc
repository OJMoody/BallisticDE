class PROJ_AH64Missile extends DKProjectile;

var FX_FireEffect_MI48 Fire;
var FX_Tracer_AH64Missile Tracer;

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
          Fire = Spawn(class'FX_FireEffect_MI48',self,,Location); 
          Tracer = Spawn(class'FX_Tracer_AH64Missile',self,,Location);
	}

	Super.PostBeginPlay();
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
	Super.Destroyed();
}

defaultproperties
{
     ImpactManager=Class'UberSoldierVehicles.IM_Rocket288FG'
     TrailClass=Class'UberSoldierVehicles.FX_RoketTrailMed'
     TrailOffset=(X=-10.000000)
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=250.000000
     MotionBlurRadius=250.000000
     MotionBlurFactor=10.000000
     Speed=8000.000000
     MaxSpeed=8000.000000
     Damage=800.000000
     DamageRadius=350.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FG'
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
