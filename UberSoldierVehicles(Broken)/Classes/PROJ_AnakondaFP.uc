class PROJ_AnakondaFP extends DKProjectile;

var FX_FireEffect_Anakonda Fire;
var FX_Tracer_AnakondaAP Tracer;

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
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner || ( vehicle(Instigator)!=None&&Other==Vehicle(Instigator).Driver ) )))
		return;

	if (Role == ROLE_Authority)
		DoDamage(Other, HitLocation);

	HitActor = Other;
	Explode(HitLocation, vect(0,0,1));
}

simulated event HitWall(vector HitNormal, actor Wall)
{
        Spawn(class'PROJ_AnakondaFP_PS',self,,Location); 

	Explode(Location, HitNormal);
}

simulated function Destroyed()
{
        Spawn(class'PROJ_AnakondaFP_Exp',self,,Location); 

        Tracer.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo22FP'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     Speed=60000.000000
     MaxSpeed=60000.000000
     Damage=122.000000
     DamageRadius=222.000000
     MomentumTransfer=6000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FG'
     LifeSpan=2.000000
}
