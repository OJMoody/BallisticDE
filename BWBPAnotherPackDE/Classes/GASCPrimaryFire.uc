//=============================================================================
// GASCPrimaryFire.
//
// Decent pistol shots that are accurate if the gun is steady enough
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class GASCPrimaryFire extends BallisticRangeAttenFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'IdleOpen';
		BW.ReloadAnim = 'ReloadOpen';
		AimedFireAnim = 'SightFireOpen';
		FireAnim = 'FireOpen';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}

defaultproperties
{
     CutOffDistance=1536.000000
     CutOffStartRange=512.000000
     TraceRange=(Min=4000.000000,Max=4000.000000)
     WallPenetrationForce=8.000000
     
     Damage=26.000000
     DamageHead=44.000000
     DamageLimb=26.000000
     RangeAtten=0.200000
     WaterRangeAtten=0.500000
     DamageType=Class'BWBPAnotherPackDE.DTGASCPistol'
     DamageTypeHead=Class'BWBPAnotherPackDE.DTGASCPistolHead'
     DamageTypeArm=Class'BWBPAnotherPackDE.DTGASCPistol'
     PenetrateForce=150
     bPenetrate=True
     MuzzleFlashClass=Class'BWBPAnotherPackDE.GASCFlashEmitter'
     FlashScaleFactor=0.10000
     BrassClass=Class'BallisticDE.Brass_Pistol'
     BrassOffset=(X=-10.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=64.000000
     FireChaos=0.100000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     BallisticFireSound=(Sound=Sound'BWBPAnotherPackSounds2.GASC.GASC-Fire',Volume=0.800000)
     FireEndAnim=
     FireAnimRate=1.450000
     FireRate=0.075000
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_GASCClip'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.300000
}
