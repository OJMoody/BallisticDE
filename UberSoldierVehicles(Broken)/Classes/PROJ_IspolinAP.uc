class PROJ_IspolinAP extends DKProjectile;

var vector Dir;

var FX_FireEffect_Ispolin Fire;
var FX_Tracer_IspolinAP Tracer;


simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
          Fire = Spawn(class'FX_FireEffect_Ispolin',self,,Location); 
          Tracer = Spawn(class'FX_Tracer_IspolinAP',self,,Location); 
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
   local Vector VNorm;
   local Rotator NewRotation;

   if (Wall.bWorldGeometry == true)
   {
   Vnorm = (Velocity dot HitNormal) * HitNormal;
   NewRotation = rotator(-VNorm + (Velocity - VNorm));

   Spawn(class'FX_TracerOFF_IspolinAP',,,Location, NewRotation);
   }

   Spawn(class'PROJ_IspolinAP_PS',self,,Location); 

	Explode(Location, HitNormal);
}

simulated function Destroyed()
{
        Tracer.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     FireSound=SoundGroup'DKoppIISound.76mm'
     FireSoundVolume=255.000000
     FireSoundRadius=1500.000000
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo75AP'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=175.000000
     MotionBlurRadius=175.000000
     MotionBlurFactor=10.000000
     Speed=20000.000000
     MaxSpeed=20000.000000
     Damage=750.000000
     DamageRadius=175.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_AP'
}
