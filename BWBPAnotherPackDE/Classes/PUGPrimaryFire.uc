//=============================================================================
// PUGPrimaryFire.
//
// Moderately strong shotgun blast with decent spread and fair range for a shotgun.
// Can do more damage than the M763, but requires more shots normally.
//
// Can fire its shells HE mode, however it's nowhere near as strong as a FRAG.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PUGPrimaryFire extends BallisticProProjectileFire;

// Returns normal for some random spread. This is seperate from GetFireDir for shotgun reasons mainly...
simulated function vector GetFireSpread()
{
	local float fX;
	local Rotator R;

	if (BW.bScopeView)
		return super.GetFireSpread();

	fX = frand();
	R.Yaw =  600 * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
	R.Pitch = 600 * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
	return Vector(R);
}

defaultproperties
{
     SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BWBPAnotherPackDE.PUGFlashEmitter'
     FlashScaleFactor=0.050000
     BrassClass=Class'BWBPAnotherPackDE.Brass_BOLT'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     AimedFireAnim="SightFire"
     FireRecoil=650.000000
     FirePushBackForce=180.000000
     FireChaos=0.450000
     BallisticFireSound=(Sound=Sound'BWBP_CC_Sounds.PUG.PUG-Fire',Volume=2.000000)
     FireEndAnim=
     FireAnimRate=1.300000
     FireRate=0.300000
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_10GaugeDart'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPAnotherPackDE.PUGHEProjectile'
	 
	 // AI
	 bInstantHit=False
	 bLeadTarget=True
	 bTossed=True
	 bSplashDamage=True
	 bRecommendSplashDamage=False
	 BotRefireRate=0.6
     WarnTargetPct=0.4
}
