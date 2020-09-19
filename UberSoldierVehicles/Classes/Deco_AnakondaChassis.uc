class Deco_AnakondaChassis extends DKKarma;

var FX_DecoTankFire Effect;

function PostBeginPlay()
{
	super.PostBeginPlay();

                 Effect = spawn( class'FX_DecoTankFire',self,,Location + (vect(0,0,0) << Rotation));    
}

simulated function Destroyed()
{
                Effect.Destroy();

	super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Anakonda.Anakonda_X'
     DrawScale=1.700000
}
