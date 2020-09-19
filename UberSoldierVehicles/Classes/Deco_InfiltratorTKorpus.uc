class Deco_InfiltratorTKorpus extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_InfiltratorTurret',,, Location + (vect(0,0,50) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Infiltrator.InfiltratorT_Coll'
     DrawScale=0.650000
     Skins(0)=Shader'DKVehiclesTex.Infiltrator.Infiltrator'
}
