class Deco_MerkavaKorpus extends DKMesh;


simulated function Destroyed()
{
         Spawn(class'Deco_MerkavaChassis',,, Location + (vect(0,0,0) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Merkava.Merkava_Coll'
     DrawScale=2.200000
     Skins(0)=Shader'DKVehiclesTex.Merkava.Merkava'
}
