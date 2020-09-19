class PROJ_SkelExp extends DKProjectile;

simulated function PostBeginPlay()
{
    Explode(Location, vect(0,0,0));
}

simulated function Destroyed()
{
	Super.Destroyed();
}

defaultproperties
{
     ShakeRadius=0.000000
     DamageRadius=300.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_SkelExp'
     StaticMesh=StaticMesh'DKVehiclesMesh.TankShel'
     DrawScale=0.001000
}
