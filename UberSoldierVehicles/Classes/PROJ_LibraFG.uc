class PROJ_LibraFG extends DKProjectile;

var vector Dir;

var FX_FireEffect_Libra Fire;
var FX_Tracer_Libra Tracer;
var PROJ_IspolinFG_PS PS;


simulated function PostBeginPlay()
{
          Fire = Spawn(class'FX_FireEffect_Libra',self,,Location); 
          Tracer = Spawn(class'FX_Tracer_Libra',self,,Location); 

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
        PS = Spawn(class'PROJ_IspolinFG_PS',self,,Location); 

	Explode(Location, HitNormal);
}

simulated function Destroyed()
{
        Tracer.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     FireSound=Sound'A.LibraFire'
     FireSoundVolume=255.000000
     FireSoundRadius=1500.000000
     ImpactManager=Class'UberSoldierVehicles.IM_LibraFG'
     SplashManager=Class'UberSoldierVehicles.IM_DK_ProjWater'
     ShakeRadius=750.000000
     MotionBlurRadius=750.000000
     MotionBlurFactor=10.000000
     Speed=20000.000000
     MaxSpeed=20000.000000
     Damage=750.000000
     DamageRadius=750.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FG'
}
