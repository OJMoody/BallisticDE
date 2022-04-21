//=============================================================================
// HydraBazooka.
//
// Big rocket launcher. Fires a dangerous, not too slow moving rocket, with
// high damage and a fair radius. Low clip capacity, long reloading times and
// hazardous close combat temper the beast though.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HydraBazooka extends BallisticWeapon;

var() BUtil.FullSound	HatchSound;
var() BUtil.IntRange	LaserAimSpread;

var() Name			ReloadAimedAnim;

var   Actor			CurrentRocket;			//Current rocket of interest. The rocket that can be used as camera or directed with laser
var   float			LastSendTargetTime;
var   vector		TargetLocation;
var   bool			bLaserOn;
var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;

var   Rotator		BarrelRot;
var	  float			MultiRockets, MaxMultiRockets;


//============================================================
// Laser Code
//============================================================

replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn;
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != default.bLaserOn)
	{
		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

function ServerWeaponSpecial(optional byte i)
{
	if (bServerReloading)
		return;
	ServerSwitchLaser(!bLaserOn);
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;
	if (ThirdPersonActor!=None)
		HydraAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
		
	//HydraPrimaryFire(FireMode[1]).AdjustLaserParams(bLaserOn);

	if (bLaserOn)
	{
		WeaponModes[0].bUnavailable=true;
		WeaponModes[1].bUnavailable=false;
		CurrentWeaponMode=1;
		ServerSwitchWeaponMode(1);
	}
	else
	{
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=true;
		CurrentWeaponMode=0;
		ServerSwitchWeaponMode(0);		
	}

    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	if (bLaserOn)
	{
		WeaponModes[0].bUnavailable=true;
		WeaponModes[1].bUnavailable=false;
		SpawnLaserDot();
		PlaySound(LaserOnSound,,0.7,,32);
	}
	else
	{
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=true;
		KillLaserDot();
		PlaySound(LaserOffSound,,0.7,,32);
	}
	
	//HydraPrimaryFire(FireMode[1]).AdjustLaserParams(bLaserOn);
	
	PlayIdle();
	bUseNetAim = default.bUseNetAim || bLaserOn;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor_G5Painter');
		
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
		
	if (Instigator != None && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(FRand() > 0.5);

	if ( ThirdPersonActor != None )
		HydraAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
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
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			HydraAttachment(ThirdPersonActor).bLaserOn = false;
		return true;
	}
	return false;
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

// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator AimDir;
	local Actor Other;

	if ((ClientState == WS_Hidden) || (!bLaserOn) || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('laser').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(HitLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = class'BUtil'.static.ConvertFOVs(Instigator.Location + Instigator.EyePosition(), Instigator.GetViewRotation(), End, Instigator.Controller.FovAngle, DisplayFOV, 400);

	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('laser');
		Laser.SetRotation(AimDir);
	}
	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	super.RenderOverlays(Canvas);
	if (!IsInState('Lowered'))
		DrawLaserSight(Canvas);
}

//============================================================
// Barrel Rotation Code
//============================================================

simulated function Notify_HydraHatchOpen ()
{
	if (Level.NetMode == NM_DedicatedServer)
		return;
	HydraPrimaryFire(FireMode[0]).FlashHatchSmoke();
}

simulated function Notify_RotateBarrelArray(){	RotateHydraBones();}

simulated function RotateHydraBones()
{
	SetBoneRotation('BarrelArray', BarrelRot);
}

//============================================================
// Charged Rocket Fire Load & Seeking
//============================================================

simulated function float ChargeBar()
{
	return MultiRockets / MaxMultiRockets;
}

function vector GetRocketDir()
{	
	local vector Start, End, HitLocation, HitNormal, AimDir;
	local Actor Other;
	
	AimDir = BallisticFire(FireMode[0]).GetFireDir(Start);

	End = Start + Normal(AimDir)*32768;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	HitLocation = End;
	
	return HitLocation;
}

function vector GetSwoopRocketDir(Vector Start, Vector End, float LaunchTime)
{	
	local Vector NewLoc;
	local float t;
	
	t = FMin(1, ((level.TimeSeconds - LaunchTime) / (HydraSecondaryFire(FireMode[1]).FireRate * 2)));
	
	if (VSize(End-Start) > 100)
		NewLoc = Start + (t * t * (End-Start));
	else
		NewLoc = End;
	
	return NewLoc;
}

//============================================================
// Loading in ADS
//============================================================

// Prepare to reload, set reload state, start anims. Called on client and server
simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	if (bShovelLoad)
		ReloadState = RS_StartShovel;
	else
		ReloadState = RS_PreClipOut;
	PlayReload();

	/*if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(Default.SightingTime);*/
		
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].ReloadingGun(i);

	if (bCockAfterReload)
		bNeedCock=true;
	if (bCockOnEmpty && MagAmmo < 1)
		bNeedCock=true;
	bNeedReload=false;
}

