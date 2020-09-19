class Skel_AmazonT_FlapA extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_AmazonTFlapA',self,, Location + (vect(0,0,0) << Rotation));

	Super.Destroyed();
}

defaultproperties
{
     Health=850
     StaticMesh=StaticMesh'DKVehiclesMesh.Amazon.AmazonT_FlapA'
     DrawScale=0.650000
     Skins(0)=Shader'DKVehiclesTex.Amazon.AmazonT'
}
