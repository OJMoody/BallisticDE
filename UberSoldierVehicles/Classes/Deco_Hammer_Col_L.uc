class Deco_Hammer_Col_L extends DKKarma;

var FX_DecoTireFire Effect;

function PostBeginPlay()
{
	super.PostBeginPlay();

                 Effect = spawn( class'FX_DecoTireFire',self,,Location + (vect(0,0,0) << Rotation));  

}

simulated function Destroyed()
{
                Effect.Destroy();

	super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Hammer.Hammer_Col_L'
     LifeSpan=30.000000
     DrawScale=0.750000
}
