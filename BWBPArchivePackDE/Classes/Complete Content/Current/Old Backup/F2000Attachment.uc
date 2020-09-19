//=============================================================================
// F2000Attachment.
//
// Attachment for MARS Assault Carbine. Pancakes are so delicious.
// This gun is pretty.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class F2000Attachment extends BallisticAttachment;

var bool		bSilenced;
var bool		bOldSilenced;


replication
{
	reliable if ( Role==ROLE_Authority )
		bSilenced;
}

simulated event PostNetReceive()
{
	//SetBoneScale (0, 0.0, 'Muzzle2');
	Super.PostNetReceive();
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'Muzzle2');
}




//Do your camo changes here
simulated function PostNetBeginPlay()
{
	//if (CamoIndex != default.CamoIndex) 
		//Skins[1] = CamoWeapon.default.CamoMaterials[CamoIndex];
	//if (CamoIndex == 2)
		//SetBoneScale (1, 0.0, 'EOTech');
}

defaultproperties
{
     //CamoWeapon=Class'BWBPArchivePackDE.F2000AssaultRifle'
     MuzzleFlashClass=Class'BWBPRecolorsDE.MARSFlashEmitter'
     AltMuzzleFlashClass=Class'BallisticDE.XK2SilencedFlash'
     ImpactManager=Class'BallisticDE.IM_Bullet'
     BrassClass=Class'BallisticDE.Brass_Rifle'
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticDE.TraceEmitter_Default'
     TracerChance=2.000000
     TracerMix=0
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     Mesh=SkeletalMesh'BWBPArchivePack2Anim.TP_MARS3'
     RelativeLocation=(Z=4.000000)
     RelativeRotation=(Pitch=32768)
	 ReloadAnim="Reload_AR"
     DrawScale=0.250000
     Skins(1)=Texture'BallisticRecolors5A.MARS.F2000-Irons'
     Skins(2)=Texture'BallisticRecolors5A.LK05.LK05-EOTech'
     Skins(3)=Texture'BallisticRecolors5A.MARS.F2000-Misc'
     Skins(4)=Shader'BallisticRecolors5A.LK05.LK05-EOTechGlow'
}
