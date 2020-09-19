class Deco_DefenderTurret extends DKKarma;

var FX_DecoTurretFire Effect;

function PostBeginPlay()
{
	super.PostBeginPlay();

                 Effect = spawn( class'FX_DecoTurretFire',self,,Location + (vect(0,0,0) << Rotation));  
}

function Destroyed()
{ 
                Effect.Destroy();

	super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Defender.Defender_T_X'
     DrawScale=2.000000
}
