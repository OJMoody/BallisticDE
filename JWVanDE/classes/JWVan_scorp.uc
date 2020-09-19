//=============================================================================
// Scorpion Blade.
//
// You stole a scorpion's blade? Seriously? Thief.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_scorp extends JunkObject;

defaultproperties
{
     HandOffset=(X=4.000000,Z=-6.000000)
     PickupMesh=StaticMesh'JWVanStatic.scorpLD'
     PickupDrawScale=0.400000
     SpawnOffset=(Z=2.000000)
     PickupMessage="You got the Scorpion Blade. Who needs vehicles anyway?"
     ThirdPersonDrawScale=0.300000
     ThirdPersonMesh=StaticMesh'JWVanStatic.scorp'
     HandStyle=HS_TwoHanded
     RightGripStyle=GS_DualBig
     LeftGripStyle=GS_DualBig
     PullOutRate=1.500000
     PullOutStyle=AS_DualBig
     IdleStyle=AS_DualBig
     PutAwayRate=1.500000
     PutAwayStyle=AS_DualBig
     AttachOffset=(X=5.960000,Z=4.000000)
     AttachPivot=(Yaw=-1500,Roll=-600)
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=215.000000,Max=225.000000)
         SwipeHitWallPoint=6
         SwipePoints(0)=(offset=(Pitch=7000,Yaw=7000))
         SwipePoints(1)=(offset=(Pitch=6000,Yaw=6000))
         SwipePoints(2)=(Weight=2,offset=(Pitch=5000,Yaw=5000))
         SwipePoints(3)=(Weight=4,offset=(Pitch=4000,Yaw=4000))
         SwipePoints(4)=(Weight=6,offset=(Pitch=3000,Yaw=3000))
         SwipePoints(5)=(Weight=8,offset=(Pitch=2000,Yaw=2000))
         SwipePoints(6)=(Weight=10,offset=(Pitch=1000,Yaw=1000))
         SwipePoints(7)=(Weight=12)
         SwipePoints(8)=(Weight=11,offset=(Pitch=-500,Yaw=-1000))
         SwipePoints(9)=(Weight=9,offset=(Pitch=-800,Yaw=-2000))
         SwipePoints(10)=(Weight=7,offset=(Pitch=-1200,Yaw=-3000))
         SwipePoints(11)=(Weight=5,offset=(Pitch=-2400,Yaw=-4000))
         SwipePoints(12)=(Weight=3,offset=(Pitch=-3200,Yaw=-5000))
         SwipePoints(13)=(Weight=1,offset=(Pitch=-4000,Yaw=-6000))
         SwipePoints(14)=(Weight=1,offset=(Pitch=-4800,Yaw=-7000))
         ImpactManager=Class'JunkWarDE.IM_JunkFireAxe'
         HookStopFactor=1.600000
         HookPullForce=100.000000
         Damage=(head=150,Limb=90,Misc=120)
         KickForce=25000
         DamageType=Class'JWVanDE.DTscorp'
         RefireTime=1.100000
         AnimRate=1.400000
         Sound=(Sound=SoundGroup'JunkWarSounds.Conpole.Conpole-Swing',Pitch=1.200000)
         Anims(0)="Big2Hit1"
         Anims(1)="Big2Hit2"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
         bAnimTimedSound=True
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_scorp.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=215.000000,Max=225.000000)
         SwipeHitWallPoint=6
         SwipePoints(0)=(Weight=14,offset=(Pitch=8500,Yaw=2400))
         SwipePoints(1)=(Weight=13,offset=(Pitch=8000,Yaw=2000))
         SwipePoints(2)=(Weight=12,offset=(Pitch=6500,Yaw=1600))
         SwipePoints(3)=(Weight=11,offset=(Pitch=5000,Yaw=1200))
         SwipePoints(4)=(Weight=10,offset=(Pitch=4000,Yaw=800))
         SwipePoints(5)=(Weight=9,offset=(Pitch=3000,Yaw=500))
         SwipePoints(6)=(Weight=8,offset=(Pitch=2000,Yaw=250))
         SwipePoints(7)=(Weight=7)
         SwipePoints(8)=(Weight=6,offset=(Pitch=-1000,Yaw=-250))
         SwipePoints(9)=(Weight=5,offset=(Pitch=-2000,Yaw=-500))
         SwipePoints(10)=(Weight=4,offset=(Pitch=-3000,Yaw=-800))
         SwipePoints(11)=(Weight=3,offset=(Pitch=-4000,Yaw=-1200))
         SwipePoints(12)=(Weight=2,offset=(Pitch=-5500,Yaw=-1600))
         SwipePoints(13)=(Weight=1,offset=(Pitch=-7000,Yaw=-2000))
         SwipePoints(14)=(offset=(Pitch=-8500000,Yaw=-2400))
         ImpactManager=Class'JunkWarDE.IM_JunkFireAxe'
         HookStopFactor=1.600000
         HookPullForce=120.000000
         Damage=(head=250,Limb=100,Misc=130)
         KickForce=35000
         DamageType=Class'JWVanDE.DTscorp'
         RefireTime=1.250000
         AnimRate=1.350000
         Sound=(Sound=SoundGroup'JunkWarSounds.Conpole.Conpole-Swing',Pitch=1.100000)
         Anims(0)="Big2Attack1"
         Anims(1)="Big2Attack2"
         PreFireAnims(0)="Big2PrepAttack1"
         PreFireAnims(1)="Big2PrepAttack2"
         AnimStyle=ACS_Random
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_scorp.JunkFireInfo1'

     SelectSound=(Sound=SoundGroup'JunkWarSounds.Misc.Pullout-Heavy')
     FriendlyName="Scorpion Blade"
     InventoryGroup=5
     MeleeRating=150.000000
     RangeRating=0.000000
     SpawnWeight=0.900000
     bDisallowShield=True
     PainThreshold=80
     NoUseThreshold=150
     BlockLeftAnim="Big2BlockLeft"
     BlockRightAnim="Big2BlockRight"
     BlockStartAnim="Big2PrepBlock"
     BlockEndAnim="Big2EndBlock"
     BlockIdleAnim="Big2BlockIdle"
     StaticMesh=StaticMesh'JWVanStatic.scorp'
     DrawScale=0.800000
}
