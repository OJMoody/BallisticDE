//=============================================================================
// M30PrimaryFire.
//
//[11:09:19 PM] Captain Xavious: make sure its noted to be an assault rifle
//[11:09:26 PM] Marc Moylan: lol Calypto
//[11:09:28 PM] Matteo 'Azarael': mp40 effective range
//[11:09:29 PM] Matteo 'Azarael': miles
//=============================================================================
class FMPPrimaryFire extends BallisticProInstantFire;

var() sound		AmpRedFireSound;
var() sound		AmpGreenFireSound;
var() sound		RegularFireSound;
var bool		bFlashRed;
var bool		bFlashGreen;
var() Actor						MuzzleFlashRed;		// ALT: The muzzleflash actor
var() class<Actor>				MuzzleFlashClassRed;	// ALT: The actor to use for this fire's muzzleflash
var() Actor						MuzzleFlashGreen;		// ALT: The muzzleflash actor
var() class<Actor>				MuzzleFlashClassGreen;	// ALT: The actor to use for this fire's muzzleflash
var() Name						AmpFlashBone;
var() float						AmpFlashScaleFactor;


simulated function bool AllowFire()
{
	if (level.TimeSeconds < FMPMachinePistol(Weapon).AmplifierSwitchTime)
		return false;
	return super.AllowFire();
}

// Effect related functions ------------------------------------------------
// Spawn the muzzleflash actor
function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((MuzzleFlashClassRed != None) && ((MuzzleFlashRed == None) || MuzzleFlashRed.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashRed, MuzzleFlashClassRed, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((MuzzleFlashClassGreen != None) && ((MuzzleFlashGreen == None) || MuzzleFlashGreen.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashGreen, MuzzleFlashClassGreen, Weapon.DrawScale*AmpFlashScaleFactor, weapon, FlashBone);

}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashRed);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashGreen);
}


//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
 
    if (MuzzleFlashRed != None && bFlashRed)
       	MuzzleFlashRed.Trigger(Weapon, Instigator);
    else if (MuzzleFlashGreen != None && bFlashGreen)
        MuzzleFlashGreen.Trigger(Weapon, Instigator);
	else
		MuzzleFlash.Trigger(Weapon, Instigator);
		
	if (!bBrassOnCock)
		EjectBrass();
}


simulated function SwitchWeaponMode (byte NewMode)
{
	if (NewMode == 0) //Standard Fire
	{
		BallisticFireSound.Sound=default.BallisticFireSound.sound;
		BallisticFireSound.Volume=default.BallisticFireSound.Volume;
		FireRecoil=default.FireRecoil;
		Damage = default.Damage;
		DamageType=default.DamageType;
		DamageTypeHead=default.DamageTypeHead;
		DamageTypeArm=default.DamageTypeArm;
		FireRate=Default.FireRate;
		FlashScaleFactor=default.FlashScaleFactor;
		bFlashRed=false;
		bFlashGreen=false;
		RangeAtten=default.RangeAtten;
		FlashBone=default.FlashBone;
		FlashScaleFactor=default.FlashScaleFactor;
	}
	
	else if (NewMode == 1) //Incendiary Amp
	{
		BallisticFireSound.Sound=AmpRedFireSound;
		BallisticFireSound.Volume=1.600000;
		FireRecoil=512.000000;
		Damage=35.000000;
		DamageType=Class'DT_MP40_Incendiary';
		DamageTypeHead=Class'DT_MP40Head_Incendiary';
		DamageTypeArm=Class'DT_MP40_Incendiary';
		FireRate=0.235000;
		FlashScaleFactor=1.100000;
		bFlashRed=true;
		bFlashGreen=false;
		RangeAtten=1.000000;
		FlashBone=default.AmpFlashBone;
		FlashScaleFactor=AmpFlashScaleFactor;
	}
	else if (NewMode == 2) //Corrosive Amp
	{
		BallisticFireSound.Sound=AmpGreenFireSound;
		BallisticFireSound.Volume=1.100000;
		FireRecoil=70.000000;
		Damage=22.000000;
		DamageType=Class'DT_MP40_Corrosive';
		DamageTypeHead=Class'DT_MP40Head_Corrosive';
		DamageTypeArm=Class'DT_MP40_Corrosive';
		FireRate=0.100000;
		FlashScaleFactor=0.400000;
		bFlashRed=false;
		bFlashGreen=true;
		RangeAtten=1.000000;
		FlashBone=AmpFlashBone;
		FlashScaleFactor=AmpFlashScaleFactor;
	}
	else
	{
		BallisticFireSound.Sound=default.BallisticFireSound.sound;
		BallisticFireSound.Volume=default.BallisticFireSound.Volume;
		FireRecoil=default.FireRecoil;
		Damage = default.Damage;
		DamageType=default.DamageType;
		DamageTypeHead=default.DamageTypeHead;
		DamageTypeArm=default.DamageTypeArm;
		FireRate=Default.FireRate;
		FlashScaleFactor=default.FlashScaleFactor;
		bFlashRed=false;
		bFlashGreen=false;
		RangeAtten=default.RangeAtten;
		FlashBone=default.FlashBone;
		FlashScaleFactor=default.FlashScaleFactor;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim.bProjTarget && BallisticShield(Victim) == None && bFlashRed)
		BW.TargetedHurtRadius(Damage, 256, class'DT_MP40_Incendiary', 200, HitLocation, Pawn(Victim));
}

