class PROJ_DefenderAP extends DKProjectile;

var vector Dir;

var FX_FireEffect_Defender Fire;
var FX_Tracer_DefenderAP Tracer;
var DT_TankExplosionDecalLow X;


simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
          Fire = Spawn(class'FX_FireEffect_Defender',self,,Location);
          Tracer = Spawn(class'FX_Tracer_DefenderAP',self,,Location);
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
   local Vector VNorm;
   local Rotator NewRotation;

   if (Wall.bWorldGeometry == true)
   {
   Vnorm = (Velocity dot HitNormal) * HitNormal;
   NewRotation = rotator(-VNorm + (Velocity - VNorm));

   if (FRand() > 0.4) Spawn(class'PROJ_DefenderAPR',,,Location, NewRotation);
   }

   Spawn(class'PROJ_DefenderAP_PS',self,,Location); 

    X = Spawn(class'DT_TankExplosionDecalLow', Self,, Location, rot(16384,0,0));
    if (X != None)
    {
        X.SetBase(Self);
    }

	Explode(Location, HitNormal);
	Super.HitWall(HitNormal, Wall);
}

simulated event PhysicsVolumeChange(PhysicsVolume NewVolume)
{
	If (NewVolume.bWaterVolume)
	{
   	         Destroy(); 
        Spawn(class'IE_ProjWater',self,,Location); 
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
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo90RP'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=100.000000
     MotionBlurRadius=190.000000
     MotionBlurFactor=10.000000
     Speed=20000.000000
     MaxSpeed=20000.000000
     Damage=900.000000
     DamageRadius=190.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_AP'
}
