class Skel_Hammer_ColL extends DKKarma;

function PostBeginPlay()
{
	super.PostBeginPlay();

                Shadow.Destroy();
}

simulated function Destroyed()
{
         Spawn(class'Deco_Hammer_Col_L',self,, Location + (vect(0,0,0) << Rotation));
}

defaultproperties
{
     StaticMesh=StaticMesh'DKVehiclesMesh.Merkava.Merkava_PanelL0'
     DrawScale=0.100000
     Skins(0)=Texture'DKVehiclesTex.Detail.invis'
}
