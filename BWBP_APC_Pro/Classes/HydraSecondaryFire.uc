//=============================================================================
// HydraSecondaryFire.
//
// Rocket launching secondary fire for Hydra
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HydraSecondaryFire extends BallisticProProjectileFire;

/*var Sound ChargingSound;
var int HydraLoad;

const ROCKETMAX = 6;

function ModeHoldFire()
{
    if ( BW.HasMagAmmo(ThisModeNum) )
    {
        Super.ModeHoldFire();
		BW.bPreventReload = True;
        GotoState('Hold');
    }
}

state Hold
{
    simulated function BeginState()
    {
        HydraLoad = 0;
        SetTimer(1.25, true);
        Instigator.AmbientSound = ChargingSound;
		Instigator.SoundRadius = 256;
		Instigator.SoundVolume = 255;
        Timer();
    }

    simulated function Timer()
    {
		if (BW.HasMagAmmo(ThisModeNum))
			HydraLoad++;
        BW.ConsumeMagAmmo(ThisModeNum, 1);
        if (HydraLoad == ROCKETMAX || !BW.HasMagAmmo(ThisModeNum))
            SetTimer(0.0, false);
    }

    simulated function EndState()
    {
		if ( Weapon != None && Instigator != None)
		{
			BW.bPreventReload = False;
			Instigator.AmbientSound = None;
			Instigator.SoundRadius = Instigator.default.SoundRadius;
			Instigator.SoundVolume = Instigator.default.SoundVolume;
		}
    }
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	GoToState('');
	
	if (HydraLoad == 0)
		return;
		
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj != None)
	{
		Proj.Instigator = Instigator;
		HydraRocket(Proj).HydraLoad = float(HydraLoad)/float(ROCKETMAX);
		HydraRocket(Proj).AdjustSpeed();
	}
}*/

defaultproperties
{
     bFireOnRelease=True
	 //ChargingSound=Sound'GeneralAmbience.texture22'
	 SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     bCockAfterFire=False
     MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
     FireRecoil=64.000000
     FireChaos=0.500000
     XInaccuracy=4.000000
     YInaccuracy=4.000000
     //BallisticFireSound=(SoundGroup=Sound'BWBP_CC_Sounds.Launcher.Launcher-Fire')
     FireEndAnim=
     FireRate=0.800000
     AmmoClass=Class'BallisticProV55.Ammo_RPG'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.500000
     ProjectileClass=Class'BWBP_APC_Pro.HydraRocket'
	 
	 // AI
	 bInstantHit=False
	 bLeadTarget=True
	 bTossed=False
	 bSplashDamage=True
	 bRecommendSplashDamage=True
	 BotRefireRate=0.5
     WarnTargetPct=0.8
}
