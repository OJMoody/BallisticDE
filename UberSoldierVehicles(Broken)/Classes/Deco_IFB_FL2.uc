class Deco_IFB_FL2 extends DKKarma;

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
     StaticMesh=StaticMesh'DKVehiclesMesh.IFB.IFB_FL2'
     bUseDynamicLights=True
     LifeSpan=25.000000
     DrawScale=1.500000
     AmbientGlow=60
}
