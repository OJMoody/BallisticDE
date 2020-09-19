class Deco_AbramsFlapL extends DKKarma;

function PostBeginPlay()
{
	super.PostBeginPlay();
}

simulated function Destroyed()
{
	super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Abrams.Abrams_FlapL'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.Abrams.AbramsX'
}
