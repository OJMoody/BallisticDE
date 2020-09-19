class Deco_MerkavaTurret extends DKKarma;

var FX_DecoTurretFire Effect;

function PostBeginPlay()
{
	super.PostBeginPlay();

                 Effect = spawn( class'FX_DecoTurretFire',self,,Location + (vect(0,0,0) << Rotation));  
}

simulated function Destroyed()
{
                Effect.Destroy();

	super.Destroyed();
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Merkava.MerkavaT_X'
     DrawScale=2.200000
     Skins(0)=Shader'DKVehiclesTex.Merkava.MerkavaT_X'
}
