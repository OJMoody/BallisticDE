class PROJ_TankExp extends DKProjectile;

var() float FuseLength;


function BlowUp(vector HitLocation)
{
	HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	MakeNoise(1.0);
}

simulated function PostNetBeginPlay()
{
	SetTimer(FuseLength, True);
}

simulated function Timer()
{
    Explode(Location, vect(0,0,0));
}

simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, None);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	Explode(Location, vect(0,0,0));
}

simulated function Destroyed()
{
	Super.Destroyed();
}

defaultproperties
{
     FuseLength=0.200000
     EhoExpSound=SoundGroup'DKoppIISound.EhoTankExp'
     EhoExpSoundVolume=2.000000
     EhoExpSoundRadius=100000.000000
     ImpactManager=Class'UberSoldierVehicles.IM_TankExp'
     SplashManager=Class'UberSoldierVehicles.IM_DK_ProjWater'
     ShakeRadius=1000.000000
     Damage=400.000000
     DamageRadius=1200.000000
     MomentumTransfer=100000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_VehiclesExp'
     StaticMesh=StaticMesh'DKVehiclesMesh.TankShel'
     DrawScale=0.001000
}
