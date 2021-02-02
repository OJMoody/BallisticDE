//=============================================================================
// JO_ClawHammer.
//
// A standard claw-hammer used primarily for beating in nails, fingers, and Jugg heads.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_ClawHammer extends JunkObject;

simulated function JunkReload()
//simulated function bool HitActor (Actor Other, JunkMeleeFireInfo FireInfo)
{
	if (FRand() > 0.5)
	{
		AttachPivot.Yaw = default.AttachPivot.Yaw + 32768;
		AttachPivot.Roll = default.AttachPivot.Roll * -1;
	}
	else
	{
		AttachPivot.Yaw = default.AttachPivot.Yaw;
		AttachPivot.Roll = default.AttachPivot.Roll;
//	Weapon.SetBoneRotation(AttachBone, Attachpivot);
	}
}

defaultproperties
{
     HandOffset=(X=4.000000,Y=2.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.ClawHammerLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Claw Hammer, go crack some heads."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.ClawHammer'
     AttachOffset=(X=0.500000,Y=-0.250000,Z=2.000000)
     AttachPivot=(Yaw=-2048)
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
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkClawHammer'
         HookStopFactor=1.000000
         Damage=(head=85,Limb=15,Misc=27)
         KickForce=5000
         DamageType=Class'BWBPJunkCollectionDE.DTJunkClawHammer'
         RefireTime=0.450000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing')
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBPJunkCollectionDE.JO_ClawHammer.JunkFireInfo0'

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
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkClawHammer'
         HookStopFactor=1.000000
         Damage=(head=95,Limb=20,Misc=32)
         KickForce=10000
         DamageType=Class'BWBPJunkCollectionDE.DTJunkClawHammer'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing')
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBPJunkCollectionDE.JO_ClawHammer.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1500
         ProjMass=20
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.ClawHammerLD'
         ProjScale=0.250000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         DampenFactor=0.200000
         SpinRates=(Pitch=650000)
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkClawHammer'
         StickRotation=(Pitch=16384,Roll=16384)
         bCanBePickedUp=True
         Damage=(head=77,Limb=20,Misc=40)
         KickForce=15000
         DamageType=Class'BWBPJunkCollectionDE.DTJunkClawHammer'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing')
         Anims(0)="HeavyThrow"
         PreFireAnims(0)="HeavyPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBPJunkCollectionDE.JO_ClawHammer.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Claw Hammer"
     MeleeRating=55.000000
     RangeRating=20.000000
     PainThreshold=35
     NoUseThreshold=60
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.ClawHammer'
     DrawScale=1.400000
}
