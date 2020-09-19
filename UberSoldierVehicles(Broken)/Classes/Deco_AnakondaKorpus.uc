class Deco_AnakondaKorpus extends DKMesh;

simulated function Destroyed()
{
         Spawn(class'Deco_AnakondaChassis',,, Location + (vect(0,0,30) << Rotation)); 
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Anakonda.Anakonda_Coll'
     DrawScale=1.400000
     Skins(0)=Texture'DKVehiclesTex.Detail.invis'
     Skins(1)=Texture'DKVehiclesTex.Detail.invis'
     Skins(2)=Texture'DKVehiclesTex.Detail.invis'
}
