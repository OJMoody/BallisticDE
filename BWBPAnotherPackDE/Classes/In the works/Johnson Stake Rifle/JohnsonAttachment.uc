//=============================================================================
// BulldogAttachment.
//
// 3rd person weapon attachment for the Suzuki XL7
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JohnsonAttachment extends BallisticAttachment;


defaultproperties
{
     MuzzleFlashClass=Class'BWBPAnotherPackDE.AH104FlashEmitter'
     AltMuzzleFlashClass=Class'BWBPAnotherPackDE.AH104FlashEmitter'
     ImpactManager=Class'BWBPAnotherPackDE.IM_ExpBulletLarge'
     AltFlashBone="ejector"
     BrassClass=Class'BWBPAnotherPackDE.Brass_JBOLT'
     FlashMode=MU_Both
     BrassMode=MU_Both
     TracerChance=2.000000
     TracerMix=1.000000
     TracerClass=Class'BWBPAnotherPackDE.TraceEmitter_Bulldog'
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     Mesh=SkeletalMesh'BWBPAnotherPackAnims.PUG12_TPm'
     RelativeLocation=(X=-2.000000,Y=0.000000,Z=0.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.300000
}
