class MerkavaT extends DKWeapons;

var Deco_MerkavaTKorpus Korpus;

var Skel_MerkavaT_FlapA FlapA;

var FX_IspolinLightEffect Light1;

function PostBeginPlay()
{
	super.PostBeginPlay();

         Korpus = Spawn(class'Deco_MerkavaTKorpus',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Korpus,'A');

         FlapA = Spawn(class'Skel_MerkavaT_FlapA',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(FlapA,'FlapA');

         Light1 = Spawn(class'FX_IspolinLightEffect',self,,Location); 
       AttachToBone(Light1,'LightR'); 
}

simulated function Destroyed()
{
	    Korpus.Destroy();

	    FlapA.Destroy();

	    Light1.Destroy();

	Super.Destroyed();
}

defaultproperties
{
     MinAim=0.100000
     YawBone="Turret"
     PitchBone="Barrel"
     PitchDownLimit=63000
     WeaponFireAttachmentBone="Fire"
     RotationsPerSecond=0.100000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.Merkava.MerkavaT'
     BlueSkin=Shader'DKVehiclesTex.Merkava.MerkavaT'
     FireInterval=9.000000
     AltFireInterval=9.000000
     ProjectileClass=Class'UberSoldierVehicles.PROJ_MerkavaFG'
     AltFireProjectileClass=Class'UberSoldierVehicles.PROJ_MerkavaAP'
     Mesh=SkeletalMesh'DKVehiclesAnim.MerkavaT'
     Skins(0)=Shader'DKVehiclesTex.Merkava.MerkavaT'
}
