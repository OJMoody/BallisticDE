class Skel_Abrams_FlapL extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_AbramsFlapL',self,, Location + (vect(0,0,0) << Rotation));
}

defaultproperties
{
     Health=1800
     StaticMesh=StaticMesh'DKVehiclesMesh.Abrams.Abrams_FlapL'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.Abrams.Abrams'
}
