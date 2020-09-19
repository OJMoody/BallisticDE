class Skel_Hammer_FlapF extends DKKarma;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_HammerFlapF',self,, Location + (vect(0,0,0) << Rotation));
}

defaultproperties
{
     bDamageable=True
     Health=500
     StaticMesh=StaticMesh'DKVehiclesMesh.Hammer.Hammer_FlapF'
     LifeSpan=99999.000000
     DrawScale=0.650000
     Skins(0)=Shader'DKVehiclesTex.Hammer.Hammer'
}
