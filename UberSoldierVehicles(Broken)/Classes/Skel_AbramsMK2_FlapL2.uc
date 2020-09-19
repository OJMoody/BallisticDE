class Skel_AbramsMK2_FlapL2 extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

defaultproperties
{
     Health=800
     StaticMesh=StaticMesh'DKVehiclesMesh.AbramsMK2.AbramsMK2_FlapL2'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.AbramsMK2.AbramsMK2'
}
