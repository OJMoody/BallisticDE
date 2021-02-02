//=============================================================================
// SX45Attachment.
// 
// TheXavious: Is the AMP our magical "well now this thing can arbitrarily use alternate damage bullets" device?
// Jiffy: yes
// Sergeant Kelly: yes
// TheXavious: yes
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SX45Attachment extends HandgunAttachment;

var bool		bLightsOn, bLightsOnOld;
var Projector	FlashLightProj;
var Emitter		FlashLightEmitter;

var() class<BCImpactManager>ImpactManagerAmp1;		
var() class<BCImpactManager>ImpactManagerAmp2;		
var() class<BCTraceEmitter>	TracerClassAmp1;		
var() class<BCTraceEmitter>	TracerClassAmp2;		
var() class<actor>			MuzzleFlashClassAmp1;	
var   actor					MuzzleFlashAmp1;		
var() class<actor>			MuzzleFlashClassAmp2;
var   actor					MuzzleFlashAmp2;

var() array<Material> CamoMaterials; //We're using this for the amp
		
var bool		bAmp1, bOldAmp1;	//cryo
var bool		bAmp2, bOldAmp2;	//RAD
var bool		bAmped, bOldAmped;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLightsOn, bAmp1, bAmp2, bAmped;
}

//Do your camo changes here
simulated function PostNetBeginPlay()
{
	SetBoneScale (0, 0.0, 'AMP');
}

// ============ Amplifier ========================

simulated event PostNetReceive()
{
	if (bAmped != bOldAmped)	//amped
	{
		bOldAmped = bAmped;
		if (bAmped)
			SetBoneScale (0, 1.0, 'AMP');
		else
			SetBoneScale (0, 0.0, 'AMP');
	}
	if (bAmp1 != bOldAmp1)	//cryo
	{
		bOldAmp1 = bAmp1;
		if (bAmped && bAmp1)
		{
			Skins[5]=CamoMaterials[1];
			Skins[6]=CamoMaterials[2];
		}
	}
	if (bAmp2 != bOldAmp2)	//RAD
	{
		bOldAmp2 = bAmp2;
		if (bAmped && bAmp1)
		{
			Skins[5]=CamoMaterials[0];
			Skins[6]=CamoMaterials[3];
		}
	}
	Super.PostNetReceive();
}

simulated function SetAmped(bool bIsAmped)
{
	bAmped = bIsAmped;
	
	if (bAmped)
		SetBoneScale (0, 1.0, 'AMP');
	else
		SetBoneScale (0, 0.0, 'AMP');
}

