class Deco_DefenderChassis extends DKKarma;

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
     bDamageable=True
     Health=2000
     StaticMesh=StaticMesh'DKVehiclesMesh.Defender.Defender_X'
     DrawScale=2.000000
}
