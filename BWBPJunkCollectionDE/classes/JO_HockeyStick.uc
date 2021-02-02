//=============================================================================
// JO_HockeyStick.
//
// A piece of sporting equipment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_HockeyStick extends JunkObject;

defaultproperties
{
     HandOffset=(X=4.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.HockeyStickLD'
     PickupDrawScale=0.400000
     SpawnPivot=(Pitch=768)
     SpawnOffset=(Z=2.000000)
     PickupMessage="You got the Hockey Stick"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.HockeyStick'
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
         MeleeRange=(Min=180.000000,Max=180.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkHockey'
         HookStopFactor=1.000000
         Damage=(head=92,Limb=20,Misc=42)
         KickForce=12000
         DamageType=Class'BWBPJunkCollectionDE.DTJunkHockeyStick'
         RefireTime=0.750000
         AnimRate=1.200000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing',Pitch=1.200000)
         Anims(0)="Avg2Hit1"
         Anims(1)="Avg2Hit2"
         Anims(2)="Avg2Hit3"
         AnimTimedFire=ATS_Timed
         bAnimTimedSound=True
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBPJunkCollectionDE.JO_HockeyStick.JunkFireInfo0'

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
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkHockey'
         HookStopFactor=1.000000
         Damage=(head=110,Limb=27,Misc=50)
         KickForce=35000
         DamageType=Class'BWBPJunkCollectionDE.DTJunkHockeyStick'
         RefireTime=0.800000
         AnimRate=1.350000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing',Pitch=1.200000)
         Anims(0)="Avg2Attack"
         PreFireAnims(0)="Avg2PrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBPJunkCollectionDE.JO_HockeyStick.JunkFireInfo1'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Hockey Stick"
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
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.HockeyStick'
     DrawScale=0.700000
}
