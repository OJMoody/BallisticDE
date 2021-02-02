//=============================================================================
// RS8PrimaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SX45PrimaryFire extends BallisticRangeAttenFire;

var() BUtil.FullSound			Amp1FireSound; //Cyro, Blue
var() BUtil.FullSound			Amp2FireSound; //Rad, Yellow
var() sound						RegularFireSound;
var bool						bFlashAmp1;
var bool						bFlashAmp2;
var() Actor						MuzzleFlashAmp1;		
var() class<Actor>				MuzzleFlashClassAmp1;	
var() Actor						MuzzleFlashAmp2;		
var() class<Actor>				MuzzleFlashClassAmp2;	
var() Name						AmpFlashBone;
var() float						AmpFlashScaleFactor;

simulated function bool AllowFire()
{
	if (level.TimeSeconds < SX45Pistol(Weapon).AmplifierSwitchTime)
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
    if ((MuzzleFlashClassAmp1 != None) && ((MuzzleFlashAmp1 == None) || MuzzleFlashAmp1.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp1, MuzzleFlashClassAmp1, Weapon.DrawScale*FlashScaleFactor, weapon, AmpFlashBone);
    if ((MuzzleFlashClassAmp2 != None) && ((MuzzleFlashAmp2 == None) || MuzzleFlashAmp2.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp2, MuzzleFlashClassAmp2, Weapon.DrawScale*AmpFlashScaleFactor, weapon, AmpFlashBone);

}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

    if (MuzzleFlashAmp1 != None && bFlashAmp1)
       	MuzzleFlashAmp1.Trigger(Weapon, Instigator);
    else if (MuzzleFlashAmp2 != None && bFlashAmp2)
        MuzzleFlashAmp2.Trigger(Weapon, Instigator);
	else
		MuzzleFlash.Trigger(Weapon, Instigator);
		
	if (!bBrassOnCock)
		EjectBrass();
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashAmp1);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashAmp2);
}

