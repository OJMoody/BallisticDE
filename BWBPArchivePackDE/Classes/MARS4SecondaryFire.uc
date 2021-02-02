//=============================================================================
// MARS4SecondaryFire.
//
// A 40mm shockwave grenade that does damage over time
// Will deonate after 3 shockwaves.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MARS4SecondaryFire extends BallisticProjectileFire;

var   bool		bLoaded;

simulated function bool CheckGrenade()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if(!bLoaded)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if(seq == MARS4AssaultRifle(Weapon).GrenadeLoadAnim)
			return false;

		MARS4AssaultRifle(Weapon).LoadGrenade();
		bIsFiring=false;
		return false;
	}
	return true;
}

simulated function bool AllowFire()
{
	if (level.TimeSeconds < MARS4AssaultRifle(Weapon).SilencerSwitchTime)
		return false;
	return super.AllowFire();
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	if (!CheckGrenade())
		return;
	Super.ModeDoFire();
	bLoaded = false;
	PreFireTime = 0;
}

function StopFiring()
{
    local int channel;
    local name seq;
    local float frame, rate;
    
    weapon.GetAnimParams(channel, seq, frame, rate);
    if (Seq == PreFireAnim)
        Weapon.PlayAnim(Weapon.IdleAnim, 1.0, 0.5);
}

defaultproperties
{
     bLoaded=True
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BallisticDE.M50M900FlashEmitter'
     FlashBone="tip3"
     FireRecoil=1024.000000
     XInaccuracy=8.000000
     YInaccuracy=8.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bModeExclusive=False
	 bFireOnRelease=True
	 bWaitForRelease=True
	 PreFireAnim="GLPrepFire"
     FireAnim="GLFireFromPrep"
     FireForce="AssaultRifleAltFire"
	 AimedFireAnim="GLSightFireFromPrep"
     FireRate=2.000000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_MARS4Grenades'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPArchivePackDE.MARS4Grenade'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
