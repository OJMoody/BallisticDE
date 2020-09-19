class Deco_IFBChassis extends DKKarma;

var FX_EngineFire Effect;
var FX_DecoTankFire Effect2;
var PROJ_TIFVExp Decal;

function PostBeginPlay()
{
	super.PostBeginPlay();

                 Effect = spawn( class'FX_EngineFire',self,,Location + (vect(0,0,0) << Rotation));  
                 Effect2 = spawn( class'FX_DecoTankFire',self,,Location + (vect(0,0,0) << Rotation));  
                 Decal = spawn( class'PROJ_TIFVExp',self,,Location + (vect(0,0,50) << Rotation));  

}

simulated function Destroyed()
{
                Effect.Destroy();
                Effect2.Destroy();

	super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.IFB.IFB_X'
     DrawScale=1.500000
}
