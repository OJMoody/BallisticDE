class PROJ_FearNG extends DKProjectile;

var() Sound FlySound;
var() float ShellTime;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	SetTimer(0.15, false);
	if (FastTrace(Location + vector(rotation) * 0, Location))
		PlaySound(FlySound, SLOT_Interact, 1.0, , 512, , false);
}

simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, None);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
                Spawn(class'PROJ_AbramsNapalm'); 

	Explode(Location, HitNormal);
}

defaultproperties
{
     FireSound=SoundGroup'DKoppIISound.122mm'
     FireSoundVolume=255.000000
     FireSoundRadius=1500.000000
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo152NG'
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
     Speed=6000.000000
     MaxSpeed=6000.000000
     Damage=1520.000000
     DamageRadius=1520.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FearNG'
     StaticMesh=StaticMesh'DKVehiclesMesh.TankShel'
     Physics=PHYS_Falling
     DrawScale=5.000000
     Skins(0)=Texture'XWeapons.Skins.NewFlakSkin'
     SoundRadius=800.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=10000.000000
     bFixedRotationDir=True
     bIgnoreTerminalVelocity=True
     RotationRate=(Roll=32768)
}
