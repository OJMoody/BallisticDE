class BredleyT extends DKWeapons;

var Deco_BredleyTKorpus Korpus;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

       Korpus = Spawn(class'Deco_BredleyTKorpus',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Korpus,'A');
}

simulated function Destroyed()
{
	                 Korpus.Destroy();

	Super.Destroyed();
}

defaultproperties
{
     MinAim=0.500000
     YawBone="Turret"
     PitchBone="Barrel"
     PitchDownLimit=63000
     WeaponFireAttachmentBone="Fire"
     RotationsPerSecond=0.100000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.Bredley.Bredley'
     BlueSkin=Shader'DKVehiclesTex.Bredley.Bredley'
     FireInterval=5.700000
     AltFireInterval=5.700000
     ProjectileClass=Class'UberSoldierVehicles.PROJ_BredleyFG'
     AltFireProjectileClass=Class'UberSoldierVehicles.PROJ_BredleyAP'
     Mesh=SkeletalMesh'DKVehiclesAnim.BredleyT'
     Skins(0)=Shader'DKVehiclesTex.Bredley.Bredley'
}
