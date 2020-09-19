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
class ChainsawPrimaryFire extends BallisticMeleeFire;

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
     SliceAnims(0)="Swing1"
     SliceAnims(1)="Swing2"
     FatiguePerStrike=0.064000
     bCanBackstab=False
     TraceRange=(Min=180.000000,Max=180.000000)
	 Damage=80.000000
     DamageHead=80.000000
     DamageLimb=80.000000
     DamageType=Class'BWBPArchivePackPro2.DT_ChainsawStab'
     DamageTypeHead=Class'BWBPArchivePackPro2.DT_ChainsawStabHead'
     DamageTypeArm=Class'BWBPArchivePackPro2.DT_ChainsawStab'
     KickForce=100
     BallisticFireSound=(Sound=Sound'BWBPSomeOtherPackSounds.LongSword.SawSwing',Radius=378.000000,bAtten=True,bNoOverride=False)
     bAISilent=True
     FireAnim="Swing1"
     FireRate=0.75
     AmmoClass=Class'Ammo_ChainsawCharge'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=512.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.800000
     WarnTargetPct=0.100000
}
