class Deco_AnakondaTKorpus extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_AnakondaTurret',,, Location + (vect(0,0,50) << Rotation)); 
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Anakonda.AnakondaT_Coll'
     DrawScale=0.700000
     Skins(0)=Texture'DKVehiclesTex.Detail.invis'
}
