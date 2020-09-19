class Deco_BattleMasterKorpus extends DKMesh;

simulated function Destroyed()
{
         Spawn(class'Deco_BattleMasterChassis',,, Location + (vect(0,0,30) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.BattleMaster.BattleMaster_Coll'
     DrawScale=3.000000
     Skins(0)=Shader'DKVehiclesTex.BattleMaster.BattleMaster'
}
