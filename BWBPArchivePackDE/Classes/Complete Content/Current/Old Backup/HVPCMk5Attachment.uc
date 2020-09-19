//=============================================================================
// LightningAttachment.
//
// 3rd person weapon attachment for HVC-Mk9 Lightning Gun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVPCMk5Attachment extends BallisticAttachment;



var Actor 		Pack;			// The Backpack
var Emitter		FreeZap;
var HVCMk9_TrackingZap TargetZap;

var actor		ZapTargets[6];						// List of targets from server
var vector		ZapLures[3];						// 'wall hits' to which lightning is lured
var byte		TargZapCount, TargZapCountOld;		// Update counters
var byte		FreeZapCount, FreeZapCountOld;
var byte		KillZapCount, KillZapCountOld;
var bool		bDischarge, bDischargeOld;
var byte		ChargePower;						// Power of secondary zap sent from server
var HVPCMk5PlasmaCannon	LG;							// Access to the lightning gun itself (only available to owner)

var Actor	Arc1;			// Decorative arc effects
var Actor	Arc2;
var Actor	Arc3;

var array<actor>	OldTargets;		// List of last targets sent to client (used by server only)
var array<vector>	OldLures;		// List of last lures sent to client (used by server only)

var() Sound DischargeSound;			// Sound of water discharge

replication
{
	reliable if (Role==ROLE_Authority && bNetDirty)
		ZapTargets, TargZapCount, FreeZapCount, KillZapCount, bDischarge, ChargePower, ZapLures;
	reliable if (Role==ROLE_Authority && bNetOwner && bNetInitial)
		LG;
}

simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	Super.SetOverlayMaterial(mat, time, bOverride);
	if ( Pack != None )
		Pack.SetOverlayMaterial(mat, time, bOverride);
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	if (Pack!= None)
		Pack.bHidden = NewbHidden;
}

simulated event PostNetReceive()
{
	if (bDischarge != bDischargeOld)		{	bDischargeOld = bDischarge;
		DoWaterDischarge();					}
	if (TargZapCount != TargZapCountOld)	{	TargZapCountOld = TargZapCount;
		ClientReceiveTargets();				}
	if (FreeZapCount != FreeZapCountOld)	{	FreeZapCountOld = FreeZapCount;
		SetFreeZap();						}
	if (KillZapCount != KillZapCountOld)	{	KillZapCountOld = KillZapCount;
		KillZap();							}
	super.PostNetReceive();
}

function InitFor(Inventory I)
{
	Super.InitFor(I);
	if (I != None && HVPCMk5PlasmaCannon(I) != None)
		LG = HVPCMk5PlasmaCannon(I);
}

simulated function ClientReceiveTargets()
{
	local int i;
	local array<actor> Ts;
	local array<vector> Vs;

	for (i=0;i<6;i++)
		if (ZapTargets[i] != None)
			Ts[Ts.length] = ZapTargets[i];
	for (i=0;i<3;i++)
		if (ZapLures[i] != vect(0,0,0))
			Vs[Vs.length] = ZapLures[i];
	SetTargetZap(Ts, Vs);
}

