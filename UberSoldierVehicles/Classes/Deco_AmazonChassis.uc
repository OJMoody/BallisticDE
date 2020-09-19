class Deco_AmazonChassis extends DKKarma;

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
     StaticMesh=StaticMesh'DKVehiclesMesh.Amazon.Amazon_X'
     DrawScale=2.000000
}
