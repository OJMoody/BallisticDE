//=============================================================================
// EP90PDW Secondary Fire.
//
// Either a conventional charged shot or an irradiating shot.
//=============================================================================
class EP90PDWSecondaryFire extends BallisticProInstantFire;

var() BUtil.FullSound	ChargeSound;
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
	
	Weapon.AmbientSound = ChargeSound.Sound;
	Weapon.ThirdPersonActor.AmbientSound = ChargeSound.Sound;
	
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

simulated function IgniteActor(Actor A)
{
    local XM84ActorCorrupt PF;
    PF = Spawn(class'XM84ActorCorrupt');
    PF.Instigator = Instigator;
    PF.Initialize(A);
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
    if (xPawn(Victim) != None)
        IgniteActor(Victim);
    
    super.ApplyDamage(Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
    
    if (Mover(Victim) != None || Vehicle(Victim) != None)
        return;
        
    BW.TargetedHurtRadius(60, 256, class'DTXM84GrenadeRadius', 500, HitLocation, Pawn(Victim));
}

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
    BW.TargetedHurtRadius(60, 256, class'DTXM84GrenadeRadius', 500, HitLocation, Pawn(Other));
    return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}

//===================================================
// ApplyDamage
//
// Irradiates struck targets
//===================================================

simulated event ModeDoFire()
{
	if (HoldTime >= ChargeTime || (Level.NetMode == NM_DedicatedServer && HoldTime >= ChargeTime - 0.1))
	{
		super.ModeDoFire();
		Weapon.ThirdPersonActor.AmbientSound = None;
		Weapon.AmbientSound = None;
		DecayCharge = 0;
	}
	else
	{
		DecayCharge = FMin(ChargeTime, HoldTime);
		NextFireTime = Level.TimeSeconds + (DecayCharge * 0.35);
	}
		
	HoldTime = 0;
}

defaultproperties
{
     ChargeSound=(Sound=Sound'BWBPANotherPackSounds.EP110.EP110-OverCharge',Volume=2.00000)
     ChargeSoundPitch=32
     ChargeTime=0.8500000
     MuzzleFlashClass=Class'BWBPAnotherPackDE.EP90PDWFlashEmitter'
	 DryFireSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-Empty',Volume=1.200000)
	 TraceRange=(Max=6000.000000)
	 Damage=50
	 DamageLimb=50
	 DamageHead=50
     RecoilPerShot=960.000000
     FireChaos=0.320000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     BallisticFireSound=(Sound=Sound'BWBPANotherPackSounds.EP110.EP110-Overblast',Volume=7.800000)
	 bPawnRapidFireAnim=True
     bFireOnRelease=True
     MaxHoldTime=2.50000
	 FireAnim="Fire"
	 AimedFireAnim="SightFire"
	 FlashScaleFactor=0.100000
     FireEndAnim=
     FireRate=1.200000
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_EP90HV'
     AmmoPerFire=5
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     BotRefireRate=0.250000
     WarnTargetPct=0.500000
}