simulated function SwitchWeaponMode (byte NewMode)
{
	if (NewMode == 0) //Standard Fire
	{
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
		BallisticFireSound.Volume=default.BallisticFireSound.Volume;
		FireRecoil=default.FireRecoil;
		Damage = default.Damage;
		DamageType=default.DamageType;
		DamageTypeHead=default.DamageTypeHead;
		DamageTypeArm=default.DamageTypeArm;
		FireRate=Default.FireRate;
		FlashScaleFactor=default.FlashScaleFactor;
		bFlashAmp1=false;
		bFlashAmp2=false;
		FlashBone=FlashBone;
		RangeAtten=default.RangeAtten;
	}
	else if (NewMode == 1) //Cryo Amp
	{
		BallisticFireSound.Sound=Amp1FireSound.Sound;
		BallisticFireSound.Volume=1.000000;
		FireRecoil=512.000000;
		Damage=28.000000;
		DamageType=class'DTSX45Pistol_Cryo';
		DamageTypeHead=class'DTSX45PistolHead_Cryo';
		DamageTypeArm=class'DTSX45Pistol_Cryo';
		FireRate=0.235000;
		FlashScaleFactor=default.FlashScaleFactor*0.070000;
		bFlashAmp1=true;
		bFlashAmp2=false;
		FlashBone=AmpFlashBone;
		RangeAtten=1.000000;
	}
	else if (NewMode == 2) //RAD Amp
	{
		BallisticFireSound.Sound=Amp2FireSound.Sound;
		BallisticFireSound.Volume=1.300000;
		FireRecoil=128.000000;
		Damage=22.000000;
		DamageType=class'DTSX45Pistol_RAD';
		DamageTypeHead=class'DTSX45PistolHead_RAD';
		DamageTypeArm=class'DTSX45Pistol_RAD';
		FireRate=0.550000;
		//FlashScaleFactor=FlashScaleFactor*0.750000;
		bFlashAmp1=false;
		bFlashAmp2=true;
		FlashBone=AmpFlashBone;
		RangeAtten=1.000000;
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
		bFlashAmp1=false;
		bFlashAmp2=false;
		FlashBone=FlashBone;
		RangeAtten=default.RangeAtten;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

}

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{	
    local Inv_Slowdown Slow;

    super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
    if (Pawn(Target) != None && Pawn(Target).Health > 0 && Vehicle(Target) == None && bFlashAmp1)
    {
        Slow = Inv_Slowdown(Pawn(Target).FindInventoryType(class'Inv_Slowdown'));

        if (Slow == None)
        {
            Pawn(Target).CreateInventory("BallisticDE.Inv_Slowdown");
            Slow = Inv_Slowdown(Pawn(Target).FindInventoryType(class'Inv_Slowdown'));
        }

        Slow.AddSlow(0.7, 0.35);
    }
	else if (Pawn(Target) != None && Pawn(Target).bProjTarget && bFlashAmp2)
		TryPlague(Target);
}

function bool AllowPlague(Actor Other)
{
	return 
		Pawn(Other) != None 
		&& Pawn(Other).Health > 0 
		&& Vehicle(Other) == None 
		&& (Pawn(Other).GetTeamNum() == 255 || Pawn(Other).GetTeamNum() != Instigator.GetTeamNum())
		&& Level.TimeSeconds - Pawn(Other).SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime;
}

function TryPlague(Actor Other)
{
	local SX45PlagueEffect RPE;
	
	if (AllowPlague(Other))
	{
		foreach Other.BasedActors(class'SX45PlagueEffect', RPE)
		{
			RPE.ExtendDuration(2);
		}
		if (RPE == None)
		{
			RPE = Spawn(class'SX45PlagueEffect',Other,,Other.Location);// + vect(0,0,-30));
			RPE.Initialize(Other);
			if (Instigator!=None)
			{
				RPE.Instigator = Instigator;
				RPE.InstigatorController = Instigator.Controller;
			}
		}
	}
}

//Do the spread on the client side
function PlayFiring()
{

	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'IdleOpen';
		BW.ReloadAnim = 'ReloadOpen';
		AimedFireAnim = 'SightFireOpen';
		FireAnim = 'FireOpen';
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
     Amp1FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.SX45.SX45-FrostFire',Volume=1.200000)
     Amp2FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.SX45.SX45-RadFire',Volume=1.200000)
	 AmpFlashBone="tip2"
     AmpFlashScaleFactor=0.500000
	 FlashBone="tip"
	 FlashScaleFactor=0.9
	 TraceRange=(Min=4000.000000,Max=4000.000000)
     CutOffDistance=2048.000000
     CutOffStartRange=768.000000
	 RangeAtten=0.3
     WallPenetrationForce=8.000000
     Damage=32.000000
     HeadMult=1.5f
     LimbMult=0.5f
     WaterRangeAtten=0.400000
     DamageType=Class'BWBPAnotherPackDE.DTSX45Pistol'
     DamageTypeHead=Class'BWBPAnotherPackDE.DTSX45PistolHead'
     DamageTypeArm=Class'BWBPAnotherPackDE.DTSX45Pistol'
     PenetrateForce=135
     bPenetrate=True
     MuzzleFlashClass=Class'BWBPAnotherPackDE.SX45FlashEmitter'
	 MuzzleFlashClassAmp1=Class'BWBPAnotherPackDE.SX45CryoFlash'
     MuzzleFlashClassAmp2=Class'BWBPAnotherPackDE.SX45RadMuzzleFlash'
     BrassClass=Class'BallisticDE.Brass_Pistol'
     BrassOffset=(X=-14.000000,Z=-5.000000)
     FireRecoil=192.000000
     FireChaos=0.250000
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_SoundsExp.SX45.SX45-Fire',Volume=1.200000)
     bPawnRapidFireAnim=True
	 FireEndAnim=
     FireAnimRate=1
	 AimedFireAnim="SightFire"
     FireRate=0.20000
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_SX45Bullets'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     BotRefireRate=0.750000
}
