class Skel_IspolinT_FlapR extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Ispolin.IspolinT_FlapR'
     DrawScale=0.700000
     Skins(0)=Shader'DKVehiclesTex.T18.T18'
}
