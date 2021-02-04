//=============================================================================
// HKMK23Attachment
//
// 3rd person weapon attachment for Mk23 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HKMK23Attachment extends HandgunAttachment;

simulated event ThirdPersonEffects()
{
    if ( Level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		if (FiringMode == 1)
			SetBoneScale (0, 1.0, 'joint10');
		else
			SetBoneScale (0, 0.0, 'joint10');
    }
	super.ThirdPersonEffects();
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticDE.XK2FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticDE.XK2SilencedFlash'
     ImpactManager=Class'BallisticDE.IM_Bullet'
     AltFlashBone="tip2"
	 Flashscale=0.5
     BrassClass=Class'BallisticDE.Brass_Pistol'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BallisticDE.TraceEmitter_Default'
     TracerMix=-3
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BWBP_JCF_Anims.HKM_TPm'
     DrawScale=0.300000
}
