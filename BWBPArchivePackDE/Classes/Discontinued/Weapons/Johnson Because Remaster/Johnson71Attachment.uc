//=============================================================================
// SK410Attachment.
//
// 3rd person weapon attachment for SK410 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Johnson71Attachment extends BallisticShotgunAttachment;

defaultproperties
{
     FireClass=Class'BWBPArchivePackDE.Johnson71PrimaryFire'
     ImpactManager=Class'BWBPArchivePackDE.IM_FlareExplode'
     FlashScale=1.800000
     BrassClass=Class'BWBPArchivePackDE.Brass_Johnson71'
     TracerClass=Class'BWBPArchivePackDE.TraceEmitter_Johnson71'
     TracerChance=0.500000
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.900000
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.SK410Third'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.200000
     PrePivot=(X=1.000000,Z=-5.000000)
}
