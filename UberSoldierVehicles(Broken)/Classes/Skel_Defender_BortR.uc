class Skel_Defender_BortR extends DKMesh;

function Destroyed()
{
         Spawn(class'PROJ_SkelExp',self,, Location + (vect(0,0,0) << Rotation));
         Spawn(class'Deco_DefenderBortR',self,, Location + (vect(0,0,0) << Rotation));

	Super.Destroyed();
}

defaultproperties
{
     Health=1900
     StaticMesh=StaticMesh'DKVehiclesMesh.Defender.Defender_BortR'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.Defender.Defender'
}
