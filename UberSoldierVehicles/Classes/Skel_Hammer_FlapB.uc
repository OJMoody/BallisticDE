class Skel_Hammer_FlapB extends DKKarma;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_HammerFlapB',self,, Location + (vect(0,0,1) << Rotation));
}

defaultproperties
{
     bDamageable=True
     Health=500
     StaticMesh=StaticMesh'DKVehiclesMesh.Hammer.Hammer_FlapB'
     LifeSpan=99999.000000
     DrawScale=0.650000
     Skins(0)=Shader'DKVehiclesTex.Hammer.Hammer'
}
