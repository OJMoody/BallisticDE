class Deco_AbramsMK2TKorpus extends DKMesh;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_AbramsMK2Turret',,, Location + (vect(0,0,50) << Rotation)); 

	super.Destroyed();
}

defaultproperties
{
     bDamageable=False
     StaticMesh=StaticMesh'DKVehiclesMesh.AbramsMK2.AbramsMK2T_Coll'
     DrawScale=1.750000
     Skins(0)=Shader'DKVehiclesTex.AbramsMK2.AbramsMK2T'
}
