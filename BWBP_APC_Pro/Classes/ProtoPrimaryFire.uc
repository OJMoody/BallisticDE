//=============================================================================
// CYLOPrimaryFire.
//
// For some really odd reason my UDE isn't liking the class names, so I have to
// change the names for UDE to recognize them every once in a while...
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ProtoPrimaryFire extends BallisticRangeAttenFire;

var() sound		RifleFireSound;
var() sound		MeleeFireSound;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>				SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((SMuzzleFlashClass != None) && ((SMuzzleFlash == None) || SMuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (SMuzzleFlash, SMuzzleFlashClass, Weapon.DrawScale*SFlashScaleFactor, weapon, SFlashBone);
}

function SetSilenced(bool bSilenced)
{
	bAISilent = bSilenced;
	if (!bSilenced)
	{
		XInaccuracy *= 2;
		YInaccuracy *= 2;
		CutOffStartRange *= 1.25;
	}
	else
	{
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
		CutOffStartRange = default.CutOffStartRange;
	}
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!ProtoSMG(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (ProtoSMG(Weapon).bSilenced && SMuzzleFlash != None)
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

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, ProtoSMG(Weapon).bSilenced, WaterHitLoc);
}

function ServerPlayFiring()
{
	if (ProtoSMG(Weapon) != None && ProtoSMG(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	// Slightly modified Code from original PlayFiring()
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else if(!BW.bScopeView || !Weapon.HasAnim(AimedFireAnim))
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	else BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "FIRE");
	// End code from normal PlayFiring()

	CheckClipFinished();
}

function PlayFiring()
{
	if (ProtoSMG(Weapon).bSilenced)
		Weapon.SetBoneScale (0, 1.0, ProtoSMG(Weapon).SilencerBone);
	else
		Weapon.SetBoneScale (0, 0.0, ProtoSMG(Weapon).SilencerBone);
		
	// Slightly modified Code from original PlayFiring()
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else if(!BW.bScopeView || !Weapon.HasAnim(AimedFireAnim))
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	else BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "FIRE");
	// End code from normal PlayFiring()

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (ProtoSMG(Weapon) != None && ProtoSMG(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}

defaultproperties
{
     SMuzzleFlashClass=Class'BWBP_SWC_Pro.MDKSilencedFlash'
     SFlashBone="tip"
	 FlashBone="tip2"
     SFlashScaleFactor=1.000000
	 RifleFireSound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire'
     CutOffDistance=3072.000000
     CutOffStartRange=1536.000000
     TraceRange=(Min=8000.000000,Max=12000.000000)
     WallPenetrationForce=24.000000
     
     Damage=28.000000
    
     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBP_SKC_Pro.DTCYLORifle'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLORifleHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLORifle'
     PenetrateForce=180
     bPenetrate=True
     RunningSpeedThresh=1000.000000
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashBone="Muzzle"
     FlashScaleFactor=0.500000
     FireRecoil=220.000000
     FireChaos=0.032000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     PreFireAnim=
     FireEndAnim=
     FireRate=0.1050000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_CYLO'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
