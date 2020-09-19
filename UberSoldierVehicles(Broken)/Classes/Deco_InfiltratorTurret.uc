class Deco_InfiltratorTurret extends DKKarma;

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
     Health=1800
     StaticMesh=StaticMesh'DKVehiclesMesh.Infiltrator.InfiltratorT_X'
     LifeSpan=20.000000
     DrawScale=0.650000
}
