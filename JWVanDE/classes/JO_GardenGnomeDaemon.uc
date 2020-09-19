//=============================================================================
// JO_EmptyCapacitor.
//
// A discharged capacitor bearing only blunt force damage capabilities.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_GardenGnomeDaemon extends JunkObject;

var Emitter DaemonEffect;

simulated function PostInitialize (Actor JunkActor)
{
	if (JunkActor == None)
		return;
	if (DaemonEffect == None)
	{
		DaemonEffect = JunkActor.Spawn(class'Effect_DaemonGnome',JunkActor,,JunkActor.Location, JunkActor.Rotation);
		class'BallisticEmitter'.static.ScaleEmitter(DaemonEffect, DrawScale*Weapon.DrawScale);
	}
	DaemonEffect.SetBase(JunkActor);
}
simulated function Uninitialize(JunkObject NewJunk)
{
	if (DaemonEffect != None)
		DaemonEffect.Destroy();
	DaemonEffect = None;
}

defaultproperties
{
     PickupMesh=StaticMesh'JWBPXav-HW.Weapons.GnomeDaemon_Ground'
     PickupDrawScale=0.400000
     SpawnPivot=(Roll=0)
     PickupMessage="You got a Gruesome Gnome."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'JWBPXav-HW.Weapons.GnomeDaemon'
     RightGripStyle=GS_Capacitor
     AttachOffset=(Y=-2.500000)
     AttachPivot=(Pitch=-2048)
     bCanThrow=True
     MaxAmmo=3
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=-2000))
         ImpactManager=Class'JunkWarDE.IM_JunkClubHammer'
         Damage=(head=74,Limb=43,Misc=53)
         KickForce=4000
         DamageType=Class'JWVanDE.DTJunkGnomeDaemon'
         RefireTime=0.600000
         AnimRate=1.000000
         Sound=(Sound=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Swing')
         Anims(0)="WideHit3"
         Anims(1)="StabHit1"
         Anims(2)="StabHit2"
         Anims(3)="WideHit2"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'JWVanDE.JO_GardenGnomeDaemon.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=-2000))
         ImpactManager=Class'JunkWarDE.IM_JunkClubHammer'
         Damage=(head=78,Limb=39,Misc=52)
         KickForce=4500
         DamageType=Class'JWVanDE.DTJunkGnomeDaemon'
         RefireTime=0.700000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Swing')
         Anims(0)="StabAttack"
         PreFireAnims(0)="StabPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'JWVanDE.JO_GardenGnomeDaemon.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=2500
         ProjMass=10
         ProjMesh=StaticMesh'JWBPXav-HW.Weapons.GnomeDaemon_Thrown'
         ProjScale=0.250000
         WallImpactType=IT_Stick
         ActorImpactType=IT_Stick
         SpinRates=(Roll=-150000)
         ImpactManager=Class'JunkWarDE.IM_JunkClubHammer'
         ExplodeManager=Class'JunkWarDE.IM_JunkClubHammer'
         bCanBePickedUp=True
         Damage=(head=73,Limb=43,Misc=53)
         KickForce=6000
         DamageType=Class'JWVanDE.DTJunkGnomeDaemon'
         RefireTime=0.600000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Swing',Pitch=1.200000)
         Anims(0)="StabThrow"
         PreFireAnims(0)="StabPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'JWVanDE.JO_GardenGnomeDaemon.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'JunkWarSounds.Misc.Pullout-Avg')
     FriendlyName="Gruesome Gnome"
     InventoryGroup=6
     MeleeRating=30.000000
     RangeRating=20.000000
     SpawnWeight=0.900000
     PainThreshold=16
     NoUseThreshold=34
     StaticMesh=StaticMesh'JWBPXav-HW.Weapons.GnomeDaemon'
}
