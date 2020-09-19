class LeopardT extends DKWeapons;

var Deco_LeopardTKorpus Korpus;

var Skel_Leopard_FlapR FlapR;
var Skel_Leopard_FlapL FlapL;

function PostBeginPlay()
{
       if (Korpus==none) 
       { 
         Korpus = Spawn(class'Deco_LeopardTKorpus',self,, Location + (vect(0,0,-1) << Rotation)); 
       if( !AttachToBone(Korpus,'Turret') ) 
       { 
               Korpus.Destroy(); 
                         return; 
       }
       }

       if (FlapR==none) 
       { 
         FlapR = Spawn(class'Skel_Leopard_FlapR',self,, Location + (vect(0,0,-1) << Rotation)); 
       if( !AttachToBone(FlapR,'BortR') ) 
       { 
               FlapR.Destroy(); 
                         return; 
       }
       }

       if (FlapL==none) 
       { 
         FlapL = Spawn(class'Skel_Leopard_FlapL',self,, Location + (vect(0,0,-1) << Rotation)); 
       if( !AttachToBone(FlapL,'BortL') ) 
       { 
               FlapL.Destroy(); 
                         return; 
       }
       }

	super.PostBeginPlay();
}

simulated function Destroyed()
{
	                 Korpus.Destroy();

	                 FlapR.Destroy();
	                 FlapL.Destroy();

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
     DualFireOffset=48.000000
     RotationsPerSecond=0.090000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.Leopard.Leopard'
     BlueSkin=Shader'DKVehiclesTex.Leopard.Leopard'
     FireInterval=9.000000
     AltFireInterval=9.000000
     FireSoundClass=SoundGroup'DKoppIISound.88mm'
     FireSoundVolume=255.000000
     FireSoundRadius=1000.000000
     AltFireSoundClass=SoundGroup'DKoppIISound.88mm'
     ProjectileClass=Class'UberSoldierVehicles.PROJ_AbramsMK2FG'
     AltFireProjectileClass=Class'UberSoldierVehicles.PROJ_AbramsMK2AP'
     Mesh=SkeletalMesh'DKVehiclesAnim.LeopardT'
     Skins(0)=Shader'DKVehiclesTex.Leopard.Leopard'
     Skins(1)=Texture'DKVehiclesTex.Detail.invis'
     bFullVolume=True
     TransientSoundVolume=2.000000
     TransientSoundRadius=1.000000
}
