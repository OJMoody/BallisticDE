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

function ServerPlayFiring()
{
	if (HKMK23Pistol(Weapon) != None && HKMK23Pistol(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

    if (FireCount > 0)
    {
        if (Weapon.HasAnim(FireLoopAnim))
            BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
        else
            BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    }
    else
        BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
}

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

	if (HKMK23Pistol(Weapon).bSilenced)
		Weapon.SetBoneScale (0, 1.0, HKMK23Pistol(Weapon).SilencerBone);
	else
		Weapon.SetBoneScale (0, 0.0, HKMK23Pistol(Weapon).SilencerBone);

	BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (HKMK23Pistol(Weapon) != None && HKMK23Pistol(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
}

defaultproperties
{
     SMuzzleFlashClass=Class'BallisticDE.XK2SilencedFlash'
     SFlashBone="tip2"
     SFlashScaleFactor=1.000000
     TraceRange=(Max=6000.000000)
     WaterRangeFactor=0.600000
     Damage=30.000000
     DamageHead=60.000000
     DamageLimb=20.000000
     WaterRangeAtten=0.500000
     DamageType=Class'BWBPArchivePackDE.DTHKMK23Pistol'
     DamageTypeHead=Class'BWBPArchivePackDE.DTHKMK23PistolHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTHKMK23Pistol'
     KickForce=8000
     PenetrateForce=135
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticDE.XK2FlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticDE.Brass_Pistol'
     BrassOffset=(X=-60.000000)
     RecoilPerShot=512.000000
     FireChaos=0.200000
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     SilencedFireSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.MK23.MkFire_2',Volume=1.500000,Radius=24.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.DE.MkFire_1',Volume=1.300000)
     bPawnRapidFireAnim=True
     FireRate=0.250000
	 FireAnimRate=1.75
     AmmoClass=Class'BWBPArchivePackDE.Ammo_45ACP'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     BotRefireRate=0.750000
}
