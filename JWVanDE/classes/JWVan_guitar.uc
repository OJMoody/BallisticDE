//=============================================================================
// JWVan_Guitar.
//
// DIN DANG DING DIIIING SMOOOKE ON THE WAAATER.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_guitar extends JunkObject;

defaultproperties
{
     HandOffset=(X=6.000000,Z=-2.000000)
     PickupMesh=StaticMesh'JWVanStatic.guitarLD'
     PickupDrawScale=0.400000
     SpawnPivot=(Pitch=768)
     SpawnOffset=(Z=2.000000)
     PickupMessage="You found an Electric Guitar. Go, cover Deep Purple!"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'JWVanStatic.guitar'
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
         ImpactManager=Class'JunkWarDE.IM_JunkTwoByFour'
         HookStopFactor=1.000000
         Damage=(head=110,Limb=25,Misc=50)
         KickForce=12000
         DamageType=Class'JWVanDE.DTguitar'
         RefireTime=0.800000
         AnimRate=1.200000
         Sound=(Sound=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Swing',Pitch=1.200000)
         Anims(0)="Avg2Hit1"
         Anims(1)="Avg2Hit2"
         Anims(2)="Avg2Hit3"
         AnimTimedFire=ATS_Timed
         bAnimTimedSound=True
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_guitar.JunkFireInfo0'

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
         ImpactManager=Class'JunkWarDE.IM_JunkTwoByFour'
         HookStopFactor=1.000000
         Damage=(head=125,Limb=35,Misc=60)
         KickForce=35000
         DamageType=Class'JWVanDE.DTguitar'
         RefireTime=0.800000
         AnimRate=1.350000
         Sound=(Sound=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Swing',Pitch=1.200000)
         Anims(0)="Avg2Attack"
         PreFireAnims(0)="Avg2PrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_guitar.JunkFireInfo1'

     SelectSound=(Sound=SoundGroup'JunkWarSounds.Misc.Pullout-Avg')
     FriendlyName="Electric Guitar"
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
     StaticMesh=StaticMesh'JWVanStatic.guitar'
     DrawScale=0.700000
}
