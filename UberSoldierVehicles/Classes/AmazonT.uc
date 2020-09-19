class AmazonT extends DKWeapons;

var Deco_AmazonTKorpus Korpus;

var Skel_AmazonT_FlapA FlapA;

var FX_IspolinLightEffect Light1;
var FX_IspolinLightEffect Light2;

function PostBeginPlay()
{
	super.PostBeginPlay();

         Korpus = Spawn(class'Deco_AmazonTKorpus',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Korpus,'A');

         FlapA = Spawn(class'Skel_AmazonT_FlapA',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(FlapA,'FlapA');

         Light1 = Spawn(class'FX_IspolinLightEffect',self,,Location); 
       AttachToBone(Light1,'LightR');

         Light2 = Spawn(class'FX_IspolinLightEffect',self,,Location); 
       AttachToBone(Light2,'LightL');
}

simulated function Destroyed()
{
	    Korpus.Destroy();

	    FlapA.Destroy();

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
     RotationsPerSecond=0.080000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.Amazon.AmazonT'
     BlueSkin=Shader'DKVehiclesTex.Amazon.AmazonT'
     FireInterval=1.500000
     AltFireInterval=8.800000
     ProjectileClass=Class'UberSoldierVehicles.PROJ_AmazonMG'
     AltFireProjectileClass=Class'UberSoldierVehicles.PROJ_AmazonEN'
     Mesh=SkeletalMesh'DKVehiclesAnim.AmazonT'
}
