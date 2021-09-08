//=============================================================================
// MRDRPrimaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RoboT9CNPrimaryFire extends BallisticRangeAttenFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'IdleOpen';
		BW.ReloadAnim = 'ReloadOpen';
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
     CutOffStartRange=768.000000
     WallPenetrationForce=8.000000
     
     Damage=14.000000
     HeadMult=1.5f
     LimbMult=0.5f
     
     RangeAtten=0.200000
     WaterRangeAtten=0.200000
     DamageType=Class'BWBP_SKCExp_Pro.DTRoboT9CN'
     DamageTypeHead=Class'BWBP_SKCExp_Pro.DTRoboT9CNHead'
     DamageTypeArm=Class'BWBP_SKCExp_Pro.DTRoboT9CN'
     PenetrateForce=0
     bPenetrate=False
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-2',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryPistol',Volume=0.700000)
     MuzzleFlashClass=Class'BWBP_SKCExp_Pro.RoboT9CNFlashEmitter'
     FlashScaleFactor=0.600000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-25.000000,Z=-5.000000)
     FireRecoil=64.000000
     FireChaos=0.100000
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-FireOld',Volume=1.300000)
     bPawnRapidFireAnim=True
     FireRate=0.120000
     AmmoClass=Class'BWBP_SKCExp_Pro.Ammo_9mmRoboT9CN'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
}
