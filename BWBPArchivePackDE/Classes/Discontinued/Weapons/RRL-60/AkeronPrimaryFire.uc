//=============================================================================
// Akeron Primary Fire.
//
// If weapon lacks a target, fires stream rockets.
// If weapon has a target, fires homing stream rockets.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AkeronPrimaryFire extends BallisticProProjectileFire;

var array<Actor> MuzzleFlashes[3];
var array<Name> FlashBones[3];
var byte Index;

// Effect related functions ------------------------------------------------
// Spawn the muzzleflash actor
function InitEffects()
{
	local int i;
	if (AIController(Instigator.Controller) != None)
		return;
    if (MuzzleFlashClass != None)
	{
		for (i=0; i<3; i++)
		{
			if (MuzzleFlashes[i] == None || MuzzleFlashes[i].bDeleteMe)
				class'BUtil'.static.InitMuzzleFlash (MuzzleFlashes[i], MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBones[i]);
		}
	}
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (MuzzleFlashes[Index] != None)
        MuzzleFlashes[Index].Trigger(Weapon, Instigator);
		
	Index++;
	if (Index > 2)
		Index = 0;

	if (!bBrassOnCock)
		EjectBrass();
}

// Remove effects
simulated function DestroyEffects()
{
	local int i;
	Super(WeaponFire).DestroyEffects();

	for (i=0; i<3; i++)
	{
		class'BUtil'.static.KillEmitterEffect (MuzzleFlashes[i]);
		MuzzleFlashes[i] = None;
	}
}

simulated event ModeDoFire()
{
    if (!AllowFire())
        return;

	if (class'BallisticReplicationInfo'.default.bNoReloading && BW.AmmoAmount(0) > 1)
	{
		Weapon.SetBoneScale (1, 1.0, 'RocketBone');
		Weapon.ThirdPersonActor.SetBoneScale (1, 1.0, 'RocketBone');
	}
	else if (BW.MagAmmo < 2)
	{
		Weapon.SetBoneScale (1, 0.0, 'RocketBone');
		Weapon.ThirdPersonActor.SetBoneScale (1, 0.0, 'RocketBone');
	}
	Super.ModeDoFire();
}

function DoFireEffect()
{	
	if (AkeronLauncher(Weapon).bLaserOn && !AkeronLauncher(Weapon).bScopeView)
		ProjectileClass = class'G5SeekerRocket';
	else	ProjectileClass = class'AkeronRocket';
	Super.DoFireEffect();
}

defaultproperties
{
     FlashBones(0)="RocketHelper1"
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     MuzzleFlashClass=Class'BallisticDE.G5FlashEmitter'
     RecoilPerShot=256.000000
     FireChaos=0.500000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.G5.G5-Fire1')
     FireEndAnim=
     FireRate=0.850000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_Akeron'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.500000
     ProjectileClass=Class'BWBPArchivePackDE.AkeronRocket'
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=True
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.5
     WarnTargetPct=0.25
}
