//=============================================================================
// CoachGunAttachment.
//
// 3rd person weapon attachment for my sweaty applejuice
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CoachGunAttachment extends BallisticShotgunAttachment;

var bool		bSlugMode;
var bool		bOldSlugMode;

var byte	SideFireCount, OldSideFireCount;

var bool		Side;

var() class<BCImpactManager>ImpactManagerAlt;		//Impact Manager to use for iATLATmpact effects
var() class<BCTraceEmitter>	TracerClassAlt;		//Type of tracer to use for alt fire effects

var	Actor	MuzzleFlashRight;

var Actor 	sHitActor;
var int 		sHitSurf;
var Vector sHitLocation, sHitNormal, sWaterHitLocation;

replication
{
	// Things the server should send to the client.
	reliable if(Role==ROLE_Authority)
		bSlugMode, SideFireCount;
}

function InitFor(Inventory I)
{
	Super.InitFor(I);
	
	//safe assumption
	if (CoachGun(I).CurrentWeaponMode == 1)
		bSlugMode = True;
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
		
	if (bSlugMode != bOldSlugMode)
		bOldSlugMode = bSlugMode;
		
	if (DirectImpactCount != OldDirectImpactCount)
	{
		DoDirectHit(DirectImpact.HitLoc, class'BUtil'.static.ByteToNorm(DirectImpact.HitNorm), DirectImpact.HitSurf);
		OldDirectImpactCount = DirectImpactCount;
	}
	if (FireCount != OldFireCount)
	{
		FiringMode = 0;
		ThirdPersonEffects();
		OldFireCount = FireCount;
	}
	//2nd barrel
	if (SideFireCount != OldSideFireCount)
	{
		FiringMode = 2;
		ThirdPersonEffects();
		OldSideFireCount = SideFireCount;
	}
	if (AltFireCount != OldAltFireCount)
	{
		FiringMode = 1;
		ThirdPersonEffects();
		OldAltFireCount = AltFireCount;
	}
}

//Called for a Coach double shot
function DoubleUpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, Actor sideHitActor, vector sideHitLocation, vector sideHitNormal, int HitSurf, int sideHitSurf, optional vector WaterHitLoc, optional vector sideWaterHitLoc)
{
	mHitSurf = HitSurf;
	sHitSurf = sideHitSurf;
	
	WaterHitLocation = WaterHitLoc;
	sWaterHitLocation = sideWaterHitLoc;
	
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	FiringMode = 0;
	FireCount++;
	ThirdPersonEffects();
	
	sHitNormal = sideHitNormal;
	sHitActor = sideHitActor;
	sHitLocation = sideHitLocation;
	FiringMode = 2;
	SideFireCount++;
	NetUpdateTime = Level.TimeSeconds - 1;
	ThirdPersonEffects();

}

simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;
	
	if (!bSlugMode)
		ShotgunFireEffects(Mode);
	else 
	// ================== SUPERMAG EFFECTS ===============
	{
		if (InstantMode == MU_None || (InstantMode == MU_Secondary && Mode != 1) || (InstantMode == MU_Primary && Mode == 1))
			return;

		if (mHitLocation == vect(0,0,0))
			return;

		if (Instigator == none)
			return;

		SpawnTracer(Mode, mHitLocation);
		FlyByEffects(Mode, mHitLocation);
		
		if (FiringMode == 0)
		{
			// Client, trace for hitnormal, hitmaterial and hitactor
			if (Level.NetMode == NM_Client)
			{
				mHitActor = None;
				Start = Instigator.Location + Instigator.EyePosition();
		
				if (WallPenetrates != 0)				{
					WallPenetrates = 0;
					DoWallPenetrate(Start, mHitLocation);	}

				Dir = Normal(mHitLocation - Start);
				mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
				// Check for water and spawn splash
				if (ImpactManager!= None && bDoWaterSplash)
				DoWaterTrace(Start, mHitLocation);

				if (mHitActor == None)
					return;
				// Set the hit surface type
				if (Vehicle(mHitActor) != None)
				mHitSurf = 3;
				else if (HitMat == None)
					mHitSurf = int(mHitActor.SurfaceType);
				else
					mHitSurf = int(HitMat.SurfaceType);
			}
			// Server has all the info already...
			else
				HitLocation = mHitLocation;

			if (level.NetMode != NM_Client && ImpactManager!= None && WaterHitLocation != vect(0,0,0) && bDoWaterSplash && Level.DetailMode >= DM_High && class'BallisticMod'.default.EffectsDetailMode > 0)
				ImpactManagerAlt.static.StartSpawn(WaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLocation), 9, Instigator);
			if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
				return;
			if (ImpactManagerAlt != None)
				ImpactManagerAlt.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
		}
		
		else
		{
			// Client, trace for hitnormal, hitmaterial and hitactor
			if (Level.NetMode == NM_Client)
			{
				sHitActor = None;
				Start = Instigator.Location + Instigator.EyePosition();
		
				if (WallPenetrates != 0)				{
					WallPenetrates = 0;
					DoWallPenetrate(Start, sHitLocation);	}

				Dir = Normal(sHitLocation - Start);
				sHitActor = Trace (HitLocation, sHitNormal, sHitLocation + Dir*10, sHitLocation - Dir*10, false,, HitMat);
				// Check for water and spawn splash
				if (ImpactManager!= None && bDoWaterSplash)
				DoWaterTrace(Start, mHitLocation);

				if (sHitActor == None)
					return;
				// Set the hit surface type
				if (Vehicle(sHitActor) != None)
				sHitSurf = 3;
				else if (HitMat == None)
					sHitSurf = int(sHitActor.SurfaceType);
				else
					sHitSurf = int(HitMat.SurfaceType);
			}
			// Server has all the info already...
			else
				HitLocation = sHitLocation;

			if (level.NetMode != NM_Client && ImpactManager!= None && sWaterHitLocation != vect(0,0,0) && bDoWaterSplash && Level.DetailMode >= DM_High && class'BallisticMod'.default.EffectsDetailMode > 0)
				ImpactManagerAlt.static.StartSpawn(sWaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - sWaterHitLocation), 9, Instigator);
			if (sHitActor == None || (!sHitActor.bWorldGeometry && Mover(sHitActor) == None && Vehicle(sHitActor) == None))
				return;
			if (ImpactManagerAlt != None)
				ImpactManagerAlt.static.StartSpawn(HitLocation, sHitNormal, sHitSurf, instigator);
		}

	}
}
// Do trace to find impact info and then spawn the effect
simulated function ShotgunFireEffects(byte Mode)
{
	local Vector HitLocation, Start, End;
	local Rotator R;
	local Material HitMat;
	local int i;
	local float XS, YS, RMin, RMax, Range, fX;

	if (Level.NetMode == NM_Client && FireClass != None)
	{
		XS = FireClass.default.XInaccuracy; YS = Fireclass.default.YInaccuracy;
		if (!bScoped)
		{
			XS *= FireClass.static.GetAttachmentDispersionFactor();
			YS *= FireClass.static.GetAttachmentDispersionFactor();
		}
		RMin = FireClass.default.TraceRange.Min; RMax = FireClass.default.TraceRange.Max;
		Start = Instigator.Location + Instigator.EyePosition();
		for (i=0;i<FireClass.default.TraceCount;i++)
		{
			mHitActor = None;
			Range = Lerp(FRand(), RMin, RMax);
			R = Rotator(mHitLocation);
			switch (FireClass.default.FireSpreadMode)
			{
				case FSM_Scatter:
					fX = frand();
					R.Yaw +=   XS * (frand()*2-1) * sin(fX*1.5707963267948966);
					R.Pitch += YS * (frand()*2-1) * cos(fX*1.5707963267948966);
					break;
				case FSM_Circle:
					fX = frand();
					R.Yaw +=   XS * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
					R.Pitch += YS * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
					break;
				default:
					R.Yaw += ((FRand()*XS*2)-XS);
					R.Pitch += ((FRand()*YS*2)-YS);
					break;
			}
			End = Start + Vector(R) * Range;
			mHitActor = Trace (HitLocation, mHitNormal, End, Start, false,, HitMat);
			if (mHitActor == None)
			{
				DoWaterTrace(Start, End);
				SpawnTracer(Mode, End);
			}
			else
			{
				DoWaterTrace(Start, HitLocation);
				SpawnTracer(Mode, HitLocation);
			}

			if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None))
				continue;

			if (HitMat == None)
				mHitSurf = int(mHitActor.SurfaceType);
			else
				mHitSurf = int(HitMat.SurfaceType);

			if (ImpactManager != None)
				ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, self);
		}
	}
}

