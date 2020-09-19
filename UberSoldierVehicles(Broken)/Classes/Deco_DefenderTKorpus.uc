class Deco_DefenderTKorpus extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_DefenderTurret',,, Location + (vect(0,0,0) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.Defender.DefenderT_Coll'
     DrawScale=1.200000
     Skins(0)=Shader'DKVehiclesTex.Defender.Defender'
}
