class Skel_Amazon_FlapR extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_AmazonFlapR',self,, Location + (vect(0,0,0) << Rotation));

	Super.Destroyed();
}

defaultproperties
{
     Health=850
     StaticMesh=StaticMesh'DKVehiclesMesh.Amazon.Amazon_FlapR'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.Amazon.Amazon'
     Skins(1)=Shader'DKVehiclesTex.Amazon.AmazonT'
}
