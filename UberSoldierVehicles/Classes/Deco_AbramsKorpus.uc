class Deco_AbramsKorpus extends DKMesh;

simulated function Destroyed()
{
         Spawn(class'Deco_AbramsChassis',,, Location + (vect(0,0,30) << Rotation)); 
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Abrams.Abrams_Coll'
     CullDistance=250.000000
     DrawScale=2.000000
     Skins(0)=Texture'DKVehiclesTex.Detail.invis'
}
