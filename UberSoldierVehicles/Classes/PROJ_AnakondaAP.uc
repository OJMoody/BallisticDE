class PROJ_AnakondaAP extends DKProjectile;

var FX_FireEffect_Anakonda Fire;
var FX_Tracer_AnakondaAP Tracer;
var PROJ_AnakondaAP_PS PS;

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
          Fire = Spawn(class'FX_FireEffect_Anakonda',self,,Location); 
          Tracer = Spawn(class'FX_Tracer_AnakondaAP',self,,Location); 
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
	if ( Level.NetMode != NM_DedicatedServer)
	{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner || ( vehicle(Instigator)!=None&&Other==Vehicle(Instigator).Driver ) )))
		return;

	if (Role == ROLE_Authority)		// Do damage for direct hits
		DoDamage(Other, HitLocation);

	// Spawn projectile death effects and try radius damage
	HitActor = Other;
        }

	Explode(HitLocation, vect(0,0,1));
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
        PS = Spawn(class'PROJ_AnakondaAP_PS',self,,Location); 
        }

	Explode(Location, HitNormal);
}

simulated function Destroyed()
{
        Tracer.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo30AP'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     Speed=60000.000000
     MaxSpeed=60000.000000
     Damage=122.000000
     DamageRadius=122.000000
     MomentumTransfer=6000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FG'
}