simulated function PlayShovelLoop()
{
	if (bScopeView)
		SafePlayAnim(ReloadAimedAnim, ReloadAnimRate * 1.5, 0.0, , "RELOAD");
	else
		super.PlayShovelLoop();
}

simulated function PlayReload()
{
	if (bShovelLoad && bScopeView && ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	else 
		super.PlayReload();
}

simulated function SkipReload()
{
	if (!bScopeView)
	{
		super.SkipReload();
		return;
	}
	else if (ReloadState == RS_Shovel || ReloadState == RS_PostShellIn || ReloadState == RS_PostClipIn || ReloadState == RS_EndShovel)
	{//Leave shovel loop and go to EndShovel
		if (bNeedCock && MagAmmo > 0)
			CommonCockGun();
		else
		{
			bNeedCock=false;
			ReloadState = RS_None;
			ReloadFinished();
			PlayIdle();
			AimComponent.ReAim(0.05);
		}
		return;
	}
	else if (ReloadState == RS_PreClipOut)
	{//skip reload if magazine has not yet been pulled out
		ReloadState = RS_PostClipIn;
		SetAnimFrame(ClipInFrame);
	}
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (Anim == ZoomInAnim)
	{
		SightingState = SS_Active;
		ScopeUpAnimEnd();
		return;
	}
	else if (Anim == ZoomOutAnim)
	{
		SightingState = SS_None;
		ScopeDownAnimEnd();
		return;
	}

	if (anim == FireMode[0].FireAnim || (FireMode[1] != None && anim == FireMode[1].FireAnim) )
		bPreventReload=false;
		
	if (MeleeFireMode != None && anim == MeleeFireMode.FireAnim)
	{
		if (MeleeState == MS_StrikePending)
			MeleeState = MS_Pending;
		else MeleeState = MS_None;
		ReloadState = RS_None;
		if (Role == ROLE_Authority)
			bServerReloading=False;
		bPreventReload=false;
	}
		
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		bPreventReload=False;
	}

	// Modified stuff from Engine.Weapon
	if ((ClientState == WS_ReadyToFire || (ClientState == WS_None && Instigator.Weapon == self)) && ReloadState == RS_None)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim)) // rocket hack
			SafePlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        else if (FireMode[1]!=None && anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
            SafePlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        else if (MeleeState < MS_Held)
			bPreventReload=false;
		if (Channel == 0 && (bNeedReload || ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))) && MeleeState < MS_Held)
			PlayIdle();
    }
	// End stuff from Engine.Weapon

	// Start Shovel ended, move on to Shovel loop
	if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// Shovel loop ended, start it again
	if (ReloadState == RS_PostShellIn)
	{
		if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1 )
		{
			ReloadState = RS_EndShovel;
			if (!bScopeView)
			{
				PlayShovelEnd();
				return;
			}
		}
		else
		{
			ReloadState = RS_Shovel;
			PlayShovelLoop();
			return;
		}
	}
	// End of reloading, either cock the gun or go to idle
	if (ReloadState == RS_PostClipIn || ReloadState == RS_EndShovel)
	{
		if (bNeedCock && MagAmmo > 0)
			CommonCockGun();
		else
		{
			bNeedCock=false;
			ReloadState = RS_None;
			ReloadFinished();
			PlayIdle();
			AimComponent.ReAim(0.05);
		}
		return;
	}
	//Cock anim ended, goto idle
	if (ReloadState == RS_Cocking)
	{
		bNeedCock=false;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
		AimComponent.ReAim(0.05);
	}
	
	if (ReloadState == RS_GearSwitch)
	{
		if (Role == ROLE_Authority)
			bServerReloading=false;
		ReloadState = RS_None;
		PlayIdle();
	}
}

simulated function bool CanUseSights()
{
	if 
	( 
		(SprintControl != None && SprintControl.bSprinting) || 
		ClientState == WS_BringUp || 
		ClientState == WS_PutDown || 
		(!bScopeView && ReloadState != RS_None) || 
		MeleeState != MS_None
	) 
		return false;

	return true;
}

simulated function bool CheckScope()
{
	if (level.TimeSeconds < NextCheckScopeTime)
		return true;

	NextCheckScopeTime = level.TimeSeconds + 0.25;
		
	if 
	(	AimComponent.IsDisplaced() ||
		(!bScopeView && ReloadState != RS_None && ReloadState != RS_Cocking) || 
		(Instigator.Controller.bRun == 0 && Instigator.Physics == PHYS_Walking) || 
		(SprintControl != None && SprintControl.bSprinting)
	)
	{
		StopScopeView();
		return false;
	}

	return true;
}

