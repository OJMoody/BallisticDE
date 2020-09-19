class PROJ_IspolinAPR extends DKProjectile;

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
        Spawn(class'PROJ_MerkavaAPR_PS',self,,Location);
        Spawn(class'FX_AP_MediumRic',self,,Location);  

	Explode(Location, HitNormal);
}

simulated function Destroyed()
{
        Tracer.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     EhoFireSound=SoundGroup'DKoppIISound.Hit.EhoC'
     EhoFireSoundVolume=2.000000
     EhoFireSoundRadius=100000.000000
     EhoExpSound=SoundGroup'DKoppIISound.Hit.EhoExpA'
     EhoExpSoundVolume=2.000000
     EhoExpSoundRadius=100000.000000
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo75AP'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=92.000000
     MotionBlurRadius=92.000000
     MotionBlurFactor=10.000000
     Speed=10000.000000
     MaxSpeed=10000.000000
     Damage=375.000000
     DamageRadius=107.500000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_AP'
     Physics=PHYS_Falling
     bIgnoreTerminalVelocity=True
     bOrientToVelocity=True
}
