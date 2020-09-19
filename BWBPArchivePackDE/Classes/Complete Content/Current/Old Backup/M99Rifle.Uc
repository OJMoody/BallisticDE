//=============================================================================
// R78Rifle.
//
// Powerful, accurate rifle with slow cocking after each shot and reasonable
// reload time, but low clip capacity. Secondary fire makes it the weapon it is
// by providing a powerful scope. Holding secondary zooms in further initially,
// but the player can still use Prev and Next weapon to adjust.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M99Rifle extends BallisticWeapon;

var   bool				bLaserOn;
var   LaserActor_LAW	Laser;
var() Sound				LaserOnSound;
var() Sound				LaserOffSound;
var   Emitter			LaserDot;

replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn;
}

simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}



simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

// Set a few things...
simulated function PostBeginPlay()
{
    local int m;

    Super.PostBeginPlay();

	SightingTime = 0.9;
	/*if (BallisticInventoryGroup != 254)
		InventoryGroup = BallisticInventoryGroup;*/
    for (m = 0; m < NUM_FIRE_MODES; m++)
    	if (FireMode[m] != None && BallisticFire(FireMode[m]) != None)
			BFireMode[m] = BallisticFire(FireMode[m]);
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != default.bLaserOn)
	{
		if (bLaserOn)
			AimAdjustTime = default.AimAdjustTime * 1.5;
		else
			AimAdjustTime = default.AimAdjustTime;
		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = bLaserOn;
	if (ThirdPersonActor!=None)
		M99Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
	if (bLaserOn)
		AimAdjustTime = default.AimAdjustTime * 1.5;

	else
		AimAdjustTime = default.AimAdjustTime;
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
	PlayIdle();
	bUseNetAim = bLaserOn;
}

//Draw special weapon info on the hud
/*simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	if (bLaserOn)	{
		CrosshairCfg.Color1.A /= 2;
		CrosshairCfg.Color2.A /= 2;
	}
	Super.NewDrawWeaponInfo (C, YPos);

	if (bLaserOn)	{
		CrosshairCfg.Color1.A = default.CrosshairCfg.Color1.A ;
		CrosshairCfg.Color2.A = default.CrosshairCfg.Color2.A ;
	}
}*/
simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'BWBPRecolorsDE.LaserActor_LAW');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(bLaserOn);

	if ( ThirdPersonActor != None )
		M99Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
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
		LaserDot = Spawn(class'BWBPArchivePackDE.M99LaserDot',,,Loc);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			M99Attachment(ThirdPersonActor).bLaserOn = false;
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
Loc = GetBoneCoords('tip2').Origin;


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
		AimDir = GetBoneRotation('tip2');
		Laser.SetRotation(AimDir);
	}
	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1.50;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	super.RenderOverlays(Canvas);
	if (!IsInState('Lowered'))
		DrawLaserSight(Canvas);
}
function ServerUpdateLaser(bool bNewLaserOn)
{
	bUseNetAim = bNewLaserOn;
}

function InitLaser(optional byte i)
{
	bLaserOn = !bLaserOn;
	bUseNetAim = bLaserOn;
	ServerUpdateLaser(bLaserOn);
	ServerSwitchLaser(bLaserOn);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None && Type != 1)
		TemporaryScopeDown(0.5);
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
function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	Result += (Dist-1000) / 2000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

defaultproperties
{
     LaserOnSound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-LaserClick'
     LaserOffSound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-LaserClick'
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWWeaponPack-Tex.M99.BigIcon_M99'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     InventorySize=35
     bWT_Bullet=True
     SpecialInfo(0)=(Info="240.0;35.0;2.0;120.0;10.0;0.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.R78.R78Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.R78.R78Putaway')
     MagAmmo=1
     CockSound=(Sound=Sound'BWWeaponPack2-Sounds.M99.M99Cock',Volume=100.500000)
     ClipHitSound=(Sound=Sound'BWWeaponPack2-Sounds.M99.M99BoltClose',Volume=100.500000)
     ClipOutSound=(Sound=Sound'BWWeaponPack2-Sounds.M99.M99OpenBolt',Volume=100.500000)
     ClipInSound=(Sound=Sound'BWWeaponPack2-Sounds.M99.M99Cartridge',Volume=100.500000)
     ClipInFrame=0.650000
     WeaponModes(0)=(ModeName="Bolt-Action")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
	 PlayerSpeedFactor=0.750000
     PlayerJumpFactor=0.780000
     ZoomType=ZT_Smooth
     ZoomInAnim="ZoomIn"
     ZoomOutAnim="ZoomOut"
     ScopeViewTex=Texture'BWWeaponPack-Tex.M99.M99Scope'
	 ScopeXScale=1.4000
     ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=2.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightPivot=(Roll=-1024)
     SightOffset=(X=-4.000000,Y=11.000000,Z=20.500000)
	 JumpOffSet=(Pitch=-8192,Yaw=-1024)
     SightingTime=0.900000
     GunLength=85.000000
     CrouchAimFactor=0.300000
     SprintOffSet=(Pitch=-6000,Yaw=-8192)
     AimAdjustTime=0.500000
	 AimSpread=1024
	 ChaosAimSpread=2048
	 FireChaos=1
	 RecoilDeclineDelay=1.500000
     ChaosDeclineTime=1.500000
     ChaosSpeedThreshold=400.000000
     RecoilYawFactor=0.100000
     RecoilXFactor=0.200000
     RecoilYFactor=0.200000
     RecoilMax=3072.000000
     RecoilDeclineTime=1.000000
     FireModeClass(0)=Class'BWBPArchivePackDE.M99PrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.M99SecondaryFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bSniping=True
     Description="M99 ECS .55 Anti Material Rifle||Manufacturer: Enravion Combat Solutions|Primary: Single Powerful Shot|Secondary: Activate Zooming Scope||In the 21st century the M99 was an effective long range sniper rifle, with a high penetration power. During the Skrith wars however the M99 lost its relevance due to its slow fire rate and old ammunition. Weapons like the M75-TIC Railgun were far more effective and feared. In the middle of the war the production of the M75 was too expensive to arm every sniper with it. Thus Enravion Combat Solutions started to do researches on how to improve old firearms and they succeeded. The M99-ECS was the result. Many improvements like better materials and a high quality scope made the rifle useful again. The major improvement however was the ammunition. The new 55.cal ECS armor piercing round easily penetrates concrete wall, with minimal deformations. Due to its nano coating the 55.cal ECS projectile glides through the air with minimal aerodynamic drag. This way it keeps its high V0"
     DisplayFOV=55.000000
     Priority=33
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=9
     PickupClass=Class'BWBPArchivePackDE.M99Pickup'
     PlayerViewOffset=(X=10.000000,Y=-1.000000,Z=-13.000000)
     BobDamping=1.500000
     AttachmentClass=Class'BWBPArchivePackDE.M99Attachment'
     IconMaterial=Texture'BWWeaponPack-Tex.M99.SmallIcon_M99'
     IconCoords=(Y1=20,X2=127,Y2=39)
     ItemName="M99-ECS Anti-Material Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
	 ReloadAnimRate=1.25
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWWeaponPackAnims.M99Rifle'
     DrawScale=0.400000
}
