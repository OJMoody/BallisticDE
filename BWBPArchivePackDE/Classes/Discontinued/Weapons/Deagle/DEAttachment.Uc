//=============================================================================
// M806Attachment.
//
// 3rd person weapon attachment for M806 Pistol
//
// by Nolan "Dark Carnivour" Richert. Uses's Sarge's AH208 model.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DEAttachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BWBPArchivePackDE.DEFlashEmitter'
     ImpactManager=Class'BallisticDE.IM_Bullet'
     FlashScale=0.250000
     BrassClass=Class'BWBPArchivePackDE.Brass_50DE'
     TracerClass=Class'BallisticDE.TraceEmitter_Pistol'
     TracerChance=0.600000
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     Mesh=SkeletalMesh'BWWeaponPackAnims.DE-3rd'
     DrawScale=0.540000
}
