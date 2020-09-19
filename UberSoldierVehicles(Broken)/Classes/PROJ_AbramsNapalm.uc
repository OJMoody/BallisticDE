class PROJ_AbramsNapalm extends DKProjectile;

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
            Trail = Spawn(class'FXx_ArtyTrail', self);
	}

	super.PostBeginPlay();
}

simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, None);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
                Spawn(class'PROJ_AbramsFire'); 

	Explode(Location, HitNormal);
}

simulated function Destroyed()
{
        Trail.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo30Napalm'
     ShakeRadius=30.000000
     MotionBlurRadius=30.000000
     MotionBlurFactor=10.000000
     Speed=1000.000000
     Damage=60.000000
     DamageRadius=200.000000
     MomentumTransfer=2000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_Napalm'
     StaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleSphere2'
     Physics=PHYS_Falling
     bFixedRotationDir=True
}
