class Skel_Bredley_ReshotkaR extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

defaultproperties
{
     Health=600
     StaticMesh=StaticMesh'DKVehiclesMesh.Bredley.Bredley_ReshotkaR'
     DrawScale=1.800000
     Skins(0)=Shader'DKVehiclesTex.Bredley.Bredley'
}
