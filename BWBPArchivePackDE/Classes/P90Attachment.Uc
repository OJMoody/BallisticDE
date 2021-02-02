//=============================================================================
// Xk2Attachment.
//
// 3rd person weapon attachment for XK2 SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class P90Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BWBPArchivePackDE.P90FlashEmitter'
     ImpactManager=Class'BallisticDE.IM_Bullet'
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
     Mesh=SkeletalMesh'BWBP_JCF_Anims.P90_TPm'
     DrawScale=0.310000
}
