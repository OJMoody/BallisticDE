//=============================================================================
// EKS43PrimaryFire.
//
// Horizontalish swipe attack for the EKS43. Uses melee swpie system to do
// horizontal swipes. When the swipe traces find a player, the trace closest to
// the aim will be used to do the damage.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BlackOpsWristBladePrimaryFire extends BallisticMeleeFire;

var() Array<name> SliceAnims;
var int SliceAnim;

simulated event ModeDoFire()
{
	FireAnim = SliceAnims[SliceAnim];
	SliceAnim++;
	if (SliceAnim >= SliceAnims.Length)
		SliceAnim = 0;

	Super.ModeDoFire();
}

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     SliceAnims(0)="Slash1"
     SliceAnims(1)="Slash2"
     SliceAnims(2)="Slash3"
     SliceAnims(3)="Slash4"
     TraceRange=(Min=100.000000,Max=100.000000)
     Damage=60
     DamageHead=60
     DamageLimb=60
     DamageType=Class'BWBPArchivePackDE.DTBOBTorso'
     DamageTypeHead=Class'BWBPArchivePackDE.DTBOBHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTBOBLimb'
     KickForce=100
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds3.UZI.Melee',Volume=2.100000,Radius=32.000000,bAtten=True)
     bAISilent=True
     FireAnim="Slash1"
     FireAnimRate=0.900000
     FireRate=0.700000
     AmmoClass=Class'BallisticDE.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=256.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.100000
}
