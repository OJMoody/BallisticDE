class Deco_IspolinTFlapL extends DKKarma;

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
     StaticMesh=StaticMesh'DKVehiclesMesh.Ispolin.IspolinT_FlapL'
     LifeSpan=25.000000
     DrawScale=0.700000
     Skins(0)=Shader'DKVehiclesTex.T18.T18'
}
