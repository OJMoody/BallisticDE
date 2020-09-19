class Deco_BredleyChassis extends DKKarma;

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
     StaticMesh=StaticMesh'DKVehiclesMesh.Bredley.Bredley_X'
     DrawScale=1.800000
}
