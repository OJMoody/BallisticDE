class Deco_AbramsMK2Chassis extends DKKarma;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

                 spawn( class'FX_DecoTankFire',self,,Location + (vect(0,0,0) << Rotation));    
}

simulated function Destroyed()
{ 
	super.Destroyed();
}

defaultproperties
{
     bDamageable=True
     StaticMesh=StaticMesh'DKVehiclesMesh.AbramsMK2.AbramsMK2_X'
     DrawScale=2.000000
}
