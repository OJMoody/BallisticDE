//=============================================================================
// M763PrimaryFire.
//
// Powerful shotgun blast with moderate spread and fair range for a shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SPASSecondaryFire extends BallisticProShotgunFire;

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	SPASAttachment(Weapon.ThirdPersonActor).SPASUpdateHit(Other, HitLocation, HitNormal, Surf);
}


simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
	 HipSpreadFactor=3.000000
     CutOffDistance=2536.000000
     CutOffStartRange=1280.000000
	 TraceCount=6
     TracerClass=Class'BallisticDE.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticDE.IM_Shell'
     TraceRange=(Min=7500.000000,Max=7500.000000)
     Damage=9.000000
     DamageHead=9.000000
     DamageLimb=9.000000
     RangeAtten=0.30000
     DamageType=Class'BWBPArchivePackDE.DTSPASShotgun'
     DamageTypeHead=Class'BWBPArchivePackDE.DTSPASShotgunHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTSPASShotgun'
     KickForce=8000
     PenetrateForce=100
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticDE.MRT6FlashEmitter'
     BrassClass=Class'BallisticDE.Brass_Shotgun'
     bBrassOnCock=True
     RecoilPerShot=650.000000
     XInaccuracy=170.000000
     YInaccuracy=170.000000
	 FlashScaleFactor=0.35
	 FireChaos=0.3
     BallisticFireSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.DE.Fire_SPAS',Volume=1.500000)
     FireAnim="Fire"
	 AimedFireAnim="SightFire"
     FireEndAnim=
	 FireRate=0.450000
     AmmoClass=Class'BallisticDE.Ammo_12Gauge'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.500000
}
