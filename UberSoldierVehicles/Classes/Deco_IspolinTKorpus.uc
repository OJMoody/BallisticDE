class Deco_IspolinTKorpus extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_IspolinTurret',,, Location + (vect(0,0,0) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Ispolin.IspolinT_Coll'
     DrawScale=0.700000
     Skins(0)=Shader'DKVehiclesTex.T18.T18'
}
