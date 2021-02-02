//=============================================================================
// RS8Pistol.
//
// A medium power pistol with a lasersight and silencer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SX45Pistol extends BallisticWeapon;

var   bool		bAmped;						// ARE YOU AMPED? BECAUSE THIS GUN IS!
var() name		AmplifierBone;				// Bone to use for hiding cool shit
var() name		AmplifierBone2;				// Xav likes to make my life difficult
var() name		AmplifierOnAnim;			//
var() name		AmplifierOffAnim;			//
var() sound		AmplifierOnSound;			// 
var() sound		AmplifierOffSound;			//
var() sound		AmplifierPowerOnSound;		// Electrical noises?
var() sound		AmplifierPowerOffSound;		//
var() float		AmplifierSwitchTime;		//

var() array<Material> CamoMaterials; //We're using this for the amp

var Projector	FlashLightProj;
var Emitter		FlashLightEmitter;
var bool		bLightsOn;
var() name		FlashlightAnim;

var bool		bFirstDraw;
var vector		TorchOffset;
var() Sound		TorchOnSound;
var() Sound		TorchOffSound;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerFlashLight, ServerSwitchAmplifier;
}

simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

//==============================================
// Amp Code
//==============================================

exec simulated function CommonSwitchAmplifier(optional byte i)
{
	if (level.TimeSeconds < AmplifierSwitchTime || ReloadState != RS_None || SightingState != SS_None)
		return;
		
	TemporaryScopeDown(0.5);
	AmplifierSwitchTime = level.TimeSeconds + 2.0;
	bAmped = !bAmped;
	ServerSwitchAmplifier(bAmped);
	SwitchAmplifier(bAmped);
}

function ServerSwitchAmplifier(bool bNewValue)
{
	bServerReloading=True;
	ReloadState = RS_GearSwitch;

	AmplifierSwitchTime = level.TimeSeconds + 2.0;
	bAmped = bNewValue;
	if (bAmped)
	{
			WeaponModes[0].bUnavailable=true;
			WeaponModes[1].bUnavailable=false;
			WeaponModes[2].bUnavailable=false;
			CurrentWeaponMode=1;
			ServerSwitchWeaponMode(1);
	}
	else
	{
			WeaponModes[0].bUnavailable=false;
			WeaponModes[1].bUnavailable=true;
			WeaponModes[2].bUnavailable=true;
			CurrentWeaponMode=0;
			ServerSwitchWeaponMode(0);
	}
}

simulated function SwitchAmplifier(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
		
	ReloadState = RS_GearSwitch;

	if (bNewValue)
		PlayAnim(AmplifierOnAnim);
	else
		PlayAnim(AmplifierOffAnim);
		
	if (Role == ROLE_Authority)
		SX45Attachment(ThirdPersonActor).SetAmped(bNewValue);
	
	if (CurrentWeaponMode == 1)	//cryo
	{
		SX45Attachment(ThirdPersonActor).SetAmpColour(true, false);
		Skins[6]=CamoMaterials[1];
		Skins[7]=CamoMaterials[2];
	}
	else if (CurrentWeaponMode == 2)	//RAD
	{
		SX45Attachment(ThirdPersonActor).SetAmpColour(false, true);
		Skins[6]=CamoMaterials[0];
		Skins[7]=CamoMaterials[3];
	}
}

simulated function Notify_SilencerOn()	{	PlaySound(AmplifierOnSound,,0.5);	}
simulated function Notify_SilencerOff()	{	PlaySound(AmplifierOffSound,,0.5);	}

simulated function Notify_SilencerShow()
{	
	SetBoneScale (0, 1.0, AmplifierBone);	
	SetBoneScale (2, 0.0, AmplifierBone2);	
}
simulated function Notify_SilencerHide()
{	
	SetBoneScale (0, 0.0, AmplifierBone);	
	SetBoneScale (2, 1.0, AmplifierBone2);	
}
simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

