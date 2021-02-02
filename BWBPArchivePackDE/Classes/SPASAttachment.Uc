//=============================================================================
// SPASAttachment.
//
// 3rd person weapon attachment for SPAS Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SPASAttachment extends BallisticShotgunAttachment;

simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (AltMuzzleFlashClass != None && AltMuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
	if (MuzzleFlashClass != None && MuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);

	R = Instigator.Rotation;
	R.Pitch = Rotation.Pitch;
	if (Mode == 0 || Mode == 2)
	{
		if (class'BallisticMod'.default.bMuzzleSmoke)
			Spawn(class'MRT6Smoke',,, AltMuzzleFlash.Location, R);
		AltMuzzleFlash.Trigger(self, Instigator);
	}
	if (Mode == 0 || Mode == 1)
	{
		if (class'BallisticMod'.default.bMuzzleSmoke)
			Spawn(class'MRT6Smoke',,, MuzzleFlash.Location, R);
		MuzzleFlash.Trigger(self, Instigator);
	}

}

function SPASUpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, int HitSurf, optional bool bIsRight)
{
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	if (bIsRight)
		FiringMode = 2;
	else
		FiringMode = 1;
	FireCount++;
	ThirdPersonEffects();
}

defaultproperties
{
     FireClass=Class'BWBPArchivePackDE.SPASPrimaryFire'
     MuzzleFlashClass=Class'BallisticDE.MRT6FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticDE.MRT6FlashEmitter'
     ImpactManager=Class'BallisticDE.IM_Shell'
     FlashScale=2.300000
     BrassClass=Class'BallisticDE.Brass_Shotgun'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticDE.TraceEmitter_Shotgun'
     TracerChance=0.500000
     Mesh=SkeletalMesh'BWBP_JCF_Anims.SPAS_TPm'
     DrawScale=0.300000
}
