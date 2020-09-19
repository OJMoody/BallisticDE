//=============================================================================
// G5Attachment.
//
// 3rd person weapon attachment for G5 Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AkeronAttachment extends BallisticAttachment;

var name BackBones[3];
var name FrontBones[3];
var byte Index;

var array<Actor> BackFlashes[3];
var array<Actor> FrontFlashes[3];

var   bool			bLaserOn;		//Is laser currently active
var   bool			bOldLaserOn;	//Old bLaserOn
var   LaserActor	Laser;			//The laser actor
var   vector		LaserEndLoc;
var   Emitter		LaserDot;

// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte Mode)
{
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (AltMuzzleFlashClass != None)
	{
		if (BackFlashes[Index] == None)
		{
			BackFlashes[Index] = Spawn(AltMuzzleFlashClass, self);
			if (Emitter(BackFlashes[Index]) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(BackFlashes[Index]), DrawScale*FlashScale);
			BackFlashes[Index].SetDrawScale(DrawScale*FlashScale);
			if (DGVEmitter(BackFlashes[Index]) != None)
				DGVEmitter(BackFlashes[Index]).InitDGV();

			AttachToBone(BackFlashes[Index], BackBones[Index]);
		}
		BackFlashes[Index].Trigger(self, Instigator);
	}
	if (MuzzleFlashClass != None)
	{
		if (FrontFlashes[Index] == None)
		{
			FrontFlashes[Index] = Spawn(MuzzleFlashClass, self);
			if (Emitter(FrontFlashes[Index]) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(FrontFlashes[Index]), DrawScale*FlashScale);
			FrontFlashes[Index].SetDrawScale(DrawScale*FlashScale);
			if (DGVEmitter(FrontFlashes[Index]) != None)
				DGVEmitter(FrontFlashes[Index]).InitDGV();
				
			AttachToBone(FrontFlashes[Index], FrontBones[Index]);
		}
		FrontFlashes[Index].Trigger(self, Instigator);
	}
	
	Index++;
	if (Index > 2)
		Index = 0;
}

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn;
	unreliable if ( Role==ROLE_Authority && !bNetOwner )
		LaserEndLoc;
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'G5LaserDot',,,Loc);
	laserDot.bHidden=false;
}

simulated function Tick(float DT)
{
	local Vector Scale3D, Loc;

	Super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'LaserActor_G5Painter',,,Location);

	if (bLaserOn != bOldLaserOn)
		bOldLaserOn = bLaserOn;

	if (!bLaserOn || Instigator == None || Instigator.IsFirstPerson() || Instigator.DrivenVehicle != None)
	{
		if (!Laser.bHidden)
			Laser.bHidden = true;
		KillLaserDot();
		return;
	}
	else
	{
		if (Laser.bHidden)
			Laser.bHidden = false;
		SpawnLaserDot();
	}

	if (LaserDot != None)
		LaserDot.SetLocation(LaserEndLoc);

	Loc = GetTipLocation();

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(LaserEndLoc - Loc));
//	Laser.SetRelativeRotation(Rotator(HitLocation - Loc) - GetBoneRotation('RocketHelper1'));
	Scale3D.X = VSize(LaserEndLoc-Laser.Location)/128;
	Scale3D.Y = 1.5;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
}

simulated function Destroyed()
{
	local int i;
	if (LaserDot != None)
		LaserDot.Destroy();
	if (Laser != None)
		Laser.Destroy();

	for (i=0; i<3; i++)
	{
		class'BUtil'.static.KillEmitterEffect (FrontFlashes[i]);
		class'BUtil'.static.KillEmitterEffect (BackFlashes[i]);
	}

	Super.Destroyed();
}

defaultproperties
{
     FrontBones(0)="RocketHelper1"
     MuzzleFlashClass=Class'BallisticDE.G5FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticDE.G5BackFlashEmitter'
     ImpactManager=Class'BallisticDE.IM_Bullet'
     FlashScale=0.750000
     BrassMode=MU_None
     InstantMode=MU_None
     Mesh=SkeletalMesh'BWSkrithRecolors2Anim.SkrithRL3rd'
     RelativeLocation=(Z=5.000000)
     RelativeRotation=(Pitch=-32768)
     DrawScale=0.280000
}
