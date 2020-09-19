class Deco_BattleMasterTKorpus extends DKMesh;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_BattleMasterTurret',,, Location + (vect(0,0,60) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.BattleMaster.BattleMasterT_Coll'
     DrawScale=1.500000
     Skins(0)=Shader'DKVehiclesTex.BattleMaster.BattleMasterT'
}