function ServerSendTargets(array<actor> Ts, array<vector> Vs)
{
	local int i;

	if (Ts.length == OldTargets.length)
	{	for (i=0;i<Ts.length;i++)
			if (Ts[i] != OldTargets[i])
				break;
		if (i>=Ts.length)
			i = 666;
//			return;
	}
	if (i != 666)
	{
		for (i=0;i<6;i++)
		{
			if (i >= Ts.length || Ts[i] == None)
				ZapTargets[i] = None;
			else
				ZapTargets[i] = Ts[i];
		}
	}
	i=0;
	if (Vs.length == OldLures.Length)
	{
		for (i=0;i<Vs.length;i++)
		{
			if (Vs[i] != OldLures[i])
				break;
		}
		if (i>=Vs.length)
			i = 666;
	}
	if (i != 666)
	{
		for (i=0;i<3;i++)
		{
			if (i >= Vs.length || Vs[i] == vect(0,0,0))
				ZapLures[i] = vect(0,0,0);
			else
				ZapLures[i] = Vs[i];
		}
	}
	OldTargets = Ts;
	OldLures = Vs;
	TargZapCount++;
}
simulated function SetTargetZap(array<actor> Ts, array<vector> Vs)
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		ServerSendTargets(Ts, Vs);
	if (level.NetMode == NM_DedicatedServer)
		return;
	xPawn(Instigator).StartFiring(bHeavy, true);
	StartMuzzleZap();
	//KillFreeZap();
	if (TargetZap == None)
	{
		TargetZap = spawn(class'HVCMk9_TrackingZap', self);
		AttachToBone(TargetZap, 'tip');
		//TargetZap.SetTargets(Ts, Vs);
		//TargetZap.UpdateTargets();
	}
	else
		//TargetZap.SetTargets(Ts, Vs);
	if (level.NetMode == NM_Client && LG != None)
		LG.SetTargetZap(Ts, Vs);
}

simulated function SetFreeZap ()
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		FreeZapCount++;
	if (level.NetMode == NM_DedicatedServer)
		return;
	xPawn(Instigator).StartFiring(bHeavy, true);
	StartMuzzleZap();
	KillTargetZap();
	if (FreeZap == None)
	{
		FreeZap = spawn(class'HVCMk9_FreeZap', self);
		UpdateFreeZap();
		AttachToBone(FreeZap, 'tip');
	}
	if (level.NetMode == NM_Client && LG != None)
		LG.SetFreeZap();
}

simulated function KillZap ()
{
	if (Role == ROLE_Authority)
		KillZapCount++;
	if (level.NetMode == NM_DedicatedServer)
		return;
	xPawn(Instigator).StopFiring();
	StopMuzzleZap();
	KillTargetZap();
	KillFreeZap();
	if (level.NetMode == NM_Client && LG != None)
		LG.KillZap();
}

simulated function KillTargetZap()
{
	OldTargets.length=0;
	if (TargetZap != None)
	{
		//TargetZap.KillFlashes();
		TargetZap.Kill();
		TargetZap = None;
	}
}
simulated function KillFreeZap()
{
	if (FreeZap != None)
	{
		FreeZap.Kill();
		FreeZap = None;
	}
}

simulated function StartMuzzleZap()
{
	if (MuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, class'HVPCMuzzleFlash', DrawScale*FlashScale, self, 'tip');
}
simulated function StopMuzzleZap()
{
	if (MuzzleFlash != None)
	{
		Emitter(MuzzleFlash).Kill();
		MuzzleFlash = None;
	}
}

simulated event Tick (float DT)
{
	super.Tick(DT);

	if (Instigator!= None && Instigator.IsFirstPerson())
		return;
	if (TargetZap != None)
	{
		if (TargetZap.base != self)
		{
			AttachToBone(TargetZap, 'tip');
			TargetZap.bHidden = false;
		}
		//TargetZap.UpdateTargets();
	}
	UpdateFreeZap();
}

