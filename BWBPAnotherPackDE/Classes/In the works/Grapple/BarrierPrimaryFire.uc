//=============================================================================
// AK47PrimaryFire.
//
// High powered automatic fire. Hits like the SRS but has less accuracy.
// Good for close and mid range, bad at long range.
// Has better than average penetration.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BarrierPrimaryFire extends BallisticProjectileFire;

var() Sound	ChargeSound;
var()	byte		ChargeSoundPitch;
var() float		ChargeTime, DecayCharge;

simulated function vector GetFireSpread()
{
	local float fX;
	local Rotator R;

	if (BW.bScopeView)
		return super.GetFireSpread();
	else
	{
		fX = frand();
		R.Yaw =  1536 * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
		R.Pitch = 1536 * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
		return Vector(R);
	}
}

simulated function PlayStartHold()
{
	HoldTime = FMax(DecayCharge,0.1);
	
	Weapon.AmbientSound = ChargeSound;
	Weapon.ThirdPersonActor.AmbientSound = ChargeSound;
	
	Weapon.SoundVolume = 48 + FMin(ChargeTime, HoldTime)/ChargeTime * 128;
	Weapon.SoundPitch = ChargeSoundPitch + FMin(ChargeTime, HoldTime)/ChargeTime * ChargeSoundPitch;
	
	Weapon.ThirdPersonActor.SoundVolume = 48 + FMin(ChargeTime, HoldTime)/ChargeTime * 128;
	Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch + FMin(ChargeTime, HoldTime)/ChargeTime * ChargeSoundPitch;
	BW.bPreventReload=True;
}

simulated function ModeTick(float DeltaTime)
{
	Super.ModeTick(DeltaTime);
	
	if (bIsFiring)
	{
		Weapon.ThirdPersonActor.SoundVolume = 48 + FMin(ChargeTime, HoldTime)/ChargeTime * 128;
		Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch + FMin(ChargeTime, HoldTime)/ChargeTime * ChargeSoundPitch;
		
		Weapon.SoundVolume = 48 + FMin(ChargeTime, HoldTime)/ChargeTime * 128;
		Weapon.SoundPitch = ChargeSoundPitch + FMin(ChargeTime, HoldTime)/ChargeTime * ChargeSoundPitch;
	}
	else if (DecayCharge > 0)
	{
		Weapon.ThirdPersonActor.SoundVolume = 48 + FMin(ChargeTime, DecayCharge)/ChargeTime * 128;
		Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch + FMin(ChargeTime, DecayCharge)/ChargeTime * ChargeSoundPitch;
		
		Weapon.SoundVolume = 48 + FMin(ChargeTime, DecayCharge)/ChargeTime * 128;
		Weapon.SoundPitch = ChargeSoundPitch + FMin(ChargeTime, DecayCharge)/ChargeTime * ChargeSoundPitch;
		DecayCharge -= DeltaTime * 2.5;
		
		if (DecayCharge < 0)
		{
			DecayCharge = 0;
			Weapon.ThirdPersonActor.AmbientSound = None;
			Weapon.AmbientSound = None;
		}
	}
}

defaultproperties
{
     MaxHoldTime=5.00000
	 ChargeSound=Sound'IndoorAmbience.machinery18'
	 ChargeSoundPitch=32
	 ChargeTime=3.000000
	 
	 SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
     MuzzleFlashClass=Class'BallisticDE.A42FlashEmitter'
     RecoilPerShot=64.000000
     FireChaos=0.130000
	 FlashBone="Tip"
	 FlashScaleFactor=0.3
     BallisticFireSound=(Sound=Sound'BallisticSounds3.A42.A42-Fire',Volume=0.700000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.700000
	 FireAnim="Fire"
	 AimedFireAnim="SightFire"
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_KineticCharge'
     AmmoPerFire=10
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBPAnotherPackDE.BarrierPriProjectile'
     WarnTargetPct=0.300000
}
