class Deco_T90MK2TKorpus extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_AbramsMK2Turret',,, Location + (vect(0,0,0) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.T90.T90MK2T_Coll'
     DrawScale=2.000000
     Skins(0)=Shader'DKVehiclesTex.T90.T90MK2'
}
