class Deco_AmazonTFlapA extends DKKarma;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Amazon.AmazonT_FlapA'
     LifeSpan=25.000000
     DrawScale=0.650000
     Skins(0)=Shader'DKVehiclesTex.Amazon.AmazonT_X'
}
