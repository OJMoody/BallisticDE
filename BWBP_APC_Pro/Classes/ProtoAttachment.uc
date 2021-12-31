//=============================================================================
// ProtoAttachment.
//
// 3rd person weapon attachment for CYLO Versitile UAW
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ProtoAttachment extends BallisticAttachment;

defaultproperties
{
     //FireClass=Class'BWBP_APC_Pro.ProtoPrimaryFire'
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     MeleeImpactManager=Class'BallisticProV55.IM_Knife'
     AltFlashBone="tipalt"
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassMode=MU_Secondary
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_CC_Anim.ProtoLMG_TPm'
	 RelativeRotation=(Pitch=32768)
	 RelativeLocation=(Z=10)
     DrawScale=0.900000
}