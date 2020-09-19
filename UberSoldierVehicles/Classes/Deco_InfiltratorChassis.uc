class Deco_InfiltratorChassis extends DKKarma;

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
     Health=1800
     StaticMesh=StaticMesh'DKVehiclesMesh.Infiltrator.Infiltrator_X'
     DrawScale=2.000000
}
