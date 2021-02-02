//=============================================================================
// Blade.
//
// An igniting sowrd.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_blade extends JunkObject;

defaultproperties
{
     HandOffset=(X=4.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.bladeLD'
     PickupDrawScale=0.400000
     SpawnPivot=(Pitch=768)
     SpawnOffset=(Z=2.000000)
     PickupMessage="You found the Blazing Blade. Hot stuff!"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.blade'
     HandStyle=HS_TwoHanded
     RightGripStyle=GS_DualAverage
     LeftGripStyle=GS_DualAverage
     PullOutRate=1.500000
     PullOutStyle=AS_DualAverage
     IdleStyle=AS_DualAverage
     PutAwayRate=1.500000
     PutAwayStyle=AS_DualAverage
     AttachOffset=(Z=7.000000)
     AttachPivot=(Yaw=-2048)
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=196.000000,Max=196.000000)
         SwipeHitWallPoint=6
         SwipePoints(0)=(offset=(Pitch=6000,Yaw=6000))
         SwipePoints(1)=(Weight=2,offset=(Pitch=5000,Yaw=5000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=4000,Yaw=4000))
         SwipePoints(3)=(Weight=6,offset=(Pitch=3000,Yaw=3000))
         SwipePoints(4)=(Weight=8,offset=(Pitch=2000,Yaw=2000))
         SwipePoints(5)=(Weight=10,offset=(Pitch=1000,Yaw=1000))
         SwipePoints(6)=(Weight=12)
         SwipePoints(7)=(Weight=11,offset=(Pitch=-500,Yaw=-1000))
         SwipePoints(8)=(Weight=9,offset=(Pitch=-800,Yaw=-2000))
         SwipePoints(9)=(Weight=7,offset=(Pitch=-1200,Yaw=-3000))
         SwipePoints(10)=(Weight=5,offset=(Pitch=-2400,Yaw=-4000))
         SwipePoints(11)=(Weight=3,offset=(Pitch=-3200,Yaw=-5000))
         SwipePoints(12)=(Weight=1,offset=(Pitch=-4000,Yaw=-6000))
         ImpactManager=Class'BWBPJunkCollectionDE.IM_claymore'
         HookStopFactor=1.000000
         Damage=(head=200,Limb=70,Misc=50)
         KickForce=12000
         DamageType=Class'BWBPJunkCollectionDE.DTblade'
         RefireTime=0.650000
         AnimRate=1.200000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing',Pitch=1.200000)
         Anims(0)="Avg2Hit1"
         Anims(1)="Avg2Hit2"
         Anims(2)="Avg2Hit3"
         AnimTimedFire=ATS_Early
         bAnimTimedSound=True
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBPJunkCollectionDE.JWVan_blade.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=185.000000,Max=185.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=7,offset=(Pitch=6000,Yaw=8000))
         SwipePoints(1)=(Weight=6,offset=(Pitch=4500,Yaw=6000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=3000,Yaw=4000))
         SwipePoints(3)=(Weight=4,offset=(Pitch=1500,Yaw=2000))
         SwipePoints(4)=(Weight=3)
         SwipePoints(5)=(Weight=2,offset=(Pitch=-1500,Yaw=-2000))
         SwipePoints(6)=(Weight=1,offset=(Pitch=-3000,Yaw=-4000))
         SwipePoints(7)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBPJunkCollectionDE.IM_claymore'
         HookStopFactor=1.000000
         Damage=(head=250,Limb=120,Misc=90)
         KickForce=35000
         DamageType=Class'BWBPJunkCollectionDE.DTblade'
         RefireTime=0.800000
         AnimRate=1.350000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing',Pitch=1.200000)
         Anims(0)="Avg2Attack"
         PreFireAnims(0)="Avg2PrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Early
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBPJunkCollectionDE.JWVan_blade.JunkFireInfo1'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Blazing Blade"
     InventoryGroup=4
     MeleeRating=95.000000
     RangeRating=0.000000
     bDisallowShield=True
     PainThreshold=60
     NoUseThreshold=90
     BlockLeftAnim="Avg2BlockLeft"
     BlockRightAnim="Avg2BlockRight"
     BlockStartAnim="Avg2PrepBlock"
     BlockEndAnim="Avg2EndBlock"
     BlockIdleAnim="Avg2BlockIdle"
     StaticMesh=StaticMesh'BWBP_JW_Static.blade'
     DrawScale=0.700000
}
