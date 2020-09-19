class AnakondaT extends DKWeapons;

var Deco_AnakondaTKorpus Korpus;

function PostBeginPlay()
{
	super.PostBeginPlay();

       if (Korpus==none) 
       { 
         Korpus = Spawn(class'Deco_AnakondaTKorpus',self,, Location + (vect(0,0,1) << Rotation)); 
       if( !AttachToBone(Korpus,'A') ) 
       { 
               Korpus.Destroy(); 
                         return; 
       }
       }
}

function byte BestMode()
{
	local bot B;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return 0;

	if ( (Vehicle(B.Enemy) != None)
	     && (B.Enemy.bCanFly || B.Enemy.IsA('ONSWheeledCraft')) )
		return 0;
	else
		return 1;
}

simulated function Destroyed()
{
	        Korpus.Destroy();

	super.Destroyed();
}

defaultproperties
{
     MinAim=0.100000
     YawBone="Turret"
     PitchBone="Barrel"
     PitchUpLimit=10000
     PitchDownLimit=63000
     WeaponFireAttachmentBone="Fire"
     DualFireOffset=70.000000
     RotationsPerSecond=0.090000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.Anaconda.AnacondaT'
     BlueSkin=Shader'DKVehiclesTex.Anaconda.AnacondaT'
     FireInterval=0.880000
     AltFireInterval=0.880000
     FireSoundClass=SoundGroup'DKoppIISound.45mm'
     FireSoundVolume=255.000000
     FireSoundRadius=800.000000
     AltFireSoundClass=SoundGroup'DKoppIISound.45mm'
     ProjectileClass=Class'UberSoldierVehicles.PROJ_AnakondaFP'
     AltFireProjectileClass=Class'UberSoldierVehicles.PROJ_AnakondaAP'
     Mesh=SkeletalMesh'DKVehiclesAnim.AnakondaT'
     Skins(0)=Shader'DKVehiclesTex.Anaconda.AnacondaT'
     Skins(1)=Texture'DKVehiclesTex.Detail.invis'
}
