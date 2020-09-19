class Deco_BattleMasterChassis extends DKKarma;

var FX_DecoTankFire Effect;
var PROJ_TankExp Decal;

function PostBeginPlay()
{
	super.PostBeginPlay();

                 Effect = spawn( class'FX_DecoTankFire',self,,Location + (vect(0,0,0) << Rotation));
}

simulated function Destroyed()
{
                Effect.Destroy();

	super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.BattleMaster.BattleMaster_X'
     DrawScale=3.000000
}
