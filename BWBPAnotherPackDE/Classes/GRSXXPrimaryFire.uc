//=============================================================================
// GRSXXPrimaryFire.
//
// Low power, low range, low recoil pistol fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRSXXPrimaryFire extends BallisticRangeAttenFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		AimedFireAnim = 'SightFireOpen';
		FireAnim = 'OpenFire';
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
     CutOffStartRange=768.000000
     TraceRange=(Min=4000.000000,Max=4000.000000)
     WallPenetrationForce=8.000000
     
     Damage=24.000000
     HeadMult=1.4f
     LimbMult=0.5f
     
     RangeAtten=0.200000
     WaterRangeAtten=0.500000
     DamageType=Class'BWBPAnotherPackDE.DTGRSXXPistol'
     DamageTypeHead=Class'BWBPAnotherPackDE.DTGRSXXPistolHead'
     DamageTypeArm=Class'BWBPAnotherPackDE.DTGRSXXPistol'
     PenetrateForce=100
     bPenetrate=True
     MuzzleFlashClass=Class'BWBPAnotherPackDE.GRSXXFlashEmitter'
     FlashScaleFactor=2.500000
     BrassClass=Class'BWBPAnotherPackDE.Brass_GRSXX'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     FireRecoil=150.000000
     FireChaos=0.120000
     XInaccuracy=72.000000
     YInaccuracy=72.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_SoundsExp.Glock_Gold.GRSXX-Fire',Volume=1.100000)
     FireEndAnim=
	 AimedFireAnim='SightFire'
     FireAnimRate=1.700000
     FireRate=0.050000
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_GRSXX'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
	 
     // AI
     bInstantHit=True
     bLeadTarget=False
     bTossed=False
     bSplashDamage=False
     bRecommendSplashDamage=False
     BotRefireRate=0.99
     WarnTargetPct=0.2
}
