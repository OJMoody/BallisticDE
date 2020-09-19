class PROJ_FearFG extends DKProjectile;

var() Sound FlySound;
var() float ShellTime;

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
            Trail = Spawn(class'FXx_ArtyTrail', self);
	}

	super.PostBeginPlay();
		PlaySound(FlySound, SLOT_Interact, 1.0, , 512, , false);
}

simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, None);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
                PlaySound(Sound'A3.v130dama',SLOT_None,TransientSoundVolume*0.6,,TransientSoundRadius);

	Explode(Location, HitNormal);
}

simulated function Destroyed()
{
        Trail.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     FireSound=SoundGroup'DKoppIISound.122mm'
     FireSoundVolume=255.000000
     FireSoundRadius=1500.000000
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo152FG'
     SplashManager=Class'UberSoldierVehicles.IM_DK_ProjWater'
     ShakeRadius=1520.000000
     MotionBlurRadius=1520.000000
     MotionBlurFactor=15.000000
     ShakeRotMag=(X=512.000000,Y=400.000000,Z=350.000000)
     ShakeRotRate=(X=7000.000000,Y=7000.000000,Z=5500.000000)
     ShakeRotTime=8.000000
     ShakeOffsetMag=(X=30.000000,Y=30.000000,Z=30.000000)
     ShakeOffsetRate=(X=600.000000,Y=600.000000,Z=600.000000)
     ShakeOffsetTime=10.000000
     Speed=4000.000000
     MaxSpeed=4000.000000
     Damage=1520.000000
     DamageRadius=1520.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FearFG'
     StaticMesh=StaticMesh'DKVehiclesMesh.TankShel'
     Physics=PHYS_Falling
     AmbientSound=Sound'ONSBPSounds.Artillery.ShellAmbient'
     DrawScale=5.000000
     SoundRadius=128.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=10000.000000
     bProjTarget=True
     bFixedRotationDir=True
     bIgnoreTerminalVelocity=True
     bOrientToVelocity=True
     RotationRate=(Roll=32768)
     ForceRadius=60.000000
}
