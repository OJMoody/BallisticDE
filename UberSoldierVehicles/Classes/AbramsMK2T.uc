class AbramsMK2T extends DKWeapons;

var Deco_AbramsMK2TKorpus Korpus;

var FX_IspolinLightEffect Light1;
var FX_IspolinLightEffect Light2;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
 
         Korpus = Spawn(class'Deco_AbramsMK2TKorpus',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Korpus,'Turret');

         Light1 = Spawn(class'FX_IspolinLightEffect',self,,Location); 
       AttachToBone(Light1,'LightR');

         Light2 = Spawn(class'FX_IspolinLightEffect',self,,Location); 
       AttachToBone(Light2,'LightL');
}

simulated function Destroyed()
{
	    Korpus.Destroy();

	    Light1.Destroy();
	    Light2.Destroy();

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
     RedSkin=Shader'DKVehiclesTex.AbramsMK2.AbramsMK2T'
     BlueSkin=Shader'DKVehiclesTex.AbramsMK2.AbramsMK2T'
     FireInterval=8.500000
     AltFireInterval=8.500000
     ProjectileClass=Class'UberSoldierVehicles.PROJ_AbramsMK2FG'
     AltFireProjectileClass=Class'UberSoldierVehicles.PROJ_AbramsMK2AP'
     Mesh=SkeletalMesh'DKVehiclesAnim.AbramsMK2T'
     Skins(0)=Shader'DKVehiclesTex.AbramsMK2.AbramsMK2T'
     Skins(1)=Texture'DKVehiclesTex.Detail.invis'
}
