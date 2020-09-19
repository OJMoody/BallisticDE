class InfiltratorT extends DKWeapons;

var Deco_InfiltratorTKorpus Korpus;

var FX_IspolinLaserEffect Laser;

function PostBeginPlay()
{
	super.PostBeginPlay();
 
         Korpus = Spawn(class'Deco_InfiltratorTKorpus',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Korpus,'A');

         Laser = Spawn(class'FX_IspolinLaserEffect',self,,Location); 
       AttachToBone(Laser,'Laser');
}

simulated function Destroyed()
{
	    Korpus.Destroy();

	    Laser.Destroy();

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
     RedSkin=Shader'DKVehiclesTex.Infiltrator.Infiltrator'
     BlueSkin=Shader'DKVehiclesTex.Infiltrator.Infiltrator'
     FireInterval=8.500000
     AltFireInterval=8.500000
     ProjectileClass=Class'UberSoldierVehicles.PROJ_AbramsMK2FG'
     AltFireProjectileClass=Class'UberSoldierVehicles.PROJ_AbramsMK2AP'
     Mesh=SkeletalMesh'DKVehiclesAnim.InfiltratorT'
     Skins(0)=Shader'DKVehiclesTex.Infiltrator.Infiltrator'
     Skins(1)=Texture'DKVehiclesTex.Detail.invis'
}
