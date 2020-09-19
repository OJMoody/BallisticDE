//=============================================================================
// CYLOAttachment.
//
// 3rd person weapon attachment for CYLO Versitile UAW
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M30Attachment extends BallisticAttachment;

var() class<BCTraceEmitter>	AltTracerClass;

// Spawn a tracer and water tracer
simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;
	local bool bThisShot;

	if (class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetTipLocation();
	Dist = VSize(V - TipLoc);

	// Count shots to determine if it's time to spawn a tracer
	if (TracerMix == 0)
		bThisShot=true;

	// Spawn a tracer
	if (TracerClass != None && TracerMode != MU_None && (TracerMode == MU_Both && Mode == 0) && bThisShot && (TracerChance >= 1 || FRand() < TracerChance))
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn an alt tracer
	if (AltTracerClass != None && TracerMode != MU_None && (TracerMode == MU_Both && Mode != 0) && bThisShot && (TracerChance >= 1 || FRand() < TracerChance))
	{
		if (Dist > 200)
			Tracer = Spawn(AltTracerClass, self, , TipLoc, Rotator(V - TipLoc));
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
	 AltTracerClass=Class'BallisticJiffyPackE.TraceEmitter_M30Gauss'
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     MeleeImpactManager=Class'BallisticProV55.IM_Knife'
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassMode=MU_Both
     FlashMode=MU_Both
     InstantMode=MU_Both
	 TracerMode=MU_Both
	 TracerMix=0
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     IdleHeavyAnim="PistolHip_Idle"
     IdleRifleAnim="PistolAimed_Idle"
     SingleFireAnim="PistolHip_Fire"
     SingleAimedFireAnim="PistolAimed_Fire"
     RapidFireAnim="PistolHip_Burst"
     RapidAimedFireAnim="PistolAimed_Burst"	 
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.CYLO-3rd'
     RelativeLocation=(Z=1.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.300000
}