function ServerSwitchWeaponMode (byte newMode)
{
	super.ServerSwitchWeaponMode (newMode);
	if (!Instigator.IsLocallyControlled())
		SX45PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		
	ClientSwitchWeaponMode (CurrentWeaponMode);
}
simulated function ClientSwitchWeaponMode (byte newMode)
{
	SX45PrimaryFire(FireMode[0]).SwitchWeaponMode(newMode);
	if (newMode == 1)
	{
		SX45Attachment(ThirdPersonActor).SetAmpColour(true, false);
		Skins[6]=CamoMaterials[1];
		Skins[7]=CamoMaterials[2];
	}
	else if (newMode == 2)
	{
		SX45Attachment(ThirdPersonActor).SetAmpColour(false, true);
		Skins[6]=CamoMaterials[0];
		Skins[7]=CamoMaterials[3];
	}
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(PrevWeapon);

	if (AIController(Instigator.Controller) != None)
	{
		bAmped = (FRand() > 0.5);
		bLightsOn == (FRand() > 0.5);
	}

	if (bAmped)
	{
		SetBoneScale (0, 1.0, AmplifierBone);
		SetBoneScale (2, 0.0, AmplifierBone2);
	}		
	else
	{
		SetBoneScale (0, 0.0, AmplifierBone);
		SetBoneScale (2, 1.0, AmplifierBone2);	
	}
}

//======================================================

exec simulated function WeaponSpecial(optional byte i)
{
	if (level.TimeSeconds < AmplifierSwitchTime)
		return;

	SafePlayAnim(FlashlightAnim, 1, 0, ,"FIRE");
	bLightsOn = !bLightsOn;
	ServerFlashLight(bLightsOn);
	if (bLightsOn)
	{
		PlaySound(TorchOnSound,,0.7,,32);
		if (FlashLightEmitter == None)
			FlashLightEmitter = Spawn(class'MRS138TorchEffect',self,,location);
		class'BallisticEmitter'.static.ScaleEmitter(FlashLightEmitter, DrawScale);
		StartProjector();
	}
	else
	{
		PlaySound(TorchOffSound,,0.7,,32);
		if (FlashLightEmitter != None)
			FlashLightEmitter.Destroy();
		KillProjector();
	}
}

function ServerFlashLight (bool bNew)
{
	bLightsOn = bNew;
	SX45Attachment(ThirdPersonActor).bLightsOn = bLightsOn;
}

simulated function StartProjector()
{
	if (FlashLightProj == None)
		FlashLightProj = Spawn(class'MRS138TorchProjector',self,,location);
	AttachToBone(FlashLightProj, 'tip3');
	FlashLightProj.SetRelativeLocation(TorchOffset);
}
simulated function KillProjector()
{
	if (FlashLightProj != None)
		FlashLightProj.Destroy();
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (!bLightsOn || ClientState != WS_ReadyToFire)
		return;
	if (!Instigator.IsFirstPerson())
		KillProjector();
	else if (FlashLightProj == None)
		StartProjector();
}

simulated event RenderOverlays( Canvas Canvas )
{
	local Vector TazLoc;
	local Rotator TazRot;
	super.RenderOverlays(Canvas);
	if (bLightsOn)
	{
		TazLoc = GetBoneCoords('tip3').Origin;
		TazRot = GetBoneRotation('tip3');
		if (FlashLightEmitter != None)
		{
			FlashLightEmitter.SetLocation(TazLoc);
			FlashLightEmitter.SetRotation(TazRot);
			Canvas.DrawActor(FlashLightEmitter, false, false, DisplayFOV);
		}
	}
}

simulated function PlayIdle()
{
	super.PlayIdle();

	if (bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillProjector();
		if (FlashLightEmitter != None)
			FlashLightEmitter.Destroy();
		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	if (FlashLightEmitter != None)
		FlashLightEmitter.Destroy();
	KillProjector();
	super.Destroyed();
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'FireOpen' || Anim == 'Pullout' || Anim == 'PulloutAlt' || Anim == 'Fire' || Anim == 'FireDualOpen' || Anim == 'FireDual' ||Anim == CockAnim || Anim == ReloadAnim || Anim == 'FireOpen' || Anim == 'SightFireOpen')
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'IdleOpen';
			PutDownAnim = 'PutawayOpen';
			ReloadAnim = 'ReloadOpen';
			FlashlightAnim = 'ToggleFlashLightOpen';
			AmplifierOnAnim = 'AmpAddOpen';
			AmplifierOffAnim = 'AmpRemoveOpen';
		}
		else
		{
			IdleAnim = 'Idle';
			PutDownAnim = 'Putaway';
			ReloadAnim = 'Reload';
			FlashlightAnim = 'ToggleFlashLight';
			AmplifierOnAnim = 'AmpAdd';
			AmplifierOffAnim = 'AmpRemove';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 2)
		SetBoneScale (1, 0.0, 'Bullet');
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
function byte BestMode()
{
	CurrentWeaponMode=2;
	return 0;
}
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
	if (Dist > 500)
		Result += 0.2;
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result -= 0.05 * B.Skill;
	if (Dist > 1000)
		Result -= (Dist-1000) / 4000;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_SX45Clip';
}

