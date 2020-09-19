//=============================================================================
// EKS43SecondaryFire.
//
// Vertical/Diagonal held swipe for the EKS43. Uses swipe system and is prone
// to headshots because the highest trace that hits an enemy will be used to do
// the damage and check hit area.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BlackOpsWristBladeSecondaryFire extends BallisticMeleeFire;

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
     SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
     SwipePoints(2)=(Weight=4,offset=(Pitch=3000))
     SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
     SwipePoints(4)=(Weight=2,offset=(Yaw=0))
     SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
     WallHitPoint=4
     Damage=75
     DamageHead=75
     DamageLimb=75
     DamageType=Class'BWBPArchivePackDE.DTBOBTorsoLunge'
     DamageTypeHead=Class'BWBPArchivePackDE.DTBOBHeadLunge'
     DamageTypeArm=Class'BWBPArchivePackDE.DTBOBTorsoLunge'
     KickForce=200
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bReleaseFireOnDie=False
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds3.UZI.Melee',Volume=2.500000,Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepHack"
     FireAnim="Hack"
     FireRate=0.800000
     AmmoClass=Class'BallisticDE.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=32.000000,Y=256.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