// Spawn a tracer and water tracer
simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;
	local bool bThisShot;

	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetTipLocation();
	Dist = VSize(V - TipLoc);

	// Count shots to determine if it's time to spawn a tracer
	if (TracerMix == 0)
		bThisShot=true;
	else
	{
		TracerCounter++;
		if (TracerMix < 0)
		{
			if (TracerCounter >= -TracerMix)	{
				TracerCounter = 0;
				bThisShot=false;			}
			else
				bThisShot=true;
		}
		else if (TracerCounter >= TracerMix)	{
			TracerCounter = 0;
			bThisShot=true;					}
	}
	// Spawn a tracer for the appropriate mode
	if (TracerClass != None && bThisShot && (TracerChance >= 1 || FRand() < TracerChance) )
	{
		if (Dist > 200)
		{
			if (!bSlugMode)
				Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
			else Tracer = Spawn(TracerClassAlt, self, , TipLoc, Rotator(V - TipLoc));
		}
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn under water bullet effect
	if ( Instigator != None && Instigator.PhysicsVolume.bWaterVolume && level.DetailMode == DM_SuperHigh && WaterTracerClass != None &&
		 WaterTracerMode != MU_None && (WaterTracerMode == MU_Both || (WaterTracerMode == MU_Secondary && Mode == 1) || (WaterTracerMode == MU_Primary && Mode != 1)))
	{
		if (!Instigator.PhysicsVolume.TraceThisActor(WLoc, WNorm, TipLoc, V))
			Tracer = Spawn(WaterTracerClass, self, , TipLoc, Rotator(WLoc - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(VSize(WLoc - TipLoc));
	}
}

// Return the location of the muzzle.
simulated function Vector GetTipLocation()
{
    local Coords C;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
	{
		if (FiringMode == 2)
			C = Instigator.Weapon.GetBoneCoords('tip');
		else C = Instigator.Weapon.GetBoneCoords('Tip2');
	}
	else
	{
		if (FiringMode == 0)
			C = GetBoneCoords(FlashBone);
		else C = GetBoneCoords(AltFlashBone);
	}
	if (Instigator != None && level.NetMode != NM_StandAlone && level.NetMode != NM_ListenServer && VSize(C.Origin - Instigator.Location) > 300)
		return Instigator.Location;
    return C.Origin;
}

// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode != 1) || (FlashMode == MU_Primary && Mode == 1))
		return;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (bRandomFlashRoll)
		R.Roll = Rand(65536);

	if (Mode == 1 && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
		{
			if (!Side)
				class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
			else 	class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		}
		AltMuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	else if (MuzzleFlashClass != None)
	{
		if(Mode == 0)
		{
			if (MuzzleFlash == None)
				class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
			MuzzleFlash.Trigger(self, Instigator);
			if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
		}
		else if (Mode == 2)
		{
			if (MuzzleFlashRight == None)
				class'BUtil'.static.InitMuzzleFlash (MuzzleFlashRight, MuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
			MuzzleFlashRight.Trigger(self, Instigator);
			if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
		}
	}
}

simulated function EjectBrass(byte Mode);

defaultproperties
{
     ImpactManagerAlt=Class'BWBPArchivePackDE.IM_ExpBullet'
     TracerClassAlt=Class'BWBPArchivePackDE.TraceEmitter_X83AM'
     FireClass=Class'BWBPArchivePackDE.CoachGunPrimaryFire'
     MuzzleFlashClass=Class'BallisticDE.MRT6FlashEmitter'
     ImpactManager=Class'BallisticDE.IM_Shell'
     MeleeImpactManager=Class'BallisticDE.IM_GunHit'
     FlashBone="Tip1"
     AltFlashBone="tip2"
     FlashScale=1.500000
     BrassClass=Class'BallisticDE.Brass_MRS138Shotgun'
     TrackAnimMode=MU_Secondary
     TracerClass=Class'BallisticDE.TraceEmitter_Shotgun'
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.TP_DoubleShotgun'
     RelativeLocation=(X=5.000000,Z=4.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.450000
 	 SingleFireAnim="Reload_BreakOpenFast"
     SingleAimedFireAnim="Reload_BreakOpenFast"
     RapidFireAnim="Reload_BreakOpenFast"
     RapidAimedFireAnim="Reload_BreakOpenFast"
	 ReloadAnim="Reload_BreakOpen"
}
