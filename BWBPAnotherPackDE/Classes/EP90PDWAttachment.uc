//=============================================================================
// EP110Attachment.
//
// 3rd person weapon attachment for EP110 Bullpup
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class EP90PDWAttachment extends HandgunAttachment;

var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn;
	unreliable if ( Role==ROLE_Authority )
		LaserRot;
}

simulated function Tick(float DT)
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator X;
	local Actor Other;

	Super.Tick(DT);

	if (bLaserOn && Role == ROLE_Authority && Handgun != None)
	{
		LaserRot = Instigator.GetViewRotation();
		LaserRot += Handgun.GetAimPivot();
		LaserRot += Handgun.GetRecoilPivot();
	}

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'LaserActor_Third',,,Location);

	if (bLaserOn != bOldLaserOn)
		bOldLaserOn = bLaserOn;

	if (!bLaserOn || Instigator == None || Instigator.IsFirstPerson() || Instigator.DrivenVehicle != None)
	{
		if (!Laser.bHidden)
			Laser.bHidden = true;
		return;
	}
	else
	{
		if (Laser.bHidden)
			Laser.bHidden = false;
	}

	if (Instigator != None)
		Start = Instigator.Location + Instigator.EyePosition();
	else
		Start = Location;
	X = LaserRot;

	Loc = GetTipLocation();

	End = Start + (Vector(X)*5000);
	Other = Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(HitLocation - Loc));
	Scale3D.X = VSize(HitLocation-Laser.Location)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
}

simulated function Destroyed()
{
	if (Laser != None)
		Laser.Destroy();
	Super.Destroyed();
}

simulated function InstantFireEffects(byte Mode)
{
    if (Mode == 0)
        ImpactManager = default.ImpactManager;
    else
    {
        ImpactManager = class'IM_EMPRocket';
    }
    super.InstantFireEffects(Mode);
}

defaultproperties
{
	 PrePivot=(Z=-3.000000)
	 FlashScale=0.100000
	 FlashBone="tip"
     AltFlashBone="tip"
     MuzzleFlashClass=Class'BWBPAnotherPackDE.EP90PDWFlashEmitter'
	 AltMuzzleFlashClass=Class'BWBPAnotherPackDE.EP90PDWFlashEmitter'
     ImpactManager=Class'BWBPAnotherPackDE.IM_EP90'
     BrassClass=Class'BallisticDE.Brass_Pistol'
     TracerClass=Class'BWBPAnotherPackDE.TraceEmitter_Pulse'
     TracerChance=1.000000
	 TracerMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     WaterTracerClass=Class'BallisticDE.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FlyBy',Volume=0.700000)
     Mesh=SkeletalMesh'BWBP_CC_Anim.EP110_TPm'
     DrawScale=1.000000
}
