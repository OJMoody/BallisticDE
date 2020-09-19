class Deco_BredleyTKorpus extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_BredleyTurret',,, Location + (vect(0,0,0) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Bredley.BredleyT_Coll'
     DrawScale=9.000000
     Skins(0)=Shader'DKVehiclesTex.Bredley.Bredley'
}
