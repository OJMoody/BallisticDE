class Skel_IspolinT_FlapL extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Ispolin.IspolinT_FlapL'
     DrawScale=0.700000
     Skins(0)=Shader'DKVehiclesTex.T18.T18'
}
