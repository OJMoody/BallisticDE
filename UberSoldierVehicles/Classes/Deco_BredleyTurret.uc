class Deco_BredleyTurret extends DKKarma;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

                 spawn( class'FX_DecoTurretFire',self,,Location + (vect(0,0,0) << Rotation));  
}

simulated function Destroyed()
{
	super.Destroyed();
}

defaultproperties
{
     bDamageable=True
     StaticMesh=StaticMesh'DKVehiclesMesh.Bredley.BredleyT_X'
     DrawScale=9.000000
}
