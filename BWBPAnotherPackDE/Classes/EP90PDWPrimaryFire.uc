//=============================================================================
// EP90PDWPrimaryFire.
//
// Decent pistol shots that are accurate if the gun is steady enough
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class EP90PDWPrimaryFire extends BallisticRangeAttenFire;

//Do the spread on the client side
/*function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.ReloadAnim = 'ReloadEmpty';
	}
	else
	{
		BW.ReloadAnim = 'Reload';
	}
	super.PlayFiring();
}*/

defaultproperties
{
     CutOffDistance=3600.000000
     CutOffStartRange=1800.000000
     TraceRange=(Max=6000.000000)
     Damage=26.000000
     RangeAtten=0.30000
     WaterRangeAtten=0.500000
     DamageType=Class'BWBPAnotherPackDE.DTEP90PDW'
     DamageTypeHead=Class'BWBPAnotherPackDE.DTEP90PDWHead'
     DamageTypeArm=Class'BWBPAnotherPackDE.DTEP90PDW'
	 DryFireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Empty',Volume=1.200000)
     KickForce=6000
     PenetrateForce=150
     bPenetrate=True
     MuzzleFlashClass=Class'BWBPAnotherPackDE.EP90PDWFlashEmitter'
	 FlashScaleFactor=0.050000
     BrassClass=Class'BallisticDE.Brass_Pistol'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     FireRecoil=150.000000
     FireChaos=0.150000
	 XInaccuracy=32
	 YInaccuracy=32
     BallisticFireSound=(Sound=Sound'BWBP_CC_Sounds.EP110.EP110-Fire',Volume=9.500000,Slot=SLOT_Interact,bNoOverride=False)
     FireEndAnim=
     FireRate=0.125000
     FireAnimRate=1
	 FireAnim="Fire"
	 AimedFireAnim="SightFire"
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_EP90HV'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
