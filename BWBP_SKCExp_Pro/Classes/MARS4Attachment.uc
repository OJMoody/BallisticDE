//=============================================================================
// MARS4Attachment.
//
// Attachment for MARS Assault Carbine. Pancakes are so delicious.
// This gun is pretty.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MARS4Attachment extends BallisticAttachment;

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
     MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
	 FlashScale=0.25
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerChance=2.000000
     TracerMix=0
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_Anim.MARS3_TPm'
     RelativeLocation=(Z=4.000000)
	 ReloadAnim="Reload_AR"
     DrawScale=1.000000
     Skins(1)=Texture'BWBP_SKC_TexExp.MARS.F2000-Irons'
     Skins(2)=Texture'BWBP_SKC_Tex.LK05.LK05-EOTech-RDS'
     Skins(3)=Texture'BWBP_SKC_Tex.MARS.F2000-Misc'
     Skins(4)=Shader'BWBP_SKC_Tex.LK05.LK05-EOTechGlow-RDS'
}
