class PROJ_AbramsMK2APR extends DKProjectile;

var vector Dir;

var FX_Tracer_IspolinAP Tracer;

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
          Tracer = Spawn(class'FX_Tracer_IspolinAP',self,,Location); 
        }

	Super.PostBeginPlay();
}

simulated function BlowUp(vector HitLocation)
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
	if ( Level.NetMode != NM_DedicatedServer)
	{
        Spawn(class'PROJ_AbramsMK2APR_PS',self,,Location);
        Spawn(class'FX_AP_MediumRic',self,,Location);  
        }

	Explode(Location, HitNormal);
}

simulated event PhysicsVolumeChange(PhysicsVolume NewVolume)
{
	If (NewVolume.bWaterVolume)
	{
   	         Destroy();
	}
}

simulated function Destroyed()
{
        Tracer.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo85AP'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=94.000000
     MotionBlurRadius=94.000000
     MotionBlurFactor=10.000000
     Speed=10000.000000
     MaxSpeed=10000.000000
     Damage=425.000000
     DamageRadius=108.500000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_AP'
     Physics=PHYS_Falling
     bIgnoreTerminalVelocity=True
     bOrientToVelocity=True
}
