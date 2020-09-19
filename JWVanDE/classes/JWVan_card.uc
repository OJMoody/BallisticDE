//=============================================================================
// Card.
//
// mowmow.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_card extends JunkObject;

defaultproperties
{
     HandOffset=(X=3.000000,Z=-1.000000)
     PickupMesh=StaticMesh'JWVanStatic.cardLD'
     PickupDrawScale=0.400000
     PickupMessage="You found some Throwing Cards. Let's play some Mau Mau."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'JWVanStatic.card'
     RightGripStyle=GS_Thin
     PullOutRate=2.000000
     PutAwayRate=2.000000
     AttachOffset=(Z=4.200000)
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
         ImpactManager=Class'JunkWarDE.IM_JunkScrewDriver'
         HookStopFactor=1.500000
         HookPullForce=90.000000
         Damage=(head=85,Limb=30,Misc=65)
         KickForce=2000
         DamageType=Class'JWVanDE.DTcard'
         RefireTime=0.250000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'JunkWarSounds.Spanner.Spanner-Swing')
         Anims(0)="StabHit1"
         Anims(1)="StabHit2"
         Anims(2)="StabHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_card.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=110.000000,Max=110.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Pitch=500,Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Pitch=-1000,Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Pitch=-2000,Yaw=-2000))
         ImpactManager=Class'JunkWarDE.IM_JunkScrewDriverSec'
         HookStopFactor=1.500000
         HookPullForce=90.000000
         Damage=(head=90,Limb=40,Misc=35)
         KickForce=3000
         DamageType=Class'JWVanDE.DTcard'
         RefireTime=0.350000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'JunkWarSounds.Spanner.Spanner-Swing')
         Anims(0)="StabAttack"
         PreFireAnims(0)="StabPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_card.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=2200
         ProjMass=20
         ProjMesh=StaticMesh'JWVanStatic.cardLD'
         ProjScale=0.250000
         WallImpactType=IT_Stick
         ActorImpactType=IT_Stick
         SpinRates=(Pitch=900000)
         ImpactManager=Class'JunkWarDE.IM_JunkSpanner'
         bCanBePickedUp=True
         Damage=(head=95,Limb=25,Misc=45)
         KickForce=2500
         DamageType=Class'JWVanDE.DTcard'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'JunkWarSounds.Spanner.Spanner-Swing')
         Anims(0)="AvgThrow"
         PreFireAnims(0)="AvgPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'JWVanDE.JWVan_card.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'JunkWarSounds.Misc.Pullout-Small')
     FriendlyName="Throwing Card"
     InventoryGroup=3
     MeleeRating=45.000000
     RangeRating=40.000000
     SpawnWeight=1.050000
     PainThreshold=12
     NoUseThreshold=20
     StaticMesh=StaticMesh'JWVanStatic.card'
     DrawScale=1.650000
}
