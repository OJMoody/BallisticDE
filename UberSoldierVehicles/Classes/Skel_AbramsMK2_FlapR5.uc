class Skel_AbramsMK2_FlapR5 extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

defaultproperties
{
     Health=800
     StaticMesh=StaticMesh'DKVehiclesMesh.AbramsMK2.AbramsMK2_FlapR5'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.AbramsMK2.AbramsMK2'
}