//============================================================
// AI Interface
//============================================================
function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	local float Dist, Rating;

	B = Bot(Instigator.Controller);
	
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();
		
	// anti-vehicle specialist
	if (Vehicle(B.Enemy) != None)
		return 1.2;
		
	Rating = Super.GetAIRating();

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	if (Dist < 1024) // danger close
		return 0.4;
	
	// projectile
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 3072, 4096); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====

defaultproperties
{
	MaxMultiRockets = 6;
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=4.000000
	LaserAimSpread=(Min=0,Max=256)
	LaserOnSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
    LaserOffSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_G5'
	BigIconCoords=(Y1=36,Y2=230)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_Projectile=True
	bWT_Super=True
	BarrelRot=(Roll=-10923)
	bShowChargingBar=True
	ManualLines(0)="Fires a rocket. These rockets have an arming delay and will ricochet off surfaces when unarmed.|In Rocket mode, the rocket flies directly to the point of aim.|In Mortar mode, the rocket will fly upwards and then strike downwards upon the point of aim.|When scoped and in Mortar mode, targets focused directly upon by the weapon's scope may be highlighted in red; when this happens, the next Mortar shot will track the target until line of sight is broken. The target is notified of the lockon when the rocket is fired."
	ManualLines(1)="Toggles the guidance laser. With the guidance laser active, rockets will fly towards the point indicated by the laser at any given time."
	ManualLines(2)="When firing a mortar rocket. the Weapon Function key will cause the player to view through the rocket's nose camera.|As a bazooka, the Hydra has no recoil. With the laser in use, its hipfire is stable, however it will always be lowered when the player jumps. The weapon is effective at medium to long range and with height advantage."
	SpecialInfo(0)=(Info="300.0;35.0;1.0;80.0;0.8;0.0;1.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Putaway')
	//CockSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Lever')
	//ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Load')
	//ClipInSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-LoadHatch')
	bCanSkipReload=True
	bShovelLoad=True
	StartShovelAnim="ReloadPrep"
	EndShovelAnim="ReloadFinish"
	ReloadAnim="ReloadLoop"
	ReloadAimedAnim="ReloadLoopAimed"
	ReloadAnimRate=1.000000
	StartShovelAnimRate=1.250000
	EndShovelAnimRate=1.250000
	CurrentWeaponMode=0
	bNoCrosshairInScope=False
	SightingTime=0.500000
	ParamsClasses(0)=Class'HydraWeaponParams'
	FireModeClass(0)=Class'BWBP_APC_Pro.HydraPrimaryFire'
	FireModeClass(1)=Class'BWBP_APC_Pro.HydraSecondaryFire'
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	NDCrosshairCfg=(Pic1=TexRotator'BW_Core_WeaponTex.NovaStaff.NovaOutA-Rot',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc11',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=0,R=0,A=236),Color2=(B=0,G=0,R=100,A=236),StartSize1=121,StartSize2=43)
	SelectAnimRate=0.600000
	PutDownAnimRate=0.800000
	PutDownTime=1.400000
	BringUpTime=1.700000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.800000
	CurrentRating=0.800000
	WeaponModes(0)=(ModeName="HV Rockets",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Guided Rockets",ModeID="WM_FullAuto",bUnavailable=true)
	WeaponModes(2)=(bUnavailable=true)
	Description="Based on the original design by the legendary maniac Pirate, Var Dehidra, the G5 has undergone many alterations to become what it is today. The original bandit version was constructed by Var Dehidra to blast open armored cash transportation vehicles. Its name is derived from one of Dehidra's favourite targets, the G5 CTV 4x. It is now a very deadly weapon, used to destroy everything from tanks and structures to Skrith hordes and aircraft. The bombardement attack is a recent addition, replacing the original, primitive heat seeking function that caused it to target CTVs or backfire on the pirates' own craft, provided mainly for use in outdoor environments to destroy all manner of moving targets. The latest model also features a laser-painter device, allowing the user to guide the rocket wherever they wish."
	Priority=44
	HudColor=(B=25,G=150,R=50)
	CenteredOffsetY=10.000000
	CenteredRoll=0
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=8
	PickupClass=Class'BWBP_APC_Pro.HydraPickup'
	PlayerViewOffset=(X=10.000000,Y=8.000000,Z=-10.000000)
	AttachmentClass=Class'BWBP_APC_Pro.HydraAttachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_G5'
	IconCoords=(X2=127,Y2=31)
	ItemName="[B] M11-X Hydra MRL"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=25
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BWBP_CC_Anim.FPm_CruRL'
	DrawScale=0.300000
}
