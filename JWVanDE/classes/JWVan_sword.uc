//=============================================================================
// JO_Sword.
//
// A medieval sword. It may be rusty but it's still enough to cut off your limbs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_sword extends JunkObject;

defaultproperties
{
     HandOffset=(X=4.000000,Y=2.000000,Z=-2.000000)
     PickupMesh=StaticMesh'JWVanStatic.swordLD'
     PickupDrawScale=0.400000
     PickupMessage="You got a medieval sword."
     ThirdPersonDrawScale=0.300000
     ThirdPersonMesh=StaticMesh'JWVanStatic.sword'
     RightGripStyle=GS_Axe
     AttachOffset=(Y=0.250000)
     AttachPivot=(Yaw=-2048,Roll=-500)
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'JunkWarDE.IM_JunkMachete'
         HookStopFactor=0.700000
         HookPullForce=90.000000
         Damage=(head=100,Limb=20,Misc=40)
         KickForce=5000
         DamageType=Class'JWVanDE.DTsword'
         RefireTime=0.700000
         AnimRate=1.100000
         Sound=(Sound=SoundGroup'JunkWarSounds.Icepick.Icepick-Swing',Pitch=1.200000)
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_sword.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'JunkWarDE.IM_JunkMachete'
         HookStopFactor=0.700000
         HookPullForce=90.000000
         Damage=(head=110,Limb=20,Misc=50)
         KickForce=9000
         DamageType=Class'JWVanDE.DTsword'
         RefireTime=0.900000
         AnimRate=0.900000
         Sound=(Sound=SoundGroup'JunkWarSounds.Icepick.Icepick-Swing',Pitch=1.100000)
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_sword.JunkFireInfo1'

     SelectSound=(Sound=SoundGroup'JunkWarSounds.Misc.Pullout-Avg')
     FriendlyName="Medieval Sword"
     MeleeRating=60.000000
     RangeRating=25.000000
     PainThreshold=25
     NoUseThreshold=45
     StaticMesh=StaticMesh'JWVanStatic.sword'
     DrawScale=2.000000
}
