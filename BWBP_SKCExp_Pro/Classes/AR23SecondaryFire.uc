//=============================================================================
// AR23SecondaryFire.
//
// A 40mm cannister shell. Does massive damage in a cone
//
// by Marc "Sgt Kelly" Moylan.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AR23SecondaryFire extends BallisticShotgunFire;

var   bool		bLoaded;

simulated function bool CheckGrenade()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if(!bLoaded)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if(seq == AR23HeavyRifle(Weapon).GrenadeLoadAnim)
			return false;

		AR23HeavyRifle(Weapon).LoadGrenade();
		bIsFiring=false;
		return false;
	}
	return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	if (!CheckGrenade())
		return;
	Super.ModeDoFire();
	bLoaded = false;
}

defaultproperties
{
     bLoaded=True
     bUseWeaponMag=False
     TraceCount=36
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=2000.000000,Max=4000.000000)
	 Damage=25.000000
     HeadMult=1.4f
     LimbMult=1.0f
     RangeAtten=0.300000
     KickForce=20000
     PenetrateForce=500
     bPenetrate=True
     FlashBone="tip2"
     FireRecoil=2048.000000
     FirePushbackForce=1850.000000
     XInaccuracy=1600.000000
     YInaccuracy=1600.000000
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Misc.FLAK-Fire',Volume=1.800000)
     bFireOnRelease=True
     bModeExclusive=False
     PreFireAnim="PrepBigFire"
     FireAnim="FireBig2"
     FireForce="AssaultRifleAltFire"
     FireRate=2.500000
     AmmoClass=Class'BallisticProV55.Ammo_M46Grenades'
     ShakeRotMag=(X=256.000000,Y=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-50.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.500000
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