defaultproperties
{
	CamoMaterials[0]=Shader'BWBP_SKC_Tex.AMP.Amp-FinalYellow'
	CamoMaterials[1]=Shader'BWBP_SKC_Tex.AMP.Amp-FinalCyan'
	CamoMaterials[2]=Shader'BWBP_SKC_Tex.Amp.Amp-GlowCyanShader'
    CamoMaterials[3]=Shader'BWBP_SKC_Tex.Amp.Amp-GlowYellowShader'
    AmplifierBone="AMP"
    AmplifierBone2="AMP2"
    AmplifierOnAnim="AMPAdd"
    AmplifierOffAnim="AMPRemove"
	FlashlightAnim="ToggleFlashlight"
	TorchOnSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
    TorchOffSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
    AmplifierOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
    AmplifierOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
    AmplifierPowerOnSound=Sound'BW_Core_WeaponSound.VPR.VPR-ClipIn'
    AmplifierPowerOffSound=Sound'BW_Core_WeaponSound.VPR.VPR-ClipOut'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SKC_TexExp.SX45.BigIcon_SX45'
	BigIconCoords=(X1=64,Y1=70,X2=418)
	BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
	bWT_Bullet=True
	ManualLines(0)="Semi-automatic .45 ACP Fire. Moderate damage and fire rate."
	ManualLines(1)="Attach/Detach AMP. With a Choice of Radiation Bullets and Cryogenic Bullets"
	ManualLines(2)="Torch Available on the Weapon Function"
	SpecialInfo(0)=(Info="0.0;-5.0;-999.0;-1.0;0.0;-999.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BWBP_SKC_SoundsExp.SX45.SX45-Cock')
	ReloadAnimRate=1.250000
	SelectAnimRate=1.500000
	BringUpTime=0.700000
	ClipOutSound=(Sound=Sound'BWBP_SKC_SoundsExp.SX45.SX45-MagOut')
	ClipInSound=(Sound=Sound'BWBP_SKC_SoundsExp.SX45.SX45-MagIn')
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806-ClipHit')
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Semi-Auto")
    WeaponModes(1)=(ModeName="Amplified: Cryogenic",ModeID="WM_FullAuto",bUnavailable=True)
    WeaponModes(2)=(ModeName="Amplified: Radiation",ModeID="WM_FullAuto",bUnavailable=True)
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	SightOffset=(y=-3.140000,Z=14.300000)
	SightDisplayFOV=60.000000
	ParamsClass=Class'SX45WeaponParams'
	FireModeClass(0)=Class'BWBPAnotherPackDE.SX45PrimaryFire'
	FireModeClass(1)=Class'BWBPAnotherPackDE.SX45SecondaryFire'
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.600000
	CurrentRating=0.6
	Description="As the skrith wars wages onwards, new companies are sprouting left and right to aid in trying times.  The latest to enter into the foray is Storm-X, or SX LTD for short with their offerings of the SX-45K Combat Handgun, chambered in .45ACP and intends to replace the service standard M806.  Precision and power is the motto of this handgun with a Mini-RDS and a threaded barrel to mount various options, including the experimental elemental amp that makes the pistol fire cyro bullets that split or radioactive bullets that leaves clouds behind."
	Priority=17
	HudColor=(B=255,G=200,R=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=7
	PickupClass=Class'BWBPAnotherPackDE.SX45Pickup'
	PlayerViewOffset=(X=0.000000,Y=7.000000,Z=-12.000000)
	AttachmentClass=Class'BWBPAnotherPackDE.SX45Attachment'
	IconMaterial=Texture'BWBP_SKC_TexExp.SX45.SmallIcon_SX45'
	IconCoords=(X2=127,Y2=31)
	ItemName="SX-45K Combat Handgun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_FNX'
	DrawScale=0.300000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
    Skins(1)=Texture'BWBP_SKC_TexExp.SX45.SX45-Mag'
    Skins(2)=Shader'BWBP_SKC_TexExp.SX45.SX45-SightReticle_S'
    Skins(3)=Texture'BWBP_SKC_TexExp.SX45.SX45-Sight'
    Skins(4)=Texture'BWBP_SKC_TexExp.SX45.SX45-Main'
    Skins(5)=Texture'BWBP_SKC_TexExp.SX45.SX45-Laser'
    Skins(6)=Shader'BWBP_SKC_Tex.Amp.Amp-FinalCyan'
	Skins(7)=Shader'BWBP_SKC_Tex.Amp.Amp-GlowCyanShader'
}
