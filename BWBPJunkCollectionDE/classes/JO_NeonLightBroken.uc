//=============================================================================
// JO_NeonLightBroken.
//
// The remains of a neon light, smashed over Gorge's melon.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_NeonLightBroken extends JunkObject;

simulated function JunkReload ()
{
	AttachPivot.Yaw = RandRange(-32768, 32768);
//	Weapon.SetBoneRotation(AttachBone, Attachpivot);
}
simulated function bool Initialize(JunkObject OldJunk)
{
	if (JO_NeonLight(OldJunk) != None)
		AttachPivot.Yaw = OldJunk.AttachPivot.Yaw;
	else
		AttachPivot.Yaw = Rand(65536);
	return false;
}

defaultproperties
{
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.NeonLightBrokenLD'
     PickupDrawScale=0.300000
     PickupMessage="You got the Broken Neon Light"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.NeonLightBroken'
     PullOutRate=2.000000
     PutAwayRate=2.000000
     AttachOffset=(Y=-0.100000)
     AttachPivot=(Yaw=673)
     bCanThrow=True
     bSwapSecondary=True
     MaxAmmo=8
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=110.000000,Max=110.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=2000))
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkNeonBroken'
         HookStopFactor=1.200000
         HookPullForce=80.000000
         Damage=(head=82,Limb=17,Misc=32)
         KickForce=5000
         DamageType=Class'BWBPJunkCollectionDE.DTJunkNeonLightStab'
         RefireTime=0.300000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="StabHit1"
         Anims(1)="StabHit2"
         Anims(2)="StabHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBPJunkCollectionDE.JO_NeonLightBroken.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=120.000000,Max=120.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=2000))
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkNeonBrokenSec'
         HookStopFactor=1.200000
         HookPullForce=80.000000
         Damage=(head=105,Limb=20,Misc=40)
         KickForce=10000
         DamageType=Class'BWBPJunkCollectionDE.DTJunkNeonLightStabSec'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="StabAttack"
         PreFireAnims(0)="StabPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBPJunkCollectionDE.JO_NeonLightBroken.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=2000
         ProjMass=10
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.NeonLightBrokenLD'
         ProjScale=0.250000
         SpinRates=(Pitch=650000)
         ExplodeManager=Class'BWBPJunkCollectionDE.IM_JunkNeonLightBreak'
         Damage=(head=85,Limb=17,Misc=40)
         KickForce=12000
         DamageType=Class'BWBPJunkCollectionDE.DTJunkNeonLight'
         RefireTime=0.400000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="StabThrow"
         PreFireAnims(0)="StabPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBPJunkCollectionDE.JO_NeonLightBroken.JunkThrowFireInfo0'

     SelectSound=(Sound=Sound'BWBP_JW_Sound.Misc.Pullout-Glass')
     FriendlyName="Broken Neon Light"
     InventoryGroup=6
     MeleeRating=45.000000
     RangeRating=30.000000
     PainThreshold=15
     NoUseThreshold=20
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.NeonLightBroken'
}
