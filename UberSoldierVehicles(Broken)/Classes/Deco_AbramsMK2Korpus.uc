class Deco_AbramsMK2Korpus extends DKMesh;

simulated function Destroyed()
{
         Spawn(class'Deco_AbramsMK2Chassis',,, Location + (vect(0,0,0) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.AbramsMK2.AbramsMK2_Coll'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.AbramsMK2.AbramsMK2'
}
