//=============================================================================
// LS440Attachment.
//
// Third person actor for the LS-14 Laser Carbine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LS440Attachment extends BallisticAttachment;

var() class<BCTraceEmitter>	AltTracerClass;		//Type of tracer to use for alt fire effects
var Vector		SpawnOffset;


simulated function InstantFireEffects(byte Mode)
{
	if (Mode == 0)
	{
			ImpactManager = class'IM_HVPCProjectile';
	}
	else
	{
			ImpactManager = class'IM_HVPCProjectileSmall';
	}
	super.InstantFireEffects(Mode);
}

simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
//	local M75Spiral Spiral;
	local Vector TipLoc;
	local TraceEmitter_LS14R TER;
	local TraceEmitter_LS14R TEA;
	local float Dist;

	TipLoc = GetTipLocation();
	Dist = VSize(V - TipLoc);
	
	if (VSize(V) < 2)
		V = Instigator.Location + Instigator.EyePosition() + V * 10000;
	Dist = VSize(V-GetTipLocation());
	// Spawn Siral Effect
//	Spiral = Spawn(class'M75Spiral', self, , GetTipLocation(), Rotator(V - GetTipLocation()));
//	Spiral.InitSpiral(Dist, RailPower);
	if (AltTracerClass != None && TracerMode != MU_None && (TracerMode == MU_Both && Mode != 1) && (TracerChance >= 1 || FRand() < TracerChance))
	{
		if (Dist > 200)
			Tracer = Spawn(AltTracerClass, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn an alt tracer
	else
	{
		if (!LS440Instagib(Instigator.weapon).bBarrelsOnline && LS440Instagib(Instigator.weapon).CurrentWeaponMode == 0)
		{
			TEA = Spawn(class'TraceEmitter_LS14R', self, , GetTipLocationStyleTwo(), Rotator(V - GetTipLocation()));
			TEA.Initialize(Dist, 1);
		}
		else
		{
			TER = Spawn(class'TraceEmitter_LS14R', self, , GetTipLocation(), Rotator(V - GetTipLocation()));
			TER.Initialize(Dist, 1);
		}
	}

}


simulated function Vector GetTipLocation()
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{

		if (LS440Instagib(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
				Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
		{
			Loc = Instigator.Weapon.GetBoneCoords('tip').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
		}
	}
	else
		Loc = GetBoneCoords('tip').Origin;
	if (VSize(Loc - Instigator.Location) > 200)
		return Instigator.Location;
    return Loc;
}

simulated function Vector GetTipLocationStyleTwo()
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{

		if (LS440Instagib(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
			Loc = Instigator.Weapon.GetBoneCoords('tip2').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
	}
	else
		Loc = GetBoneCoords('tip2').Origin + Y*200;
	if (VSize(Loc - Instigator.Location) > 200)
		return Instigator.Location;
    return Loc;
}

simulated function EjectBrass(byte Mode);

defaultproperties
{
     AltTracerClass=Class'BWBPArchivePackPro2.TraceEmitter_LS14RR'
     SpawnOffset=(X=-30.000000)
     MuzzleFlashClass=Class'BWBPArchivePackPro2.GRSXXLaserFlashEmitter'
     ImpactManager=Class'BWBPArchivePackPro2.IM_HVPCProjectile'
     BrassClass=Class'BallisticDE.Brass_Railgun'
     TracerMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BWBPArchivePackPro2.TraceEmitter_LS14RR'
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=Sound'PackageSounds4.LS14.Gauss-FlyBy',Volume=0.700000)
     FlyByBulletSpeed=-1.000000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolors4Anim.3RD-LS14'
     RelativeLocation=(X=-3.000000,Z=2.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.200000
     Skins(0)=Shader'BallisticRecolors4.LS440M.LS440_SD'
}
