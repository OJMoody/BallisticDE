class Deco_LeopardTKorpus extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_AbramsTurret',,, Location + (vect(0,0,100) << Rotation)); 
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Leopard.LeopardT_Coll'
     CullDistance=250.000000
     DrawScale=1.700000
     Skins(0)=Texture'DKVehiclesTex.Detail.invis'
}
