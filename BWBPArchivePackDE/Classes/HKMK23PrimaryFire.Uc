//=============================================================================
// M806PrimaryFire.
//
// Decent pistol shots that are accurate if the gun is steady enough
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HKMK23PrimaryFire extends BallisticProInstantFire;


var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>				SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;

simulated function bool AllowFire()
{
	if (level.TimeSeconds < HKMK23Pistol(Weapon).SilencerSwitchTime)
		return false;
	return super.AllowFire();
}

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((SMuzzleFlashClass != None) && ((SMuzzleFlash == None) || SMuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (SMuzzleFlash, SMuzzleFlashClass, Weapon.DrawScale*SFlashScaleFactor, weapon, SFlashBone);
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!HKMK23Pistol(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (HKMK23Pistol(Weapon).bSilenced && SMuzzleFlash != None)
        SMuzzleFlash.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (SMuzzleFlash);
}
// End effect functions ----------------------------------------------------
function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	if (HKMK23Pistol(Weapon).bSilenced)
		return Super.GetDamage (Other, HitLocation, Dir, Victim, DT) * 0.75;
	else
		return Super.GetDamage (Other, HitLocation, Dir, Victim, DT);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, HKMK23Pistol(Weapon).bSilenced, WaterHitLoc);
}

//// server propagation of firing ////
function ServerPlayFiring()
{
        if (BW.MagAmmo - ConsumedLoad < 1)
        {
          BW.IdleAnim = 'IdleOpen';
          BW.ReloadAnim = 'ReloadOpen';
          FireAnim = 'SightFireOpen';
          AimedFireAnim = 'SightFireOpen';
        }
      else
        {
        BW.IdleAnim = 'Idle';
        BW.ReloadAnim = 'Reload';
        FireAnim = 'SightFire';
        AimedFireAnim = 'SightFire';
        }
    if (HKMK23Pistol(Weapon) != None && HKMK23Pistol(Weapon).bSilenced && SilencedFireSound.Sound != None)
                Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
        else if (BallisticFireSound.Sound != None)
                Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

    CheckClipFinished();

    if (AimedFireAnim != '')
    {
        BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
        if (BW.BlendFire())        
            BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
    }

    else
    {
        if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
            BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
        else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    }
}

//Do the spread on the client side
function PlayFiring()
{
        if (BW.MagAmmo - ConsumedLoad < 1)
        {
          BW.IdleAnim = 'OpenIdle';
          BW.ReloadAnim = 'OpenReload';
          FireAnim = 'OpenFire';
          AimedFireAnim = 'SightFireOpen';
        }
      else
        {
        BW.IdleAnim = 'Idle';
        BW.ReloadAnim = 'Reload';
        FireAnim = 'Fire';
        AimedFireAnim = 'SightFire';
        }

    if (ScopeDownOn == SDO_Fire)
        BW.TemporaryScopeDown(0.5, 0.9);
        
    if (AimedFireAnim != '')
    {
        BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
        if (BW.BlendFire())        
            BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
    }

    else
    {
        if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
            BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
        else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    }
    
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
    // End code from normal PlayFiring()

     if (HKMK23Pistol(Weapon) != None && HKMK23Pistol(Weapon).bSilenced && SilencedFireSound.Sound != None)
                Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
        else if (BallisticFireSound.Sound != None)
                Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

    CheckClipFinished();
}

defaultproperties
{
     SMuzzleFlashClass=Class'BallisticDE.XK2SilencedFlash'
     SFlashBone="Joint11"
	 FlashBone="Joint8"
     SFlashScaleFactor=1.000000
     TraceRange=(Max=6000.000000)
     Damage=26.000000
     DamageType=Class'BWBPArchivePackDE.DTHKMK23Pistol'
     DamageTypeHead=Class'BWBPArchivePackDE.DTHKMK23PistolHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTHKMK23Pistol'
     KickForce=8000
     PenetrateForce=135
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticDE.XK2FlashEmitter'
     FlashScaleFactor=0.950000
     BrassClass=Class'BallisticDE.Brass_Pistol'
     BrassOffset=(X=-60.000000)
     FireRecoil=220.000000
     FireChaos=0.280000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     SilencedFireSound=(Sound=Sound'BWBP_JCF_Sounds.MK23.MkFire_2',Volume=1.500000,Radius=24.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BWBP_JCF_Sounds.DE.MkFire_1',Volume=1.300000)
     bPawnRapidFireAnim=True
     FireRate=0.210000
	 FireAnimRate=1.400000
	 FireAnim="SightFire"
	 AimedFireAnim="SightFire"
     AmmoClass=Class'BWBPArchivePackDE.Ammo_45ACP'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     BotRefireRate=0.750000
}
