//=============================================================================
// JO_HandAxe.
//
// A one-handed wood axe.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_HandAxe extends JunkObject;

defaultproperties
{
     HandOffset=(X=2.000000,Y=2.000000,Z=-1.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.AxeLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Hand Axe"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.Axe'
     RightGripStyle=GS_Axe
     AttachOffset=(Z=2.000000)
     AttachPivot=(Yaw=-2648,Roll=-500)
     bCanThrow=True
     MaxAmmo=3
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=145.000000,Max=145.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkAxe'
         HookStopFactor=1.400000
         HookPullForce=80.000000
         Damage=(head=90,Limb=17,Misc=37)
         KickForce=7000
         DamageType=Class'BWBPJunkCollectionDE.DTJunkAxe'
         RefireTime=0.600000
         AnimRate=1.200000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing',Pitch=1.100000)
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBPJunkCollectionDE.JO_HandAxe.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=150.000000,Max=150.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkAxe'
         HookStopFactor=1.400000
         HookPullForce=80.000000
         Damage=(head=110,Limb=22,Misc=50)
         KickForce=12000
         DamageType=Class'BWBPJunkCollectionDE.DTJunkAxe'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing',Pitch=1.100000)
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Early
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBPJunkCollectionDE.JO_HandAxe.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1500
         ProjMass=20
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.AxeLD'
         ProjScale=0.250000
         WallImpactType=IT_Stick
         ActorImpactType=IT_Stick
         DampenFactor=0.200000
         SpinRates=(Pitch=650000)
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkAxe'
         StickRotation=(Pitch=8192)
         bCanBePickedUp=True
         Damage=(head=110,Limb=20,Misc=40)
         KickForce=15000
         DamageType=Class'BWBPJunkCollectionDE.DTJunkAxe'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing',Pitch=1.100000)
         Anims(0)="HeavyThrow"
         PreFireAnims(0)="HeavyPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBPJunkCollectionDE.JO_HandAxe.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Hand Axe"
     MeleeRating=65.000000
     RangeRating=35.000000
     PainThreshold=36
     NoUseThreshold=65
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.Axe'
     DrawScale=1.500000
}
