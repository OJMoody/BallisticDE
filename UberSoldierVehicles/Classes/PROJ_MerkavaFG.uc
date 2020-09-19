class PROJ_MerkavaFG extends DKProjectile;

var vector Dir;

var FX_FireEffect_T90MK2 Fire;
var FX_Tracer_IspolinFG Tracer;
var PROJ_MerkavaFG_PS PS;


simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
          Fire = Spawn(class'FX_FireEffect_T90MK2',,,Location); 
          Tracer = Spawn(class'FX_Tracer_IspolinFG',self,,Location); 
	} 

	Super.PostBeginPlay();
}

simulated function BlowUp(vector HitLocation)
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
	HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	MakeNoise(1.0);
	}
}

simulated event Landed( vector HitNormal )
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
        PS = Spawn(class'PROJ_MerkavaFG_PS',self,,Location); 
	}

	HitWall(HitNormal, None);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
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
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo90FG'
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
