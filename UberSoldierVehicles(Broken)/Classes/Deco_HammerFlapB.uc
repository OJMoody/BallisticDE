class Deco_HammerFlapB extends DKKarma;

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
     StaticMesh=StaticMesh'DKVehiclesMesh.Hammer.Hammer_FlapB'
     LifeSpan=25.000000
     DrawScale=0.650000
     Skins(0)=Shader'DKVehiclesTex.Hammer.Hammer_Def_XS'
}
