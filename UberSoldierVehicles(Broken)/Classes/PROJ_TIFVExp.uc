class PROJ_TIFVExp extends DKProjectile;

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
	Explode(Location, HitNormal);
}

simulated function Destroyed()
{
	Super.Destroyed();
}

defaultproperties
{
     ImpactManager=Class'UberSoldierVehicles.IM_TankExp'
     SplashManager=Class'UberSoldierVehicles.IM_DK_ProjWater'
     ShakeRadius=2000.000000
     MomentumTransfer=50000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_IFVExp'
     StaticMesh=StaticMesh'DKVehiclesMesh.TankShel'
     Physics=PHYS_Falling
     DrawScale=0.001000
}