simulated function UpdateFreeZap()
{
	local vector End, X,Y,Z;
	if (FreeZap != None)
	{
		GetAxes(Instigator.GetViewRotation(), X,Y,Z);
		End = X * 1000;
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End, End);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.X.Min -= 500 * Abs(X.Z);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.X.Max += 500 * Abs(X.Z);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Y.Min -= 500 * Abs(X.X);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Y.Max += 500 * Abs(X.X);
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Z.Min -= 500 * (1-Abs(X.Z));
		BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Z.Max += 500 * (1-Abs(X.Z));

		BeamEmitter(FreeZap.Emitters[2]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End+vect(100,100,100), End-vect(100,100,100));
	}
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	Pack = Spawn(class'HVPCPack');
	if (Instigator != None)
		Instigator.AttachToBone(Pack,'Spine');
	Pack.SetBoneScale(0, 0.0001, 'Bone03');
	if (level.DetailMode>DM_High)
	{
		if (Arc1 == None)
			class'bUtil'.static.InitMuzzleFlash(Arc1, class'HVPCMk5_SideArc', DrawScale, self, 'Arc1');
		if (Arc2 == None)
			class'bUtil'.static.InitMuzzleFlash(Arc2, class'HVPCMk5_TopArc',  DrawScale, self, 'Arc2');
		if (Arc3 == None)
			class'bUtil'.static.InitMuzzleFlash(Arc3, class'HVPCMk5_TopArc',  DrawScale, self, 'Arc3');
	}
}
simulated function Destroyed()
{
	if (Pack != None)
		Pack.Destroy();
	if (FreeZap != None)
		FreeZap.Kill();
	//if (TargetZap != None)
	//{	TargetZap.KillFlashes();	TargetZap.Kill();	}
	if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	if (Arc1 != None)
		Arc1.Destroy();
	if (Arc2 != None)
		Arc2.Destroy();
	if (Arc3 != None)
		Arc3.Destroy();
	super.Destroyed();
}

simulated function DoWaterDischarge()
{
	if (Role == ROLE_Authority)
		bDischarge = !bDischarge;
	if (level.NetMode == NM_DedicatedServer)
		return;
	spawn(class'IE_HVCDischarge', Instigator,, Instigator.Location);
	Instigator.PlaySound(DischargeSound, SLOT_None, 1.8, , 192, 1.0 , false);
}

//simulated function SpawnTracer(byte Mode, Vector V)
//{
//	local BCTraceEmitter Tracer;
//	local float Dist;
//	if (Level.DetailMode < DM_High)
//		return;
//	if (Mode == 0)
//		return;
//	if (VSize(V) < 2)
//	{
//		V = Instigator.Location + Instigator.EyePosition() + V * 1400;
//		Tracer = Spawn(class'TraceEmitter_HVCRedMiss', self, , GetTipLocation(), Rotator(V - GetTipLocation()));
//		Tracer.Initialize(Dist, float(ChargePower));
//		return;
//	}
//	Dist = VSize(V - GetTipLocation());
//	if (Dist > 25)
//	{
//		Tracer = Spawn(class'TraceEmitter_HVCRedLightning', self, , GetTipLocation(), Rotator(V - GetTipLocation()));
//		Tracer.Initialize(Dist, float(ChargePower)/255);
//	}
//}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	if (Mode == 0)
		return;
	if (mHitLocation == vect(0,0,0))
		return;
	SpawnTracer(Mode, mHitLocation);
	if (VSize(mHitLocation) < 2)
		return;
	// Client, trace for hitnormal, hitmaterial and hitactor
	if (Level.NetMode == NM_Client)
	{
		mHitActor = None;
		Start = Instigator.Location + Instigator.EyePosition();

		if (WallPenetrates != 0)				{
			WallPenetrates = 0;
			DoWallPenetrate(Start, mHitLocation);	}

		Dir = Normal(mHitLocation - Start);
		bTraceWater=true;
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
		bTraceWater=false;

		if (mHitActor == None)
		{	HitLocation = mHitLocation; mHitNormal = -Dir;	}
	}
	// Server has all the info already...
 	else
		HitLocation = mHitLocation;

	if (ImpactManager != None)
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}

defaultproperties
{
     DischargeSound=Sound'BWBP2-Sounds.LightningGun.LG-WaterDischarge'
     AltMuzzleFlashClass=Class'BWBPArchivePackDE.HVPCMuzzleFlash'
     ImpactManager=Class'BallisticDE.IM_HVCRedLightning'
     bDoWaterSplash=False
     FlashScale=2.500000
     TracerClass=Class'BallisticDE.TraceEmitter_HVCRedLightning'
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP2b-Anims.HVC-3rd'
     DrawScale=0.150000
     Skins(0)=Texture'BallisticRecolors4.XavPlasCannon.Xav-SkinMk2'
     Skins(1)=FinalBlend'BWBP2-Tex.Lighter.LightGlassFinal'
}
