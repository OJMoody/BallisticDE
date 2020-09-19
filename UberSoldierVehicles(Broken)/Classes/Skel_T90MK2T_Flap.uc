class Skel_T90MK2T_Flap extends DKMesh;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

defaultproperties
{
     Health=800
     StaticMesh=StaticMesh'DKVehiclesMesh.T90.T90MK2T_Flap'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.T90.T90MK2'
}
