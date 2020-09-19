//=============================================================================
// M806PrimaryFire.
//
// Decent pistol shots that are accurate if the gun is steady enough
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DEPrimaryFire extends BallisticProInstantFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 2)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}

defaultproperties
{
     TraceRange=(Max=6000.000000)
     WaterRangeFactor=0.600000
     MaxWallSize=24.000000
     MaxWalls=2
     Damage=30.000000
     DamageHead=60.000000
     DamageLimb=20.000000
     WaterRangeAtten=0.500000
     DamageType=Class'BWBPArchivePackDE.DTDEPistol'
     DamageTypeHead=Class'BWBPArchivePackDE.DTDEPistolHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTDEPistol'
     KickForce=1000
     PenetrateForce=150
     bPenetrate=True
     MuzzleFlashClass=Class'BWBPArchivePackDE.DEFlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BWBPArchivePackDE.Brass_50DE'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     RecoilPerShot=3072.000000
     XInaccuracy=16.000000
     YInaccuracy=16.000000
     BallisticFireSound=(Sound=Sound'BWWeaponPack2-Sounds.DE.DeFire',Volume=1.500000)
     FireEndAnim=
     FireRate=0.390000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_50AE'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
