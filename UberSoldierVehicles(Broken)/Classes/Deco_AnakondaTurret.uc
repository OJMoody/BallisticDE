class Deco_AnakondaTurret extends DKKarma;

var FX_DecoTurretFire Effect;

function PostBeginPlay()
{
	super.PostBeginPlay();

                 Effect = spawn( class'FX_DecoTurretFire',self,,Location + (vect(0,0,0) << Rotation));  
}

simulated function Destroyed()
{
                Effect.Destroy();

	super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Anakonda.AnakondaT_X'
     DrawScale=0.700000
}
