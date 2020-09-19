class Skel_MerkavaT_FlapA extends DKMesh;

simulated function Destroyed()
{
         Spawn(class'Deco_MerkavaTFlapA',self,, Location + (vect(0,0,0) << Rotation));

	Super.Destroyed();
}

defaultproperties
{
     Health=1100
     StaticMesh=StaticMesh'DKVehiclesMesh.Merkava.MerkavaT_FlapA'
     DrawScale=2.200000
     Skins(0)=Shader'DKVehiclesTex.Merkava.MerkavaT'
}
