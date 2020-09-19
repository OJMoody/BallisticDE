class Skel_Bredley_PanelAL extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

defaultproperties
{
     Health=600
     StaticMesh=StaticMesh'DKVehiclesMesh.Bredley.Bredley_PanelAL'
     DrawScale=1.800000
     Skins(0)=Shader'DKVehiclesTex.Bredley.Bredley'
}
