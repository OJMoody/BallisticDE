//=============================================================================
// T9CNAttachment.
//
// 3rd person weapon attachment for GRS9 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class T9CNAttachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticDE.XK2FlashEmitter'
     ImpactManager=Class'BallisticDE.IM_Bullet'
     BrassClass=Class'BallisticDE.Brass_GRSNine'
     InstantMode=MU_Both
     TracerClass=Class'BallisticDE.TraceEmitter_Pistol'
     TracerChance=0.600000
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary
     Mesh=SkeletalMesh'BWBPArchivePack1Anim.TP_M9'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.150000
     Skins(0)=Texture'BallisticRecolors4.T9CN.Ber-Main'
     Skins(1)=Texture'BallisticRecolors4.T9CN.Ber-Slide'
     Skins(2)=Texture'BallisticRecolors4.T9CN.Ber-Mag'
}
