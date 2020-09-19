//=============================================================================
// KG16Pistol.
//
// Semi Automatic pistol with decent damage, 12 round clip, good accracy when
// used carefully, but mainly, its the default weapon.
// Secondary fixes to unpredictable aiming by providing a laser sight so that
// the user knows where to expect the bullets.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class KG16Pistol extends BallisticHandgun;

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

simulated function bool SlaveCanUseMode(int Mode)
{
	if(KG16Pistol(OtherGun) != None)
		return (Mode == 0 || (Mode == 1 && Level.TimeSeconds >= FireMode[Mode].NextFireTime));

	return Mode == 0;
}

simulated function bool MasterCanSendMode(int Mode)
{
	if(KG16Pistol(OtherGun) != None)
		return Mode < 2;

	return Mode == 0;
}

simulated function bool CanAlternate(int Mode)
{
	if (KG16Pistol(OtherGun) == None && Mode != 0)
		return false;
	else if(KG16Pistol(OtherGun) != None)
		return true;

	return super.CanAlternate(Mode);
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
		if (bLaserOn)
			AimAdjustTime = default.AimAdjustTime * 1.5;
		else
			AimAdjustTime = default.AimAdjustTime;
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
		KG16Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
	if (bLaserOn)
	{	
		AimAdjustTime = default.AimAdjustTime * 1.5;
		ChaosAimSpread *= 0.65;
	}

	else
	{
		AimAdjustTime = default.AimAdjustTime;
		ChaosAimSpread = default.ChaosAimSpread;
	}

    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,0.7,,32);
		ChaosAimSpread *= 0.65;
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,0.7,,32);
		ChaosAimSpread = default.ChaosAimSpread;
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

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'IdleOpen';
		ReloadAnim = 'ReloadOpen';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

	if ( ThirdPersonActor != None )
		KG16Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
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
	{
		LaserDot = Spawn(class'KG16LaserDot',,,Loc);
		AttachToBone(LaserDot, 'Laser');
	}
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			KG16Attachment(ThirdPersonActor).bLaserOn = false;
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
	Loc = GetBoneCoords('Laser').Origin;

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
		AimDir = GetBoneRotation('Laser');
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

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'FireOpen' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'IdleOpen';
			ReloadAnim = 'ReloadOpen';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
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
// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();

	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
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
     LaserOnSound=Sound'BallisticSounds2.M806.M806LSight'
     LaserOffSound=Sound'BallisticSounds2.M806.M806LSight'
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BWBPArchivePackTex.KG16.BigIcon_KG16'
     SightFXClass=Class'BWBPArchivePackDE.KG16FrontSightLED'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
	 bWT_Bullet=True
	 bShouldDualInLoadout=False
     SpecialInfo(0)=(Info="0.0;8.0;-999.0;25.0;0.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway')
     MagAmmo=10
     CockSound=(Sound=Sound'BallisticSounds2.M806.M806-Cock')
     ClipHitSound=(Sound=Sound'BallisticSounds2.AM67.AM67-ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.AM67.AM67-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.AM67.AM67-ClipIn')
     ClipInFrame=0.650000
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightOffset=(X=-5.000000,Y=-2.050000,Z=8.80000)
	 SightPivot=(Pitch=-512)
     SightDisplayFOV=60.000000
	 SightingTime=0.200000
	 SightAimFactor=0.1
	 AimSpread=32
     AimAdjustTime=0.450000
     ChaosDeclineTime=0.320000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=1024
     RecoilYawFactor=0.200000
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=1.5
     RecoilDeclineDelay=0.400000
     FireModeClass(0)=Class'BWBPArchivePackDE.KG16PrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.KG16SecondaryFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     Description="KG16 'Strammer Elch' 9mm Pistol||Manufacturer: Herr Doctors Secret Labs|Primary: 9mm Parabellum single fire|Secondary: 9mm Parabellum automatic fire||The KG16 was developed in response to laboratory rats and all sorts of cattle roaming the detention cells. Herr Doctor himself improved the common ordonnance weapon and gave it an excellent automatic secondary fire mode to deal with the vermin. Its nicknme, 'Strammer Elch', was bestowed upon it by the attentive laboratory assistants, who were well aware that the disinfectant used in the various surgeries could be better put to use in another way...|Beside the strong smell of absinthe, Herr Doctor was for some reason quite intoxicated after the operations...""
     Priority=19
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	 InventoryGroup=2
	 InventorySize=5
     GroupOffset=8
     PickupClass=Class'BWBPArchivePackDE.KG16Pickup'
     PlayerViewOffset=(X=5.000000,Y=6.000000,Z=-8.000000)
     PlayerViewPivot=(Pitch=512)
	 BobDamping=2.250000
     AttachmentClass=Class'BWBPArchivePackDE.KG16Attachment'
     IconMaterial=Texture'BWBPArchivePackTex.KG16.SmallIcon_KG16'
     IconCoords=(X2=127,Y2=31)
     ItemName="KG16 Assault Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWXWeaponAnims.KG_FPm'
     DrawScale=1.000000
}
