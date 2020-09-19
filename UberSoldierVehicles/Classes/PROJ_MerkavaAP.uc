class PROJ_MerkavaAP extends DKProjectile;

var vector Dir;

var FX_FireEffect_T90MK2 Fire;
var FX_Tracer_IspolinAP Tracer;
var PROJ_MerkavaAP_PS PS;

simulated function PostBeginPlay()
{ 
	if ( Level.NetMode != NM_DedicatedServer)
	{
          Fire = Spawn(class'FX_FireEffect_T90MK2',,,Location); 
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
   local Vector VNorm;
   local Rotator NewRotation;

	if ( Level.NetMode != NM_DedicatedServer)
	{
   if (Wall.bWorldGeometry == true)
   {
   Vnorm = (Velocity dot HitNormal) * HitNormal;
   NewRotation = rotator(-VNorm + (Velocity - VNorm));

   Spawn(class'PROJ_MerkavaAPR',,,Location, NewRotation);
   }
        PS = Spawn(class'PROJ_MerkavaAP_PS',self,,Location); 
	}
	Explode(Location, HitNormal);
}

simulated function Destroyed()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
        Tracer.Destroy();
	Super.Destroyed();
	}
}

defaultproperties
{
     FireSound=SoundGroup'DKoppIISound.95mm'
     FireSoundVolume=255.000000
     FireSoundRadius=1500.000000
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo90AP'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=190.000000
     MotionBlurRadius=190.000000
     MotionBlurFactor=10.000000
     Speed=20000.000000
     MaxSpeed=20000.000000
     Damage=900.000000
     DamageRadius=190.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_AP'
}
