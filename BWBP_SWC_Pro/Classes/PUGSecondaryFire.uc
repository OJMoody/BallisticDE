//=============================================================================
// PUGSecondaryFire.
//
// A nightmare of notifies and conditional code.
// Absolutely massive 20mm tear gas shell. Great for accidentally killing rioters
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PUGSecondaryFire extends BallisticProjectileFire;

var   bool		bLoaded;

simulated function bool CheckGrenade()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (!bLoaded)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if (seq == PUGAssaultCannon(Weapon).GrenadeLoadAnim)
			return false;
			
		PUGAssaultCannon(Weapon).LoadGrenade();
		bIsFiring=false;
		return false;
	}
	
	return true;
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing

	if(!Super.AllowFire() || !bLoaded)
	{
		if (DryFireSound.Sound != None)
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
		BW.EmptyFire(1);
		return false;	// Does not use ammo from weapon mag. Is there ammo in inventory
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
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     BrassClass=Class'BWBP_SWC_Pro.Brass_FRAGSpent'
     BrassOffset=(X=-30.000000,Y=1.000000)
     FireRecoil=1048.000000
     FirePushBackForce=100.000000
     BallisticFireSound=(Sound=Sound'BWBP_CC_Sounds.PUG.PUG-FireSlug',Volume=7.500000)
	 bFireOnRelease=True
     bWaitForRelease=True
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bModeExclusive=False
	 FlashBone="tip2"
     PreFireTime=0.450000
     PreFireAnim="GrenadePrep"
	 FireAnim="GrenadeFire"
     FireForce="AssaultRifleAltFire"
	 ReloadAnim="GrenadeReload"
     AmmoClass=Class'BWBP_SWC_Pro.Ammo_20mmGrenade'
     AmmoPerFire=1
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_SWC_Pro.PUGRocket'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
