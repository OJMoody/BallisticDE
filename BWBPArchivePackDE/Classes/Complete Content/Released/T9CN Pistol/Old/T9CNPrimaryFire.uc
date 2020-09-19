//=============================================================================
// T9CNPrimaryFire.
//
// Low power, low range, med recoil pistol fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class T9CNPrimaryFire extends BallisticProInstantFire;

var() sound		SpecialFireSound;
var() sound		NewFireSound;
// Burst Mode -----------------------------------------------------------------
var int ShotsFired;         // Number of shots fired in this burst thus far
var float BurstDelay;
var bool bRapidMode;        // Weapon fires bursts


// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	if (bIsJammed)
	{
		if (BW.FireCount == 0)
		{
			bIsJammed=false;
			if (bJamWastesAmmo && Weapon.Role == ROLE_Authority)
			{
				ConsumedLoad += Load;
				Timer();
			}
			if (UnjamMethod == UJM_FireNextRound)
			{
				NextFireTime += FireRate;
				NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
				BW.FireCount++;
				return;
			}
			if (!AllowFire())
				return;
     		}
		else
		{
			NextFireTime += FireRate;
			NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
			return;
		}
	}

	if (BW != None)
	{
		BW.bPreventReload=true;
		BW.FireCount++;

		if (BW.ReloadState != RS_None)
		{
			if (weapon.Role == ROLE_Authority)
			BW.bServerReloading=false;
			BW.ReloadState = RS_None;
		}
	}

	if (MaxHoldTime > 0.0)
		HoldTime = FMin(HoldTime, MaxHoldTime);

	ConsumedLoad += Load;
	SetTimer(FMin(0.1, FireRate/2), false);
	// server
	if (Weapon.Role == ROLE_Authority)
	{
		DoFireEffect();
 		if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
		if ( AIController(Instigator.Controller) != None )
			AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
 		Instigator.DeactivateSpawnProtection();
	}
	else if (!BW.bScopeView && !BW.bUseNetAim)
		FireRecoil();
 
	BW.LastFireTime = Level.TimeSeconds;


	// client
	if (Instigator.IsLocallyControlled())
	{
		ShakeView();
		PlayFiring();
        	FlashMuzzleFlash();
        	StartMuzzleSmoke();
	}
	else // server
	{
        	ServerPlayFiring();
	}

	// set the next firing time. must be careful here so client and server do not get out of sync
	if (bFireOnRelease)
	{
        	if (bIsFiring)
			NextFireTime += MaxHoldTime + FireRate;
        	else
            		NextFireTime = Level.TimeSeconds + FireRate;
    	}
    	else if (bRapidMode)
    	{
     		if (ShotsFired > 3)
     		{
      			NextFireTime += BurstDelay;
      			NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
      			Weapon.StopFire(ThisModeNum);
      			ShotsFired = 0;
     		}
     		else
     		{
      			NextFireTime += FireRate;
     			NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		}
    	}
    	else
    	{
        	NextFireTime += FireRate;
        	NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    	}

    	Load = AmmoPerFire;
    	HoldTime = 0;

    	if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    	{
        	bIsFiring = false;
        	Weapon.PutDown();
    	}

 	if (BW != None)
 	{
  		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
  		if (bCockAfterFire || (bCockAfterEmpty && BW.MagAmmo - ConsumedLoad < 1))
   			BW.bNeedCock=true;
	}
}

function StopFiring()
{
	Super.StopFiring();
	if (bRapidMode)
	{
		ShotsFired = 0;
		NextFireTime = Level.TimeSeconds + BurstDelay;
	}
}


simulated function SwitchCannonMode (byte NewMode)
{
	if (NewMode != 2)
	{
		//if (T9CNMachinePistol(Weapon).CamoIndex == 1)
		//{
			BallisticFireSound.Sound=NewFireSound;
     			XInaccuracy=8.000000;
     			YInaccuracy=8.000000;
		//}
		//else
		//{
			//BallisticFireSound.Sound=SpecialFireSound;
     			//XInaccuracy=16.000000;
     			//YInaccuracy=16.000000;
		//}
		FireAnimRate=2;
	}
	else
	{
		//if (T9CNMachinePistol(Weapon).CamoIndex == 1)
		//{
				BallisticFireSound.Sound=NewFireSound;
     			XInaccuracy=8.000000;
     			YInaccuracy=8.000000;
		//}
		//else
		//{
     			//XInaccuracy=default.XInaccuracy;
     			//YInaccuracy=default.YInaccuracy;
		//}
		FireAnimRate=1;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.50;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

	Load=AmmoPerFire;
}

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'IdleOpen';
		BW.ReloadAnim = 'ReloadOpen';
		FireAnim = 'FireOpen';
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
     SpecialFireSound=Sound'PackageSounds4.T9CN.T9CN-FireSingle'
     NewFireSound=Sound'PackageSounds4.T9CN.T9CN-Fire'
     BurstDelay=0.200000
     WaterRangeFactor=0.600000
     MaxWallSize=16.000000
     MaxWalls=2
     Damage=15
     DamageHead=30
     DamageLimb=12
     RangeAtten=0.700000
     WaterRangeAtten=0.500000
     DamageType=Class'BWBPArchivePackDE.DTGRS1Pistol'
     DamageTypeHead=Class'BWBPArchivePackDE.DTGRS1PistolHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTGRS1Pistol'
     KickForce=4000
     PenetrateForce=100
     bPenetrate=True
	 FireChaos=0.200000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     MuzzleFlashClass=Class'BallisticDE.XK2FlashEmitter'
     BrassClass=Class'BallisticDE.Brass_GRSNine'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     RecoilPerShot=768.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4.T9CN.T9CN-FireOld',Volume=1.200000)
     bModeExclusive=False
     FireEndAnim=
     FireRate=0.080000
     AmmoClass=Class'BallisticDE.Ammo_GRSNine'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
