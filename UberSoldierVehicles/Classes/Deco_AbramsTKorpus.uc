class Deco_AbramsTKorpus extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_AbramsTurret',,, Location + (vect(0,0,100) << Rotation)); 
         Spawn(class'Deco_AbramsFlapA',,,Location + (vect(0,0,50) << Rotation)); 
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Abrams.AbramsT_Coll'
     DrawScale=0.300000
     Skins(0)=Texture'DKVehiclesTex.Detail.invis'
}
