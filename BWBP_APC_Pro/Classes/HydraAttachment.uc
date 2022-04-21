//=============================================================================
// G5Attachment.
//
// 3rd person weapon attachment for G5 Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HydraAttachment extends BallisticAttachment;

var   bool			bLaserOn;		//Is laser currently active
var   bool			bOldLaserOn;	//Old bLaserOn
var   LaserActor	Laser;			//The laser actor
var   vector		LaserEndLoc;
var   Emitter		LaserDot;

var name BackBones[2];
var name FrontBones[6];
var byte Index;

var array<Actor> BackFlashes[2];
var array<Actor> FrontFlashes[6];

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
	if (Index > 5)
		Index = 0;
}

simulated event Destroyed()
{
	local int i;

	for (i=0; i<6; i++)
	{
		class'BUtil'.static.KillEmitterEffect (FrontFlashes[i]);
		class'BUtil'.static.KillEmitterEffect (BackFlashes[i]);
	}

	Super.Destroyed();
}


/*replication
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
		LaserDot = Spawn(class'HydraLaserDot',,,Loc);
	laserDot.bHidden=false;
}

simulated function Tick(float DT)
{
	local Vector Scale3D, Loc;

	Super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'LaserActor_HydraPainter',,,Location);

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

	Loc = GetModeTipLocation();

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(LaserEndLoc - Loc));
//	Laser.SetRelativeRotation(Rotator(HitLocation - Loc) - GetBoneRotation('tip'));
	Scale3D.X = VSize(LaserEndLoc-Laser.Location)/128;
	Scale3D.Y = 1.5;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
}

simulated function Destroyed()
{
	if (LaserDot != None)
		LaserDot.Destroy();
	if (Laser != None)
		Laser.Destroy();
	Super.Destroyed();
}

// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte Mode)
{
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
		{	// Spawn, Attach, Scale, Initialize emitter flashes
			AltMuzzleFlash = Spawn(AltMuzzleFlashClass, self);
			if (Emitter(AltMuzzleFlash) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(AltMuzzleFlash), DrawScale*FlashScale);
			AltMuzzleFlash.SetDrawScale(DrawScale*FlashScale);
			if (DGVEmitter(AltMuzzleFlash) != None)
				DGVEmitter(AltMuzzleFlash).InitDGV();
			AttachToBone(AltMuzzleFlash, 'tip2');
		}
		AltMuzzleFlash.Trigger(self, Instigator);
	}
	if (MuzzleFlashClass != None)
	{	// Spawn, Attach, Scale, Initialize emitter flashes
		if (MuzzleFlash == None)
		{
			MuzzleFlash = Spawn(MuzzleFlashClass, self);
			if (Emitter(MuzzleFlash) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(MuzzleFlash), DrawScale*FlashScale);
			MuzzleFlash.SetDrawScale(DrawScale*FlashScale);
			if (DGVEmitter(MuzzleFlash) != None)
				DGVEmitter(MuzzleFlash).InitDGV();
			AttachToBone(MuzzleFlash, 'tip');
		}
		MuzzleFlash.Trigger(self, Instigator);
	}
}*/

defaultproperties
{
     BackBones(0)="backblast"
	 BackBones(1)="backblast"
     FrontBones(0)="Muzzle1"
     FrontBones(1)="Muzzle2"
     FrontBones(2)="Muzzle3"
	 FrontBones(3)="Muzzle4"
	 FrontBones(4)="Muzzle5"
	 FrontBones(5)="Muzzle6"
	 MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
     AltMuzzleFlashClass=Class'BWBP_APC_Pro.HydraBackFlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     AltFlashBone="laser"
     FlashScale=1.200000
     BrassMode=MU_None
     InstantMode=MU_None
	 ReloadAnim="Reload_MG"
	 ReloadAnimRate=1.500000
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_CC_Anim.CruRL_TPm'
     DrawScale=0.230000
}
