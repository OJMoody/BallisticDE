//=============================================================================
// EKS43Attachment.
//
// Attachment for EKS43 sword.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ChainsawAttachment extends BallisticMeleeAttachment;

defaultproperties
{
	 IdleHeavyAnim="TwoHand_Idle"
     IdleRifleAnim="TwoHand_Idle"
	 MeleeStrikeAnim="TwoHand_Slam"
	 MeleeAltStrikeAnim="TwoHand_StabSaw"
	 MeleeBlockAnim="TwoHand_Block"
     ImpactManager=Class'IM_DarkStarSaw'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     Mesh=SkeletalMesh'BWBPSomeOtherPackAnims.ChainsawLongsword_third'
     DrawScale=0.200000
	 RelativeRotation=(Pitch=32768,Yaw=32768)
}
