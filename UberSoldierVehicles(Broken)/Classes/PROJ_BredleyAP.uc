class PROJ_BredleyAP extends DKProjectile;

var vector Dir;

var FX_FireEffect_Bredley Fire;
var FX_Tracer_BredleyAP Tracer;
var PROJ_BredleyAP_PS PS;


simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
          Fire = Spawn(class'FX_FireEffect_Bredley',,,Location); 
          Tracer = Spawn(class'FX_Tracer_BredleyAP',self,,Location); 
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

   Spawn(class'PROJ_BredleyAPR',,,Location, NewRotation);
   }

        PS = Spawn(class'PROJ_BredleyAP_PS',,,Location); 

	Explode(Location, HitNormal);
}

simulated function Destroyed()
{
        Tracer.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     FireSound=SoundGroup'DKoppIISound.57mm'
     FireSoundVolume=200.000000
     FireSoundRadius=1000.000000
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo50AP'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=157.000000
     MotionBlurRadius=157.000000
     MotionBlurFactor=10.000000
     Speed=20000.000000
     MaxSpeed=20000.000000
     Damage=570.000000
     DamageRadius=157.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_AP'
}
