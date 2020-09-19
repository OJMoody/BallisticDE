class Deco_IspolinKorpus extends DKMesh;

simulated function Destroyed()
{
         Spawn(class'Deco_IspolinChassis',,, Location + (vect(0,0,0) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Ispolin.Ispolin_Coll'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.T18.T18'
}
