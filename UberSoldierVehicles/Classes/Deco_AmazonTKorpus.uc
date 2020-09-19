class Deco_AmazonTKorpus extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_AmazonTurret',,, Location + (vect(0,0,0) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Amazon.AmazonT_Coll'
     DrawScale=0.650000
     Skins(0)=Shader'DKVehiclesTex.Amazon.AmazonT'
}
