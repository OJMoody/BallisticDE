class Deco_AbramsFlapR extends DKKarma;

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
     StaticMesh=StaticMesh'DKVehiclesMesh.Abrams.Abrams_FlapR'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.Abrams.AbramsX'
}
