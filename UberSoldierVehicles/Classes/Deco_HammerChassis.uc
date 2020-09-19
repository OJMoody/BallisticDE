class Deco_HammerChassis extends DKKarma;

var FX_DecoTurretFire Effect;
var PROJ_TankExp Decal;

function PostBeginPlay()
{
	super.PostBeginPlay();

                 Effect = spawn( class'FX_DecoTurretFire',self,,Location + (vect(0,0,0) << Rotation));  
                 Decal = spawn( class'PROJ_TankExp',self,,Location + (vect(0,0,0) << Rotation));  

}

simulated function Destroyed()
{
                Effect.Destroy();

	super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Hammer.Hammer_X'
     DrawScale=0.650000
}
