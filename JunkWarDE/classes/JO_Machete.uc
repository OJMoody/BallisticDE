//=============================================================================
// JO_Machete.
//
// A crude blade for clearing bush and shaving tough beards.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_Machete extends JunkObject;

defaultproperties
{
     HandOffset=(X=4.000000,Y=2.000000,Z=-2.000000)
     PickupMesh=StaticMesh'JunkWarHardware.Junk.MacheteLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Machete"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'JunkWarHardware.Junk.Machete'
     RightGripStyle=GS_Axe
     AttachOffset=(Y=0.250000)
     AttachPivot=(Yaw=-2048,Roll=-500)
     bCanThrow=True
     MaxAmmo=3
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
         Damage=(head=87,Limb=15,Misc=32)
         KickForce=5000
         DamageType=Class'JunkWarDE.DTJunkMachete'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'JunkWarSounds.Icepick.Icepick-Swing',Pitch=1.200000)
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'JunkWarDE.JO_Machete.JunkFireInfo0'

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
         Damage=(head=100,Limb=17,Misc=40)
         KickForce=9000
         DamageType=Class'JunkWarDE.DTJunkMachete'
         RefireTime=0.500000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'JunkWarSounds.Icepick.Icepick-Swing',Pitch=1.100000)
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'JunkWarDE.JO_Machete.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1500
         ProjMass=20
         ProjMesh=StaticMesh'JunkWarHardware.Junk.MacheteLD'
         ProjScale=0.400000
         WallImpactType=IT_Stick
         ActorImpactType=IT_Stick
         DampenFactor=0.200000
         SpinRates=(Pitch=650000)
         ImpactManager=Class'JunkWarDE.IM_JunkMachete'
         StickRotation=(Pitch=10000)
         bCanBePickedUp=True
         Damage=(head=80,Limb=22,Misc=35)
         KickForce=12000
         DamageType=Class'JunkWarDE.DTJunkMachete'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'JunkWarSounds.Icepick.Icepick-Swing',Pitch=1.200000)
         Anims(0)="AvgThrow"
         PreFireAnims(0)="AvgPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'JunkWarDE.JO_Machete.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'JunkWarSounds.Misc.Pullout-Avg')
     FriendlyName="Machete"
     MeleeRating=60.000000
     RangeRating=25.000000
     PainThreshold=25
     NoUseThreshold=45
     StaticMesh=StaticMesh'JunkWarHardware.Junk.Machete'
     DrawScale=2.000000
}
