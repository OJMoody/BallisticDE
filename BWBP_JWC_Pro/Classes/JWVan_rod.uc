//=============================================================================
// Rod.
//
// Immersion Heater.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_rod extends JunkObject;

//Wall hit effects
function bool SendFireEffect(WeaponFire Fire, JunkFireInfo FI, Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
 local Actor Victims;
 local float dist;
 local vector dir;

 if( bHurtEntry ) //not handled well...
  return false;

 bHurtEntry = true;
 
 foreach VisibleCollidingActors( class 'Actor', Victims, 32, HitLocation)
 {
  // don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
  if( (Victims != self) && (Victims != Owner))
  {
   dir = Victims.Location - Location;
   dist = FMax(1,VSize(dir));
   dir = dir/dist;
   class'BallisticDamageType'.static.GenericHurt
   (
    Victims,
    5,
    Instigator,
    Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
    vect(0,0,0),
    class'DTrod'
   );
  }
 }
 bHurtEntry = false;
 
 return false;
}

defaultproperties
{
     HandOffset=(X=2.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.rodLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Immersion Heater. Make some tea out of your enemies!"
     ThirdPersonDrawScale=0.120000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Rod'
     RightGripStyle=GS_Crowbar
     AttachOffset=(Y=0.250000)
     AttachPivot=(Yaw=-1000,Roll=-500)
     bCanThrow=True
     MaxAmmo=3
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=100.000000,Max=100.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkGearLever'
         Damage=(head=60,Limb=15,Misc=30)
         KickForce=3000
         DamageType=Class'BWBP_JWC_Pro.DTrod'
         RefireTime=0.500000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing',Pitch=1.200000)
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_rod.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=105.000000,Max=105.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=5000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3500))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-2000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3500))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkGearLever'
         Damage=(head=90,Limb=25,Misc=45)
         KickForce=5000
         DamageType=Class'BWBP_JWC_Pro.DTrod'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing',Pitch=1.100000)
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_rod.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1500
         ProjMass=20
         ProjMesh=StaticMesh'BWBP_JW_Static.rodLD'
         ProjScale=0.250000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         DampenFactor=0.250000
         SpinRates=(Pitch=650000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkGearLever'
         StickRotation=(Pitch=16384,Roll=16384)
         bCanBePickedUp=True
         Damage=(head=60,Limb=25,Misc=35)
         KickForce=5000
         DamageType=Class'BWBP_JWC_Pro.DTrod'
         RefireTime=0.400000
         AnimRate=1.000000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing',Pitch=1.200000)
         Anims(0)="LightThrow"
         PreFireAnims(0)="LightPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JWVan_rod.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Immersion Heater"
     MeleeRating=30.000000
     RangeRating=18.000000
     PainThreshold=10
     NoUseThreshold=25
     StaticMesh=StaticMesh'BWBP_JW_Static.Rod'
     DrawScale=1.250000
}
