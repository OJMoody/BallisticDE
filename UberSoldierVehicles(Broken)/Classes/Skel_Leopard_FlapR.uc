class Skel_Leopard_FlapR extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_LeopardFlapR',self,, Location + (vect(0,0,0) << Rotation));

	Super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Leopard.Leopard_FlapR'
     LifeSpan=99999.000000
     DrawScale=1.700000
     Skins(0)=Shader'DKVehiclesTex.Leopard.Leopard'
}
