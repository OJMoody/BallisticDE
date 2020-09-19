class Deco_AmazonKorpus extends DKMesh;

simulated function Destroyed()
{
         Spawn(class'Deco_AmazonChassis',,, Location + (vect(0,0,0) << Rotation)); 

                Shadow.Destroy();

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Amazon.Amazon_Coll'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.Amazon.Amazon'
}
