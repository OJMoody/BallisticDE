class PROJ_M1MG extends DKProjectile;

var vector Dir;
var FX_FireEffect_Cheetah Fire;
var FX_FireEffect_M1TraceMG Tracer;

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
          Fire = Spawn(class'FX_FireEffect_Cheetah',self,,Location); 
          Tracer = Spawn(class'FX_FireEffect_M1TraceMG',self,,Location); 
	}

	Super.PostBeginPlay();
}

function BlowUp(vector HitLocation)
{
	HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	MakeNoise(1.0);
}

simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, None);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	Explode(Location, HitNormal);
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner || ( vehicle(Instigator)!=None&&Other==Vehicle(Instigator).Driver ) )))
		return;

	if (Role == ROLE_Authority)		// Do damage for direct hits
		DoDamage(Other, HitLocation);

	// Spawn projectile death effects and try radius damage
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
     SpawnSoundVolume=2.000000
     SpawnSoundRadius=700.000000
     ImpactManager=Class'UberSoldierVehicles.IM_MG'
     SplashManager=Class'UberSoldierVehicles.IM_DK_ProjWaterMg'
     Speed=35000.000000
     MaxSpeed=35000.000000
     Damage=30.000000
     DamageRadius=10.000000
     MomentumTransfer=1000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_MG'
     SpawnSound=Sound'DKoppIISound.Fire.12mm1'
}
