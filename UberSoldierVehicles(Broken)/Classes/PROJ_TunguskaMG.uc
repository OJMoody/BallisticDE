class PROJ_TunguskaMG extends DKProjectile;

var FX_FireEffect_AmazonMG Fire;

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
          Fire = Spawn(class'FX_FireEffect_AmazonMG',self,,Location); 
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
	Super.Destroyed();
}

defaultproperties
{
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo30AP'
     SplashManager=Class'UberSoldierVehicles.IM_DK_ProjWaterMg'
     Speed=30000.000000
     MaxSpeed=30000.000000
     Damage=30.000000
     DamageRadius=50.000000
     MomentumTransfer=1000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_MG'
     StaticMesh=StaticMesh'DKVehiclesMesh.TankShel'
     DrawScale=0.000000
}
