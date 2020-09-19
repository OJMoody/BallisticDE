class Deco_MerkavaTKorpus extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_MerkavaTurret',,, Location + (vect(0,0,0) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Merkava.MerkavaT_Coll'
     DrawScale=2.200000
     Skins(0)=Shader'DKVehiclesTex.Merkava.MerkavaT'
}
