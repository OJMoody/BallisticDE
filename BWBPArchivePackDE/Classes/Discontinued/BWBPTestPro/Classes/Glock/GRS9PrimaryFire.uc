//=============================================================================
//=============================================================================
// GRS9PrimaryFire.
//
// Low power, low range, low recoil pistol fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRS9PrimaryFire extends BallisticRangeAttenFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'ReloadEmpty';
		FireAnim = 'FireOpen';
		AimedFireAnim = 'SightFireOpen';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		FireAnim = 'Fire';
		AimedFireAnim = 'SightFire';
	}
	super.PlayFiring();
}

defaultproperties
{
     CutOffDistance=1536.000000
     CutOffStartRange=256.000000
     TraceRange=(Min=4000.000000,Max=4000.000000)
     WaterRangeFactor=0.600000
     WallPenetrationForce=8.000000
     
     Damage=25.000000
     DamageHead=37.000000
     DamageLimb=25.000000
     RangeAtten=0.200000
     WaterRangeAtten=0.500000
     DamageType=Class'BallisticDE.DTGRS9Pistol'
     DamageTypeHead=Class'BallisticDE.DTGRS9PistolHead'
     DamageTypeArm=Class'BallisticDE.DTGRS9Pistol'
     PenetrateForce=100
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticDE.XK2FlashEmitter'
     FlashScaleFactor=2.500000
     BrassClass=Class'BallisticDE.Brass_GRSNine'
     BrassBone="Muzzle"
     BrassOffset=(X=-30.000000,Y=1.000000)
     RecoilPerShot=256.000000
     FireChaos=0.120000
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.Glock.Glk-Fire',Volume=1.200000)
     FireEndAnim=
     FireAnimRate=1.700000
     FireRate=0.160000
	 AimedFireAnim=SightFire
     AmmoClass=Class'BallisticDE.Ammo_GRSNine'
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
