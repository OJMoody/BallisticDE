class T90MK2T extends DKWeapons;

var Deco_T90MK2TKorpus Korpus;

var Skel_T90MK2T_Flap FlapB;

var FX_IspolinLightEffect Light1;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
 
	if ( Level.NetMode != NM_DedicatedServer)
	{
         Korpus = Spawn(class'Deco_T90MK2TKorpus',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Korpus,'A');

         FlapB = Spawn(class'Skel_T90MK2T_Flap',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(FlapB,'FlapB');

         Light1 = Spawn(class'FX_IspolinLightEffect',self,,Location); 
       AttachToBone(Light1,'Cor');
	}
}

simulated function Destroyed()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
	    Korpus.Destroy();

	    FlapB.Destroy();

	    Light1.Destroy();
	}

	super.Destroyed();
}

defaultproperties
{
     MinAim=0.100000
     YawBone="Turret"
     PitchBone="Barrel"
     PitchDownLimit=63000
     WeaponFireAttachmentBone="Fire"
     RotationsPerSecond=0.090000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.T90.T90MK2'
     BlueSkin=Shader'DKVehiclesTex.T90.T90MK2'
     FireInterval=9.000000
     AltFireInterval=9.000000
     ProjectileClass=Class'UberSoldierVehicles.PROJ_MerkavaFG'
     AltFireProjectileClass=Class'UberSoldierVehicles.PROJ_MerkavaAP'
     Mesh=SkeletalMesh'DKVehiclesAnim.T90T'
     Skins(0)=Shader'DKVehiclesTex.T90.T90MK2'
     Skins(1)=Texture'DKVehiclesTex.Detail.invis'
}
