//=============================================================================
// A42Attachment.
//
// 3rd person weapon attachment for A42 Skrith Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A85Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BWBPArchivePackDE.A85FlashEmitter'
     AltMuzzleFlashClass=Class'BWBPArchivePackDE.A85FlashEmitter'
     ImpactManager=Class'BallisticDE.IM_A42Projectile'
     BrassMode=MU_None
     TracerMode=MU_None
     InstantMode=MU_None
     FlashMode=MU_Both
     LightMode=MU_Both
     bRapidFire=True
     Mesh=SkeletalMesh'BWSkrithRecolors1Anim.SkrithShotgun-3rd'
}
