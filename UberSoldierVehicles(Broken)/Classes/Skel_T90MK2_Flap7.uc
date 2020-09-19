class Skel_T90MK2_Flap7 extends DKMesh;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

defaultproperties
{
     Health=800
     StaticMesh=StaticMesh'DKVehiclesMesh.T90.T90MK2_Flap7'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.T90.T90MK2'
}
