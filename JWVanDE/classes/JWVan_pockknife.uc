//=============================================================================
// Pocket Knife.
//
// Survivalist stuff
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_pockknife extends JunkObject;

defaultproperties
{
     HandOffset=(X=5.000000,Y=2.000000,Z=-2.000000)
     PickupMesh=StaticMesh'JWVanStatic.pockknifeLD'
     PickupDrawScale=0.400000
     PickupMessage="You found a Pocket Knife. Your survival is guaranteed!"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'JWVanStatic.pockknife'
     RightGripStyle=GS_Crowbar
     AttachOffset=(X=-0.250000,Y=-0.500000,Z=6.000000)
     AttachPivot=(Yaw=-2048,Roll=-500)
     bCanThrow=True
     Ammo=3
     MaxAmmo=10
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
         ImpactManager=Class'JunkWarDE.IM_JunkMachete'
         HookStopFactor=1.600000
         HookPullForce=100.000000
         Damage=(head=55,Limb=18,Misc=30)
         KickForce=7000
         DamageType=Class'JWVanDE.DTpockknife'
         RefireTime=0.380000
         AnimRate=1.150000
         Sound=(Sound=SoundGroup'JunkWarSounds.Crowbar.Crowbar-Swing')
         Anims(0)="AvgHit1"
         Anims(1)="StabHit1"
         Anims(2)="AvgHit2"
         Anims(3)="StabHit2"
         Anims(4)="AvgHit3"
         Anims(5)="StabHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_pockknife.JunkFireInfo0'

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
         ImpactManager=Class'JunkWarDE.IM_JunkMachete'
         HookStopFactor=1.600000
         HookPullForce=100.000000
         Damage=(head=65,Limb=28,Misc=32)
         KickForce=12000
         DamageType=Class'JWVanDE.DTpockknife'
         RefireTime=0.750000
         AnimRate=1.230000
         Sound=(Sound=SoundGroup'JunkWarSounds.Crowbar.Crowbar-Swing')
         Anims(0)="WideAttack"
         Anims(1)="StabAttack"
         PreFireAnims(0)="WidePrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'JWVanDE.JWVan_pockknife.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=2000
         ProjMass=15
         ProjMesh=StaticMesh'JWVanStatic.pockknifeLD'
         ProjScale=0.250000
         WallImpactType=IT_Stick
         ActorImpactType=IT_Stick
         DampenFactor=0.200000
         SpinRates=(Pitch=650000)
         ImpactManager=Class'JunkWarDE.IM_JunkMachete'
         StickRotation=(Pitch=8192)
         bCanBePickedUp=True
         Damage=(head=100,Limb=45,Misc=60)
         KickForce=15000
         DamageType=Class'JWVanDE.DTpockknife'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'JunkWarSounds.Crowbar.Crowbar-Swing',Pitch=1.100000)
         Anims(0)="LightThrow"
         PreFireAnims(0)="LightPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'JWVanDE.JWVan_pockknife.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'JunkWarSounds.Misc.Pullout-Avg')
     FriendlyName="Pocket Knife"
     MeleeRating=65.000000
     RangeRating=25.000000
     NoUseThreshold=80
     StaticMesh=StaticMesh'JWVanStatic.pockknife'
     DrawScale=1.560000
}
