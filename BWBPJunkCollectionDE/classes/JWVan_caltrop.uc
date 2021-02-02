//=============================================================================
// Caltrop
//
// si senor
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_caltrop extends JunkObject;

defaultproperties
{
     HandOffset=(X=3.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.caltrop'
     PickupDrawScale=0.600000
     PickupMessage="You got some caltrops. Old school mines."
     ThirdPersonDrawScale=0.450000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.caltrop'
     RightGripStyle=GS_Thin
     PullOutRate=2.000000
     PutAwayRate=2.000000
     AttachOffset=(Z=3.300000)
     AttachPivot=(Roll=-1000)
     bCanThrow=True
     bSwapSecondary=True
     Ammo=10
     MaxAmmo=20
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=100.000000,Max=100.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Pitch=500,Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Pitch=-500,Yaw=-2000))
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkScrewDriver'
         HookStopFactor=1.500000
         HookPullForce=90.000000
         Damage=(head=95,Limb=25,Misc=30)
         KickForce=2000
         DamageType=Class'BWBPJunkCollectionDE.DTcaltrop'
         RefireTime=0.250000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="StabHit1"
         Anims(1)="StabHit2"
         Anims(2)="StabHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBPJunkCollectionDE.JWVan_caltrop.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=110.000000,Max=110.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Pitch=500,Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Pitch=-1000,Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Pitch=-2000,Yaw=-2000))
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkScrewDriverSec'
         HookStopFactor=1.500000
         HookPullForce=90.000000
         Damage=(head=100,Limb=28,Misc=35)
         KickForce=3000
         DamageType=Class'BWBPJunkCollectionDE.DTcaltrop'
         RefireTime=0.350000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="StabAttack"
         PreFireAnims(0)="StabPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBPJunkCollectionDE.JWVan_caltrop.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         ProjectileClass=Class'BWBPJunkCollectionDE.Proj_Caltrop'
         projSpeed=2000
         ProjMass=15
         ProjMesh=StaticMesh'BWBP_JW_Static.caltrop'
         ProjScale=0.250000
         WallImpactType=IT_Stick
         ActorImpactType=IT_Stick
         SpinRates=(Pitch=30000)
         ImpactManager=Class'BWBPJunkCollectionDE.IM_JunkScrewDriver'
         bCanBePickedUp=True
         Damage=(head=20,Limb=15,Misc=10)
         KickForce=2000
         DamageType=Class'BWBPJunkCollectionDE.DTcaltrop'
         RefireTime=0.300000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="StabThrow"
         PreFireAnims(0)="StabPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBPJunkCollectionDE.JWVan_caltrop.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Small')
     FriendlyName="Caltrop"
     InventoryGroup=3
     MeleeRating=45.000000
     RangeRating=40.000000
     SpawnWeight=1.050000
     PainThreshold=12
     NoUseThreshold=20
     StaticMesh=StaticMesh'BWBP_JW_Static.caltrop'
     DrawScale=1.650000
}
