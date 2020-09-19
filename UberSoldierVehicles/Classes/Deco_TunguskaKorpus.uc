class Deco_TunguskaKorpus extends DKMesh;

simulated function Destroyed()
{
         Spawn(class'Deco_IspolinChassis',,, Location + (vect(0,0,100) << Rotation)); 
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Tunguska.Tunguska_Coll'
     LifeSpan=99999.000000
     DrawScale=2.000000
     Skins(0)=Texture'DKVehiclesTex.Detail.invis'
     AmbientGlow=0
     MaxLights=0
}
