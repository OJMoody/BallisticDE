class Deco_T90MK2Korpus extends DKMesh;

simulated function Destroyed()
{
         Spawn(class'Deco_AbramsMK2Chassis',,, Location + (vect(0,0,0) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.T90.T90MK2_Coll'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.T90.T90MK2'
}
