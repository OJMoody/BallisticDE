//=============================================================================
// SARAttachment.
//
// 3rd person weapon attachment for SAR Assault
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class CommandoAttachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticDE.XK2FlashEmitter'
     ImpactManager=Class'BallisticDE.IM_Bullet'
     FlashScale=2.000000
     BrassClass=Class'BallisticDE.Brass_SAR'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BallisticDE.TraceEmitter_Default'
     TracerMix=-3
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims3.SAR-3rd'
     DrawScale=0.100000
}
