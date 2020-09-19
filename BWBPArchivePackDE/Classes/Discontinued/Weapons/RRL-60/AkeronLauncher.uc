//=============================================================================
// Akeron Launcher.
// 
// Fires medium rockets with guidance and homing capability.
//=============================================================================
class AkeronLauncher extends BallisticWeapon;

var float PanicThreshold;
var AkeronWarhead ActiveWarhead;

var   float			LastSendTargetTime;
var   vector		TargetLocation;
var   bool			bLaserOn, bLaserOld;
var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;
var() int			LaserChaosAimSpread, LaserAimSpread;
var   Actor			CurrentRocket;			//Current rocket of interest. The rocket that can be used as camera or directed with laser
var   bool			bCamView;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientSetViewRotation;
}
function LostWarhead()
{
	GoToState('ControllerRecovery');
}

state ControllerRecovery
{
	Begin:
		Sleep(1);
		RecoverController();
		GoToState('');
}

function RecoverController()
{
	if ( InstigatorController == None || InstigatorController.Pawn == Instigator)
		return;
		
	InstigatorController.SetRotation(ActiveWarhead.InitialControllerRotation);
	ClientSetViewRotation(ActiveWarhead.InitialControllerRotation);
	
	InstigatorController.UnPossess();
	
	if ( !InstigatorController.IsInState('GameEnded') )
	{
		if ( (Instigator != None) && (Instigator.Health > 0) )
			InstigatorController.Possess(Instigator);
		else
		{
			if ( Instigator != None )
			{
				InstigatorController.Pawn = Instigator;
				PlayerController(InstigatorController).SetViewTarget(Instigator);
			}
			else
				InstigatorController.Pawn = None;
			InstigatorController.PawnDied(InstigatorController.Pawn);
		}
	}

	if (!ActiveWarhead.bExploded)
		ActiveWarhead.BlowUp(ActiveWarhead.Location);
	ActiveWarhead = None;
}

simulated function ClientSetViewRotation(Rotator R)
{
	Level.GetLocalPlayerController().SetRotation(R);
}

// Aim goes bad when player takes damage
function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	local float DF;
	
	if (bBerserk)
		Damage *= 0.75;
		
	//Recover the controller immediately if in danger
	if (ActiveWarhead != None && (InstigatedBy.Controller == None || InstigatedBy.Controller == InstigatorController || ( !InstigatedBy.Controller.SameTeamAs(InstigatorController) )) && Damage > PanicThreshold)
		RecoverController();
		
	if (AimKnockScale == 0)
		return;

	DF = FMin(1, (float(Damage)/AimDamageThreshold) * AimKnockScale);
	ApplyDamageFactor(DF);
	ClientPlayerDamaged(255*DF);
	bForceReaim=true;
}

function byte BestMode()
{
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 2048, 3072); 
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (MagAmmo > 1)
	{
		SetBoneScale (1, 1.0, 'RocketBone');
		ThirdPersonActor.SetBoneScale (1, 1.0, 'RocketBone');
	}
	else if (MagAmmo == 0)
	{
		SetBoneScale (1, 0.0, 'RocketBone');
		ThirdPersonActor.SetBoneScale (1, 0.0, 'RocketBone');
	}
	
	Super.BringUp(PrevWeapon);
	
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor_G5Painter');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if ( ThirdPersonActor != None )
		AkeronAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
		
	Super.BringUp(PrevWeapon);
	
	if ( ThirdPersonActor != None )
		AkeronAttachment(ThirdPersonActor).bLaserOn = bLaserOn;

	if (class'BallisticReplicationInfo'.default.bNoReloading && AmmoAmount(0) > 1)
		SetBoneScale (0, 1.0, 'Rocket');
}


function ServerSetRocketTarget(vector Loc)
{
	TargetLocation = Loc;
	if (CurrentRocket != None && G5SeekerRocket(CurrentRocket) != None)
		G5SeekerRocket(CurrentRocket).SetTargetLocation(Loc);
	if (ThirdPersonActor != None)
		AkeronAttachment(ThirdPersonActor).LaserEndLoc = Loc;
}

simulated function TickLaser ( float DT )
{
	local vector Start, End, HitLocation, HitNormal, AimDir;
	local Actor Other;

	if ((ClientState == WS_Hidden) || Instigator == None || !bLaserOn || bScopeView ||
		(bCamView && bScopeHeld) || (bCamView && Currentrocket != None && PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).ViewTarget == CurrentRocket))
		return;

	if ( Instigator.IsFirstPerson() && (ReloadState != RS_None || ClientState != WS_ReadyToFire || Level.TimeSeconds - FireMode[0].NextFireTime <= 0.2) )
	{
		AimDir = Vector(GetBoneRotation('tip2'));
		Start = Instigator.Location + Instigator.EyePosition();
	}
	else
		AimDir = BallisticFire(FireMode[0]).GetFireDir(Start);

	End = Start + Normal(AimDir)*10000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (G5MortarDamageHull(Other) != None && Other.Owner == Instigator)
		Other = FireMode[0].Trace (HitLocation, HitNormal, End, HitLocation + Normal(AimDir)*Other.CollisionRadius * 3, true);
	if (Other == None)
		HitLocation = End;

	if (Role == ROLE_Authority)
		ServerSetRocketTarget(HitLocation);
	else
	{
		if ( ThirdPersonActor != None )
			AkeronAttachment(ThirdPersonActor).LaserEndLoc = HitLocation;
		TargetLocation = HitLocation;
		if (level.TimeSeconds - LastSendTargetTime > 0.04)
		{
			LastSendTargetTime = level.TimeSeconds;
			ServerSetRocketTarget(HitLocation);
		}
	}
}

// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Scale3D, Loc;

	if ((ClientState == WS_Hidden) || !bLaserOn || bScopeView || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	Loc = GetBoneCoords('tip2').Origin;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(TargetLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(TargetLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(TargetLocation, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
		Laser.SetRotation(GetBoneRotation('tip2'));

	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1.5;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
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
}

simulated function Destroyed ()
{
	default.bLaserOn = false;
	if (Laser != None)
		Laser.Destroy();
	if (LaserDot != None)
		LaserDot.Destroy();
	Super.Destroyed();
}

// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

simulated function vector ConvertFOVs (vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Instigator.Location + Instigator.EyePosition();
	ViewRot = Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}

simulated function Notify_ShowRocketBone()
{
	SetBoneScale (1, 1.0, 'RocketBone');
}

simulated function Notify_ClipIn()
{
	Super.Notify_ClipIn();
	ThirdPersonActor.SetBoneScale (1, 1.0, 'RocketBone');
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;

	AkeronAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
	if (bLaserOn)
		AimAdjustTime = default.AimAdjustTime * 1.5;
	else
		AimAdjustTime = default.AimAdjustTime;
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
	SwitchLaserProps(bNewLaserOn);
}

simulated function ClientSwitchLaser()
{
	TickLaser (0.05);
	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,0.7,,32);
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,0.7,,32);
	}
	PlayIdle();
	bUseNetAim = default.bUseNetAim || bLaserOn;
	SwitchLaserProps(bLaserOn);
}

simulated function SwitchLaserProps(bool bLaserOn)
{
	if (bLaserOn)
	{
		AimSpread = LaserAimSpread;
		ChaosAimSpread = LaserChaosAimSpread;
	}
	
	else
	{
		AimSpread = default.AimSpread;
		ChaosAimSpread = default.ChaosAimSpread;
	}
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

defaultproperties
{
     PanicThreshold=4.000000
     PlayerSpeedFactor=0.900000
     PlayerJumpFactor=0.900000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BWBPOtherPackTex3.Akeron.BigIcon_Akeron'
     BigIconCoords=(X1=36,Y1=50,X2=486,Y2=220)
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     ManualLines(0)="Launches rockets with good fire rate. These rockets travel quickly and deal high damage upon direct impact. The blast of Akeron rockets is directed forwards, so targets perpendicular to or behind the rocket's target vector when it explodes will take very little damage."
     ManualLines(1)="Launches a manually guided rocket. While a rocket is active, the user views through the rocket's nose camera. Rockets are fast and quite manoeuverable, but much as the primary fire, have a directed blast and require the enemy to be struck directly to do much damage."
     ManualLines(2)="The Akeron is effective at medium range or in specialist situations where indirect fire is required. As a rocket launcher, it has very low recoil, but its size makes it cumbersome to use without stability or aiming."
     SpecialInfo(0)=(Info="300.0;35.0;1.0;80.0;0.8;0.0;1.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.G5.G5-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.G5.G5-Putaway')
     MagAmmo=1
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.G5.G5-Lever')
     ReloadAnimRate=0.900000
     ClipOutSound=(Sound=Sound'BallisticSounds2.BX5.BX5-SecOn')
     ClipInSound=(Sound=Sound'BallisticSounds2.BX5.BX5-SecOff')
     bNonCocking=True
     WeaponModes(0)=(ModeName="Single Fire")
     WeaponModes(1)=(ModeName="Continuous Fire",ModeID="WM_SemiAuto")
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     ZoomType=ZT_Logarithmic
     ScopeXScale=1.333000
     ScopeViewTex=Texture'BWBP4-Tex.Artillery.Artillery-ScopeView'
     FullZoomFOV=10.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightOffset=(Y=0.940000,Z=9.500000)
     SightingTime=0.500000
     MinZoom=2.000000
     MaxZoom=8.000000
     ZoomStages=6
     SightAimFactor=0.650000
     SprintOffSet=(Pitch=-6000,Yaw=-8000)
     JumpOffSet=(Pitch=-6000,Yaw=-1500)
     AimAdjustTime=1.000000
     AimSpread=512
     ChaosSpeedThreshold=1000.000000
     ChaosAimSpread=2560
     RecoilDeclineTime=1.000000
     FireModeClass(0)=Class'BWBPArchivePackDE.AkeronPrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.G5SecondaryFire'
     SelectAnimRate=0.600000
     PutDownAnimRate=0.800000
     PutDownTime=0.800000
     BringUpTime=1.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.80000
     CurrentRating=0.80000
     Description="The AN-56 Akeron Launcher was introduced to fulfill a pressing need for indirect fire options within the UTC ranks. Launching directed-blast rockets for the safety of allied units, it has quickly become a staple due to its optional ability to attack fortifications with manually guided rockets without requiring the user's exposure to enemy fire. However, whilst guiding a rocket, the user is vulnerable to flank attacks, and the weapon is best employed with the support of teammates. Should the user choose to eschew manual guidance, undirected rockets can be launched at a fast rate from the weapon's three barrels."
     Priority=44
     HudColor=(B=80,G=95,R=110)
     CenteredOffsetY=10.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     PickupClass=Class'BWBPArchivePackDE.AkeronPickup'
     PlayerViewOffset=(X=10.000000,Y=4.000000,Z=-5.000000)
     AttachmentClass=Class'BWBPArchivePackDE.AkeronAttachment'
     IconMaterial=Texture'BWBPOtherPackTex3.Akeron.Icon_Akeron'
     IconCoords=(X2=127,Y2=31)
     ItemName="[B] RRL-60 Reptile Toxic Bazooka"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWSkrithRecolors2Anim.SkrithRocketLauncher'
     DrawScale=0.300000
}