simulated function SetAmpColour(bool bIsAmp1, bool bIsAmp2)
{
	bAmp1 = bIsAmp1;
	bAmp2 = bIsAmp2;
	
	//set skins
	if (bAmped && bAmp1)	//cryo
	{
		Skins[5]=CamoMaterials[1];
		Skins[6]=CamoMaterials[2];
	}
	if (bAmped && bAmp2)	//RAD
	{
		Skins[5]=CamoMaterials[0];
		Skins[6]=CamoMaterials[3];
	}
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
		
	if (ImpactManagerAmp1 != None && bAmped && bAmp1)
		ImpactManagerAmp1.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	else if (ImpactManagerAmp2 != None && bAmped && bAmp2)
		ImpactManagerAmp2.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	else if (ImpactManager != None)
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
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
	if (TracerClassAmp1 != None && bThisShot && bAmp1 && bAmped)
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClassAmp1, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn a tracer
	if (TracerClassAmp1 != None && bThisShot && bAmp2 && bAmped)
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClassAmp2, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	else if (TracerClass != None && bThisShot && !bAmped)
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

// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (bRandomFlashRoll)
		R.Roll = Rand(65536);

	if (MuzzleFlashClassAmp1 != None && bAmp1 && bAmped)
	{
		if (MuzzleFlashAmp1 == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp1, MuzzleFlashClassAmp1, DrawScale*FlashScale, self, AltFlashBone);
		MuzzleFlashAmp1.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	if (MuzzleFlashClassAmp2 != None && bAmp2 && bAmped)
	{
		if (MuzzleFlashAmp2 == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp2, MuzzleFlashClassAmp2, DrawScale*FlashScale, self, AltFlashBone);
		MuzzleFlashAmp2.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	if (MuzzleFlashClass != None && !bAmped)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
}

// ============ Flash Light ======================

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	SwitchFlashLight();
	if (NewbHidden)
	{
		KillProjector();
		if (FlashLightEmitter!=None)
			FlashLightEmitter.Destroy();
	}
	else if (bLightsOn)
	{
		SwitchFlashLight();
	}
}

simulated function StartProjector()
{
	if (FlashLightProj == None)
		FlashLightProj = Spawn(class'MRS138TorchProjector',self,,location);
	AttachToBone(FlashLightProj, 'tip2');
	FlashLightProj.SetRelativeLocation(vect(-32,0,0));
}
simulated function KillProjector()
{
	if (FlashLightProj != None)
	{
		FlashLightProj.Destroy();
		FlashLightProj = None;
	}
}

simulated function SwitchFlashLight ()
{
	if (bLightsOn)
	{
		if (FlashLightEmitter == None)
		{
			FlashLightEmitter = Spawn(class'MRS138TorchEffect',self,,location);
			class'BallisticEmitter'.static.ScaleEmitter(FlashLightEmitter, DrawScale);
			AttachToBone(FlashLightEmitter, 'tip2');
			FlashLightEmitter.bHidden = false;
			FlashLightEmitter.bCorona = true;
		}
		if (!Instigator.IsFirstPerson())
			StartProjector();
	}
	else
	{
		FlashLightEmitter.Destroy();
		KillProjector();
	}
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (bLightsOn != bLightsOnOld)	
	{
		SwitchFlashLight();
		bLightsOnOld = bLightsOn;	
	}
	if (!bLightsOn)
		return;

	if (Instigator.IsFirstPerson())
	{
		KillProjector();
		if (FlashLightEmitter != None && FlashLightEmitter.bCorona)
			FlashLightEmitter.bCorona = false;
	}
	else
	{
		if (FlashLightProj == None)
			StartProjector();
		if (FlashLightEmitter != None && !FlashLightEmitter.bCorona)
			FlashLightEmitter.bCorona = true;
	}
}

simulated function Destroyed()
{
	if (FlashLightEmitter != None)
		FlashLightEmitter.Destroy();
	KillProjector();
	super.Destroyed();
}

defaultproperties
{
	 CamoMaterials[0]=Shader'BWBP_SKC_Tex.AMP.Amp-FinalYellow'
	 CamoMaterials[1]=Shader'BWBP_SKC_Tex.AMP.Amp-FinalCyan'
	 CamoMaterials[2]=Shader'BWBP_SKC_Tex.Amp.Amp-GlowCyanShader'
     CamoMaterials[3]=Shader'BWBP_SKC_Tex.Amp.Amp-GlowYellowShader'

     MuzzleFlashClassAmp1=Class'BWBPAnotherPackDE.SX45CryoFlash'
     MuzzleFlashClassAmp2=Class'BWBPAnotherPackDE.SX45RadMuzzleFlash'
	 
	 MuzzleFlashClass=Class'BWBPAnotherPackDE.SX45FlashEmitter'
     AltMuzzleFlashClass=Class'BWBPAnotherPackDE.SX45FlashEmitter'
     ImpactManager=Class'BallisticDE.IM_Bullet'
     AltFlashBone="tip2"
     BrassClass=Class'BallisticDE.Brass_Pistol'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BallisticDE.TraceEmitter_Default'
	 TracerClassAmp1=Class'BWBPAnotherPackDE.TraceEmitter_FreezeBig'
     TracerClassAmp2=Class'BWBPRecolorsDE.TraceEmitter_HMG'
	 ImpactManagerAmp1=Class'BWBPAnotherPackDE.IM_BulletFrostHE'
     ImpactManagerAmp2=Class'BWBPAnotherPackDE.IM_BulletRad'
     TracerMix=-3
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.SX45_TPm'
     DrawScale=1.000000
}
