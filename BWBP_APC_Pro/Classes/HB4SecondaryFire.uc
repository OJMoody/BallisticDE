//=============================================================================
// AM67SecondaryFire.
//
// A special attack that causes a blinding flash and motion blur for players
// and has a stun effect on bots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HB4SecondaryFire extends BallisticFire;

var() Sound	ChargeSound;
var()	byte		ChargeSoundPitch;
var() float		DecayCharge;

function float MaxRange()
{
	return 1200;
}

function PlayStartHold()
{
	HoldTime = FMax(DecayCharge,0.1);
	
	Weapon.AmbientSound = ChargeSound;
	Weapon.ThirdPersonActor.AmbientSound = ChargeSound;
	
	Weapon.SoundVolume = 48 + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * 128;
	Weapon.SoundPitch = ChargeSoundPitch + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * ChargeSoundPitch;
	
	Weapon.ThirdPersonActor.SoundVolume = 48 + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * 128;
	Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * ChargeSoundPitch;
	
	BW.bPreventReload=True;
}

function ModeTick(float DeltaTime)
{
	Super.ModeTick(DeltaTime);
	
	if (bIsFiring)
	{
		Weapon.ThirdPersonActor.SoundVolume = 48 + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * 128;
		Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * ChargeSoundPitch;
		
		Weapon.SoundVolume = 48 + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * 128;
		Weapon.SoundPitch = ChargeSoundPitch + FMin(MaxHoldTime, HoldTime)/MaxHoldTime * ChargeSoundPitch;
	}
	else if (DecayCharge > 0)
	{
		Weapon.ThirdPersonActor.SoundVolume = 48 + FMin(MaxHoldTime, DecayCharge)/MaxHoldTime * 128;
		Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch + FMin(MaxHoldTime, DecayCharge)/MaxHoldTime * ChargeSoundPitch;
		
		Weapon.SoundVolume = 48 + FMin(MaxHoldTime, DecayCharge)/MaxHoldTime * 128;
		Weapon.SoundPitch = ChargeSoundPitch + FMin(MaxHoldTime, DecayCharge)/MaxHoldTime * ChargeSoundPitch;
		DecayCharge -= DeltaTime * 2.5;
		
		if (DecayCharge < 0)
		{
			DecayCharge = 0;
			Weapon.ThirdPersonActor.AmbientSound = None;
			Weapon.AmbientSound = None;
		}
	}
}	

simulated event ModeDoFire()
{
	if (HoldTime >= MaxHoldTime || (Level.NetMode == NM_DedicatedServer && HoldTime >= MaxHoldTime - 0.1))
	{
		super.ModeDoFire();
		Weapon.ThirdPersonActor.AmbientSound = None;
		Weapon.AmbientSound = None;
		DecayCharge = 0;
	}
	else
	{
		DecayCharge = HoldTime;
		NextFireTime = Level.TimeSeconds + (DecayCharge * 0.35);
	}

	HoldTime = 0;
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

//Do the spread on the client side
function PlayFiring()
{
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

function DoFireEffect()
{
	local Controller C;
    local Vector StartTrace, Dir, EnemyEye;
    local float DF, Dist, EnemyDF;
    local int i;
    local HB4ViewMesser VM;

	Dir = GetFireSpread() >> GetFireAim(StartTrace);

	for (C=Level.ControllerList;C!=None;C=C.NextController)
	{
		if (C.Pawn == None || C.Pawn.Health <= 0)
			continue;
		EnemyEye = C.Pawn.EyePosition() + C.Pawn.Location;
		Dist = VSize(EnemyEye - StartTrace);
		DF = Dir Dot Normal(EnemyEye - StartTrace);
		if (DF > 0.8 && Dist < 1200 && Weapon.FastTrace(EnemyEye, StartTrace))
		{
			EnemyDF = Normal(StartTrace - EnemyEye) Dot vector(C.Pawn.GetViewRotation());
			EnemyDF = (EnemyDF+1)/2;
			if (EnemyDF < -0.7)
				EnemyDF = 0.1;
			DF = (DF-0.8)*5;
			if (Dist > 500)
				DF /= 1+(Dist-500)/700;
			DF *= EnemyDF;
			if (PlayerController(C) != None)
			{
				for (i=0;i<C.Attached.length;i++)
					if (HB4ViewMesser(C.Attached[i]) != None)
					{
						VM = HB4ViewMesser(C.Attached[i]);
						break;
					}
				if (VM == None)
				{
					VM = Spawn(class'HB4ViewMesser', C);
					VM.SetBase(C);
				}
				VM.AddImpulse(DF);
			}
			else if (AIController(C) != None && DF > 0.1)
			{
				class'BC_BotStoopidizer'.static.DoBotStun(AIController(C), 2*DF, 12*DF);
			}
		}
	}

	SendFireEffect(None, StartTrace + Dir * 1000, -Dir, 0);
	Super.DoFireEffect();
}

defaultproperties
{
     ChargeSound=Sound'BW_Core_WeaponSound.A73.A73ProjFly'
     ChargeSoundPitch=32
     bUseWeaponMag=False
     FlashBone="tip2"
     //EffectString="Blinding flash"
     bFireOnRelease=True
     bModeExclusive=False
     AmmoClass=Class'BWBP_APC_Pro.Ammo_HB4'

	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.3
}
