class Deco_BredleyKorpus extends DKMesh;

var ShadowProjector Shadow;
var() vector ShadowDir;

function PostBeginPlay()
{
	super.PostBeginPlay();

			Shadow = Spawn(class'ShadowProjector',Self,'',Location);
			Shadow.ShadowActor = self;
			Shadow.bBlobShadow = false;
			Shadow.LightDirection = Normal(vect(0,0,5));
			Shadow.LightDistance = 1000;
			Shadow.MaxTraceDistance = 10000;
			Shadow.CullDistance = 0;
			Shadow.InitShadow();
}

simulated function Destroyed()
{
         Spawn(class'Deco_BredleyChassis',,, Location + (vect(0,0,0) << Rotation)); 

                Shadow.Destroy();

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Bredley.Bredley_Coll'
     DrawScale=1.800000
     Skins(0)=Shader'DKVehiclesTex.Bredley.Bredley'
}
