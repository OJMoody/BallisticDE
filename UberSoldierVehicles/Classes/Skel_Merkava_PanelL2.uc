class Skel_Merkava_PanelL2 extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

defaultproperties
{
     Health=1100
     StaticMesh=StaticMesh'DKVehiclesMesh.Merkava.Merkava_PanelL2'
     LifeSpan=99999.000000
     DrawScale=2.200000
     Skins(0)=Shader'DKVehiclesTex.Merkava.Merkava'
}
