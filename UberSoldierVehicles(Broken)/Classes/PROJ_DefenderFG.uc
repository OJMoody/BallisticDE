class PROJ_DefenderFG extends DKProjectile;

var vector Dir;

var FX_FireEffect_Defender Fire;
var FX_Tracer_DefenderFG Tracer;


simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
          Fire = Spawn(class'FX_FireEffect_Defender',self,,Location);
          Tracer = Spawn(class'FX_Tracer_DefenderFG',self,,Location); 
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
        Spawn(class'PROJ_DefenderFG_PS',self,,Location); 

	Explode(Location, HitNormal);
}

simulated event PhysicsVolumeChange(PhysicsVolume NewVolume)
{
	If (NewVolume.bWaterVolume)
	{
   	         Destroy();
        Spawn(class'PROJ_DefenderFG_WT',self,,Location); 
	}
}

simulated function Destroyed()
{
        Tracer.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     FireSound=SoundGroup'DKoppIISound.88mm'
     FireSoundVolume=255.000000
     FireSoundRadius=1500.000000
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo90RG'
     SplashManager=Class'UberSoldierVehicles.IM_DK_ProjWater'
     ShakeRadius=900.000000
     MotionBlurRadius=900.000000
     MotionBlurFactor=10.000000
     Speed=20000.000000
     MaxSpeed=20000.000000
     Damage=900.000000
     DamageRadius=900.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FG'
}
