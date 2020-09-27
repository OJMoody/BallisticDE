//=============================================================================
// FMP Attachment
//
// FMP-2012's 3rd
//=============================================================================
class FMPAttachment extends BallisticAttachment;

var() class<BCImpactManager>ImpactManagerAlt;		//Impact Manager to use for iATLATmpact effects
var() class<BCTraceEmitter>	TracerClassAlt;		//Type of tracer to use for alt fire effects
var bool		bSilenced;
var bool		bOldSilenced;

replication
{
	// Things the server should send to the client.
	reliable if(Role==ROLE_Authority)
		bSilenced;
}

simulated event PostNetReceive()
{
	if (bSilenced != bOldSilenced)
	{
		bOldSilenced = bSilenced;
		if (bSilenced)
			SetBoneScale (0, 1.0, 'Muzzle2');
		else
			SetBoneScale (0, 0.0, 'Muzzle2');
	}
	Super.PostNetReceive();
}

function IAOverride(bool bSilenced)
{
	if (bSilenced)
		SetBoneScale (0, 1.0, 'Muzzle2');
	else
		SetBoneScale (0, 0.0, 'Muzzle2');
}



// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	if (InstantMode == MU_None || (InstantMode == MU_Secondary && Mode == 0) || (InstantMode == MU_Primary && Mode != 0))
		return;
	if (mHitLocation == vect(0,0,0))
		return;
	if (Instigator == none)
		return;
	SpawnTracer(Mode, mHitLocation);
	FlyByEffects(Mode, mHitLocation);
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
		ImpactManager.static.StartSpawn(WaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLocation), 9, Instigator);
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (ImpactManager != None && (!bSilenced || Mode == 0))
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	if (ImpactManagerAlt != None && (bSilenced || Mode == 1))
		ImpactManagerAlt.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
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
	// Spawn a tracer
	if (TracerClassAlt != None && bThisShot && (bSilenced || Mode == 1))
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClassAlt, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	else if (TracerClass != None && bThisShot && (!bSilenced || Mode == 0))
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn under water bullet effect
	if ( Instigator != None && Instigator.PhysicsVolume.bWaterVolume && level.DetailMode == DM_SuperHigh && WaterTracerClass != None &&
		 WaterTracerMode != MU_None && (WaterTracerMode == MU_Both || (WaterTracerMode == MU_Secondary && Mode != 0) || (WaterTracerMode == MU_Primary && Mode == 0)))
	{
		if (!Instigator.PhysicsVolume.TraceThisActor(WLoc, WNorm, TipLoc, V))
			Tracer = Spawn(WaterTracerClass, self, , TipLoc, Rotator(WLoc - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(VSize(WLoc - TipLoc));
	}
}

defaultproperties
{
     ImpactManagerAlt=Class'BWBPArchivePackDE.IM_BulletHE'
     TracerClassAlt=Class'BWBPArchivePackDE.TraceEmitter_HMG'
     MuzzleFlashClass=Class'BWBPArchivePackDE.FMPFlashEmitter'
     AltMuzzleFlashClass=Class'BWBPArchivePackDE.FMPFlashEmitter'
     ImpactManager=Class'BallisticDE.IM_Bullet'
     BrassClass=Class'BallisticDE.Brass_Rifle'
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
	 FlashScale=0.5
     TracerClass=Class'BWBPRecolorsDE.TraceEmitter_MARS'
     TracerMix=0
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BWBPArchivePack2Anim.TP_MP40'
     RelativeLocation=(Z=3.000000)
     RelativeRotation=(Yaw=32768,Roll=-16384)
     DrawScale=0.50000
}
