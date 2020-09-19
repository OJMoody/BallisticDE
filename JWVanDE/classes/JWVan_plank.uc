//=============================================================================
// plank.
//
// plank. 
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_plank extends JunkObject;

defaultproperties
{
     HandOffset=(X=4.000000,Z=-2.000000)
     PickupMesh=StaticMesh'JWVanStatic.plankLD'
     PickupDrawScale=0.350000
     PickupMessage="You got the Spiked Plank. Perfect for smashing faces."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'JWVanStatic.Plank'
     HandStyle=HS_TwoHanded
     RightGripStyle=GS_DualAverage
     LeftGripStyle=GS_DualAverage
     PullOutRate=1.500000
     PullOutStyle=AS_DualAverage
     IdleStyle=AS_DualAverage
     PutAwayRate=1.500000
     PutAwayStyle=AS_DualAverage
     AttachOffset=(Z=4.000000)
     AttachPivot=(Yaw=-10000)
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=170.000000,Max=170.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'JunkWarDE.IM_JunkTwoByFour'
         HookStopFactor=1.000000
         Damage=(head=110,Limb=35,Misc=45)
         KickForce=9000
         DamageType=Class'JWVanDE.DTplank'
         RefireTime=0.500000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Swing')
         Anims(0)="Avg2Hit1"
         Anims(1)="Avg2Hit2"
         Anims(2)="Avg2Hit3"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
         bAnimTimedSound=True
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_plank.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=175.000000,Max=175.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'JunkWarDE.IM_JunkTwoByFour'
         HookStopFactor=1.100000
         Damage=(head=135,Limb=30,Misc=60)
         KickForce=12000
         DamageType=Class'JWVanDE.DTplank'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Swing')
         Anims(0)="Avg2Attack"
         PreFireAnims(0)="Avg2PrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_plank.JunkFireInfo1'

     FriendlyName="Spiked Plank"
     InventoryGroup=4
     MeleeRating=100.000000
     RangeRating=0.000000
     bDisallowShield=True
     PainThreshold=75
     NoUseThreshold=150
     BlockLeftAnim="Avg2BlockLeft"
     BlockRightAnim="Avg2BlockRight"
     BlockStartAnim="Avg2PrepBlock"
     BlockEndAnim="Avg2EndBlock"
     BlockIdleAnim="Avg2BlockIdle"
     StaticMesh=StaticMesh'JWVanStatic.Plank'
     DrawScale=0.800000
}
