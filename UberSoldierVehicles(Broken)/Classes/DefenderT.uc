class DefenderT extends DKWeapons;

var Deco_DefenderTKorpus Korpus;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

       if (Korpus==none) 
       { 
         Korpus = Spawn(class'Deco_DefenderTKorpus',self,, Location + (vect(20,0,0) << Rotation)); 
       if( !AttachToBone(Korpus,'A') ) 
       { 
               Korpus.Destroy(); 
                         return; 
       }
       }
}

simulated function Destroyed()
{
	                 Korpus.Destroy();

	Super.Destroyed();
}

defaultproperties
{
     MinAim=0.100000
     YawBone="Turret"
     PitchBone="Barrel"
     PitchDownLimit=63000
     WeaponFireAttachmentBone="Fire"
     RotationsPerSecond=0.060000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.Defender.Defender'
     BlueSkin=Shader'DKVehiclesTex.Defender.Defender'
     FireInterval=9.000000
     AltFireInterval=9.000000
     ProjectileClass=Class'UberSoldierVehicles.PROJ_DefenderFG'
     AltFireProjectileClass=Class'UberSoldierVehicles.PROJ_DefenderAP'
     Mesh=SkeletalMesh'DKVehiclesAnim.DefenderT'
     Skins(0)=Shader'DKVehiclesTex.Defender.Defender'
     Skins(1)=Texture'DKVehiclesTex.Detail.invis'
}
