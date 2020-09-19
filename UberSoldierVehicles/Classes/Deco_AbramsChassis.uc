class Deco_AbramsChassis extends DKKarma;

function PostBeginPlay()
{
	super.PostBeginPlay();

                 Spawn( class'FX_DecoTurretFire',self,,Location + (vect(0,0,0) << Rotation));  
}

simulated function Destroyed()
{

	super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Abrams.Abrams_X'
     DrawScale=2.000000
}
