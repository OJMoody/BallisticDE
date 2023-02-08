//=============================================================================
// SMATAttachment.
//
// 3rd person weapon attachment for SMAT Bazooka
//
// by SK
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SMATAttachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     AltFlashBone="tip2"
     FlashScale=1.200000
     BrassMode=MU_None
     InstantMode=MU_None
     bRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.G5Bazooka_TPm'
     DrawScale=0.230000
}
