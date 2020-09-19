class Deco_IspolinChassis extends DKKarma;

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
     StaticMesh=StaticMesh'DKVehiclesMesh.Ispolin.Ispolin_X'
     DrawScale=2.000000
}
