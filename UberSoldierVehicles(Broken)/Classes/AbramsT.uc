class AbramsT extends DKWeapons;

var Deco_AbramsTKorpus Korpus;

var FX_AbramsTurFire FireR;
var FX_AbramsTurFire FireL;

function PostBeginPlay()
{
         Korpus = Spawn(class'Deco_AbramsTKorpus',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Korpus,'A');

         FireR = Spawn(class'FX_AbramsTurFire',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(FireR,'FireR');

         FireL = Spawn(class'FX_AbramsTurFire',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(FireL,'FireL');

	super.PostBeginPlay();
}

simulated function Destroyed()
{
	                 Korpus.Destroy();

	                 FireR.Destroy();
	                 FireL.Destroy();

	Super.Destroyed();
}

defaultproperties
{
     MinAim=0.100000
     YawBone="Turret"
     PitchBone="Barrel"
     PitchUpLimit=3500
     PitchDownLimit=63000
     WeaponFireAttachmentBone="Fire"
     RotationsPerSecond=0.100000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.Abrams.Abrams'
     BlueSkin=Shader'DKVehiclesTex.Abrams.Abrams'
     FireInterval=0.250000
     AltFireInterval=10.500000
     ProjectileClass=Class'UberSoldierVehicles.PROJ_AbramsMG'
     AltFireProjectileClass=Class'UberSoldierVehicles.PROJ_AbramsNG'
     Mesh=SkeletalMesh'DKVehiclesAnim.AbramsT'
     Skins(1)=Texture'DKVehiclesTex.Detail.invis'
}
