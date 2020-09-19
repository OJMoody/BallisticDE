class Deco_P30_FL extends DKKarma;

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
     StaticMesh=StaticMesh'DKVehiclesMesh.P30.P30_FL'
     bUseDynamicLights=True
     AmbientGlow=60
}
