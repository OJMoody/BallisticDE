class Deco_HammerKorpus extends DKMesh;

simulated function Destroyed()
{
         Spawn(class'Deco_HammerChassis',,, Location + (vect(0,0,30) << Rotation)); 
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Hammer.Hammer_Coll'
     CullDistance=250.000000
     DrawScale=0.650000
     Skins(0)=Texture'DKVehiclesTex.Detail.invis'
}
