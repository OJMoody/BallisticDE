//=============================================================================
// EP90PDW.
//
// Semi Automatic pistol with decent damage, 12 round clip, good accracy when
// used carefully, but mainly, its the default weapon.
// Secondary fixes to unpredictable aiming by providing a laser sight so that
// the user knows where to expect the bullets.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class EP90PDW extends BallisticWeapon;

var   bool			bLaserOn;
var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;

replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn;
}

simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
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
		M806Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
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

	if (!IsinState('DualAction') && !IsinState('PendingDualAction'))
		PlayIdle();

	bUseNetAim = default.bUseNetAim || bLaserOn;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(FRand() > 0.5);

	/*if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}*/

	if ( ThirdPersonActor != None )
		EP90PDWAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
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
		LaserDot = Spawn(class'M806LaserDot',,,Loc);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			EP90PDWAttachment(ThirdPersonActor).bLaserOn = false;
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
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
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

// Chargebar Code
simulated function float ChargeBar()
{
	if (FireMode[1].bIsFiring)
		return FMin(1, FireMode[1].HoldTime / EP90PDWSecondaryFire(FireMode[1]).ChargeTime);
	return FMin(1, EP90PDWSecondaryFire(FireMode[1]).DecayCharge / EP90PDWSecondaryFire(FireMode[1]).ChargeTime);
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

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()	{	return 0;	}

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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}
// End AI Stuff =====

defaultproperties
{
     LaserOnSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
     LaserOffSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=1.500000
	 ZoomType=ZT_Fixed
	 FullZoomFOV=70
     BigIconMaterial=Texture'BWBP_CC_Tex.Bullpup.BigIcon_Bullpup'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
	 bWT_Bullet=True
	 bShowChargingBar=True
     SpecialInfo(0)=(Info="0.0;8.0;-999.0;25.0;0.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'BWBP_CC_Sounds.EP110.EP110-Draw')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
	 ScopeViewTex=Texture'BWBP_CC_Tex.Bullpup.EP110-Scope'
     CockSound=(Sound=Sound'BWBP_CC_Sounds.EP110.EP110-CockBack',Volume=2.000000)
     ClipHitSound=(Sound=Sound'BWBP_CC_Sounds.EP110.EP110-Slap',Volume=2.000000)
     ClipOutSound=(Sound=Sound'BWBP_CC_Sounds.EP110.EP110-PullOut',Volume=2.000000)
     ClipInSound=(Sound=Sound'BWBP_CC_Sounds.EP110.EP110-PutIn',Volume=2.000000)
     ClipInFrame=0.650000
	 WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
	 WeaponModes(1)=(ModeName="Burst of Three",ModeID="WM_BigBurst",Value=3.000000)
	 WeaponModes(2)=(ModeName="Charged Shot",bUnavailable=True)
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightPivot=(Pitch=1024)
     SightOffset=(X=-4.000000,Y=-0.250000,Z=13.600000)
     SightDisplayFOV=60.000000
	 SightingTime=0.250000
	 BobDamping=2.300000
	 bNoMeshInScope=True
     FireModeClass(0)=Class'BWBPAnotherPackDE.EP90PDWPrimaryFire'
     FireModeClass(1)=Class'BWBPAnotherPackDE.EP90PDWSecondaryFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     Description="Before the Skrith wars broke out, photon weaponry was declared inhumane by the Neo-Geneva convention due to the effects it had against animal test subjects.  It wasn’t until one battle on Gahanna where photon weaponry found it’s value against the Cyron troopers, discombobulating their gyroscopic sensors long enough to turn the tide, living to fight another day.  Since then, photon weaponry has been deemed legal to use in both wartime situations and underground blood sports. The EP110 is the latest in this field, a bullpup SMG not only able to clear out enclosed spaces, but it also has a discombobulator field able to disorient and destroy anyone caught in its path."
     Priority=19
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	 InventoryGroup=3
     GroupOffset=18
     PickupClass=Class'BWBPAnotherPackDE.EP90PDWPickup'
     PlayerViewOffset=(X=5.000000,Y=5.000000,Z=-8.500000)
     AttachmentClass=Class'BWBPAnotherPackDE.EP90PDWAttachment'
     IconMaterial=Texture'BWBP_CC_Tex.Bullpup.SmallIcon_Bullpup'
     IconCoords=(X2=127,Y2=31)
     ItemName="EP110 Photon PDW"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
	 ParamsClass=Class'EP90WeaponParams'
     Mesh=SkeletalMesh'BWBP_CC_Anim.FPm_EP110'
     DrawScale=1.000000
}
