class Deco_AbramsMK2Turret extends DKKarma;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

                 spawn( class'FX_DecoTurretFire',self,,Location + (vect(0,0,0) << Rotation)); 
}

simulated function Destroyed()
{
	super.Destroyed();
}

defaultproperties
{
     bDamageable=True
     StaticMesh=StaticMesh'DKVehiclesMesh.AbramsMK2.AbramsMK2T_X'
     LifeSpan=20.000000
     DrawScale=1.750000
}
