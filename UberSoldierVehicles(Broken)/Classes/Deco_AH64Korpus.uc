class Deco_AH64Korpus extends DKMesh;

simulated function Destroyed()
{
         Spawn(class'FX_AH64Destroy',,, Location + (vect(0,0,0) << Rotation)); 
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.AH64.AH64_Coll'
     CullDistance=250.000000
     DrawScale=2.500000
     Skins(0)=Texture'DKVehiclesTex.Detail.invis'
}