// Does something to make the effects appear
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;

	if ((!Other.bWorldGeometry && Mover(Other) == None && Pawn(Other) == None) || level.NetMode == NM_Client)
		return false;

	if (Vehicle(Other) != None)
		Surf = 3;
	else if (HitMat == None)
		Surf = int(Other.SurfaceType);
	else
		Surf = int(HitMat.SurfaceType);
		
	if ((Other == None || Other.bWorldGeometry) && bFlashRed)
		BW.TargetedHurtRadius(3, 150, class'DT_MP40_Incendiary', 50, HitLocation);

	// Tell the attachment to spawn effects and so on
	SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	if (!bAISilent)
		Instigator.MakeNoise(1.0);
	return true;
}

//Do the spread on the client side
function PlayFiring()
{
    if (BW.MagAmmo - ConsumedLoad < 1)
    {
        BW.IdleAnim = 'IdleClosed';
        BW.ReloadAnim = 'ReloadEmpty';
        AimedFireAnim = 'SightFireClosed';
        FireAnim = 'FireClosed';
    }
    else
    {
        BW.IdleAnim = 'Idle';
        BW.ReloadAnim = 'Reload';
        AimedFireAnim = 'SightFire';
        FireAnim = 'Fire';
    }
    super.PlayFiring();
}

defaultproperties
{
     AmpRedFireSound=SoundGroup'BWBP_SKC_SoundsExp.MP40.MP40-HotFire'
     AmpGreenFireSound=SoundGroup'BWBP_SKC_SoundsExp.MP40.MP40-AcidFire'
	 MuzzleFlashClass=Class'BallisticDE.XK2FlashEmitter'
	 MuzzleFlashClassRed=Class'BallisticDE.M50FlashEmitter'
     MuzzleFlashClassGreen=Class'BallisticDE.A500FlashEmitter'
	 TraceRange=(Min=9000.000000,Max=9000.000000)
     Damage=25
     RangeAtten=0.700000
     WaterRangeAtten=0.700000
     DamageType=Class'BWBPAnotherPackDE.DT_MP40'
     DamageTypeHead=Class'BWBPAnotherPackDE.DT_MP40Head'
     DamageTypeArm=Class'BWBPAnotherPackDE.DT_MP40'
     KickForce=18000
     HookStopFactor=0.200000
     HookPullForce=-10.000000
     PenetrateForce=150
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     FlashScaleFactor=0.900000
     BrassClass=Class'BallisticDE.Brass_Rifle'
     FlashBone="tip"
	 AmpFlashBone="tip2"
	 AmpFlashScaleFactor=0.300000
	 FireAnim="Fire"
	 AimedFireAnim="SightFire"
	 EmptyFireAnim="FireClosed"
	 EmptyAimedFireAnim="SightFireClosed"
     BrassOffset=(X=-50.000000,Y=1.000000)
     FireRecoil=90.000000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
	 FireChaos=0.030000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_SoundsExp.MP40.MP40-Fire',Volume=1.200000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.105000
     AmmoClass=Class'BallisticDE.Ammo_XRS10Bullets'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     aimerror=900.000000
}
