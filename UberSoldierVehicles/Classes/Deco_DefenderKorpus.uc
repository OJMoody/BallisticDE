class Deco_DefenderKorpus extends DKMesh;

simulated function Destroyed()
{
         Spawn(class'Deco_DefenderChassis',,, Location + (vect(0,0,50) << Rotation));

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Defender.Defender_Coll'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.Defender.Defender'
}
