//=============================================================================
// Xk2Attachment.
//
// 3rd person weapon attachment for XK2 SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class T9CNAttachment extends HandgunAttachment;

defaultproperties
{
     RelativeRotation=(Pitch=32768)
	 PrePivot=(Z=-3.000000)
	 MuzzleFlashClass=Class'BWBP_SKCExp_Pro.T9CNFlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerMix=-3
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.T9CN_TPm'
     DrawScale=0.150000
}
