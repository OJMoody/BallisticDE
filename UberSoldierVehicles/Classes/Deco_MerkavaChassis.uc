class Deco_MerkavaChassis extends DKKarma;

var FX_DecoTankFire Effect;

function PostBeginPlay()
{
	super.PostBeginPlay();

                 Effect = spawn( class'FX_DecoTankFire',self,,Location + (vect(0,0,20) << Rotation));  
}

simulated function Destroyed()
{
	super.Destroyed();
}

defaultproperties
{
     bDamageable=True
     StaticMesh=StaticMesh'DKVehiclesMesh.Merkava.Merkava_X'
     DrawScale=2.200000
     Skins(0)=Shader'DKVehiclesTex.Merkava.Merkava_X'
}
