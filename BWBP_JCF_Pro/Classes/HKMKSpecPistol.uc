//=============================================================================
// HKMKSpecPistol.
//
// A medium power pistol with a lasersight and silencer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HKMKSpecPistol extends BallisticHandgun;

var   bool			bSilenced;				// Silencer on. Silenced
var() name			SilencerBone;			// Bone to use for hiding silencer
var() name			SilencerOnAnim;			// Think hard about this one...
var() name			SilencerOffAnim;		//
var() sound			SilencerOnSound;		// Silencer stuck on sound
var() sound			SilencerOffSound;		//
var() sound			SilencerOnTurnSound;	// Silencer screw on sound
var() sound			SilencerOffTurnSound;	//

var Name 			ReloadAltAnim;
var int 			AltAmmo;
var BUtil.FullSound DrumInSound, DrumOutSound;

replication
{
	reliable if (Role < ROLE_Authority)
		AltAmmo, ServerSwitchSilencer;
}

//==================================================================
// NewDrawWeaponInfo
//
// Draws icons for number of darts in mag
//==================================================================
simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local int i,Count;
	local float AmmoDimensions;

	local float	ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;

	DrawCrosshairs(C);

	ScaleFactor = C.ClipX / 1600;
	AmmoDimensions = C.ClipY * 0.06;
	
	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = class'HUD'.Default.WhiteColor;
	Count = Min(6,AltAmmo);
	
    for( i=0; i < Count; i++ )
    {
		C.SetPos(C.ClipX - (0.5*i+1) * AmmoDimensions, C.ClipY * (1 - (0.12 * class'HUD'.default.HUDScale)));
		C.DrawTile( Texture'BWBP_SKC_Tex.CYLO.CYLO-SGIcon',AmmoDimensions, AmmoDimensions, 0, 0, 128, 128);
	}
	
	if (bSkipDrawWeaponInfo)
		return;

	// Draw the spare ammo amount
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	if (!bNoMag)
	{
		Temp = GetHUDAmmoText(0);
		if (Temp == "0")
			C.DrawColor = class'hud'.default.RedColor;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
		C.DrawColor = class'hud'.default.WhiteColor;
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		Temp = GetHUDAmmoText(1);
		if (Temp == "0")
			C.DrawColor = class'hud'.default.RedColor;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
		C.DrawColor = class'hud'.default.WhiteColor;
	}

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
		C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 130 * ScaleFactor * class'HUD'.default.HudScale - YL2 - YL;
		C.DrawText(WeaponModes[CurrentWeaponMode].ModeName, false);
	}

	// This is pretty damn disgusting, but the weapon seems to be the only way we can draw extra info on the HUD
	// Would be nice if someone could have a HUD function called along the inventory chain
	if (SprintControl != None && SprintControl.Stamina < SprintControl.MaxStamina)
	{
		SprintFactor = SprintControl.Stamina / SprintControl.MaxStamina;
		C.CurX = C.OrgX  + 5    * ScaleFactor * class'HUD'.default.HudScale;
		C.CurY = C.ClipY - 330  * ScaleFactor * class'HUD'.default.HudScale;
		if (SprintFactor < 0.2)
			C.SetDrawColor(255, 0, 0);
		else if (SprintFactor < 0.5)
			C.SetDrawColor(64, 128, 255);
		else
			C.SetDrawColor(0, 0, 255);
		C.DrawTile(Texture'Engine.MenuWhite', 200 * ScaleFactor * class'HUD'.default.HudScale * SprintFactor, 30 * ScaleFactor * class'HUD'.default.HudScale, 0, 0, 1, 1);
	}
}

//===========================================================================
// ServerStartReload
//
// Generic code for weapons which have multiple magazines.
//===========================================================================
function ServerStartReload (optional byte i)
{
	local int m;
	local array<byte> Loadings[2];
	
	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (MagAmmo < default.MagAmmo && Ammo[0].AmmoAmount > 0)
		Loadings[0] = 1;
	if (AltAmmo < 6 && Ammo[1].AmmoAmount > 0)
		Loadings[1] = 1;
	if (Loadings[0] == 0 && Loadings[1] == 0)
		return;

	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;
	
	if (i == 1)
		m = 0;
	else m = 1;
	
	if (Loadings[i] == 1)
	{
		ClientStartReload(i);
		CommonStartReload(i);
	}
	
	else if (Loadings[m] == 1)
	{
		ClientStartReload(m);
		CommonStartReload(m);
	}
	
	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('ReloadGun');
}

//==================================================================
// ClientStartReload
//
// Dispatch reload based on desired mag
//==================================================================
simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1)
			CommonStartReload(1);
		else
			CommonStartReload(0);
	}
}

//==================================================================
// CommonStartReload
//
// Handle multiple magazines
//==================================================================
simulated function CommonStartReload (optional byte i)
{
	local int m;

	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;

    switch(i)
    {
    case 0:
    	ReloadState = RS_StartShovel;
		PlayReload();
        break;
    case 1:
    	ReloadState = RS_PreClipOut;
		PlayReloadAlt();
        break;
    }

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(Default.SightingTime);

	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].ReloadingGun(i);

	if (bCockAfterReload)
		bNeedCock=true;
	if (bCockOnEmpty && MagAmmo < 1)
		bNeedCock=true;
	bNeedReload=false;
}

simulated function PlayReloadAlt()
{
	SafePlayAnim(ReloadAltAnim, 1, , 0, "RELOAD");
}

simulated function Notify_ReloadAltOut()	
{	
	PlayOwnedSound(DrumOutSound.Sound,DrumOutSound.Slot,DrumOutSound.Volume,DrumOutSound.bNoOverride,DrumOutSound.Radius,DrumOutSound.Pitch,DrumOutSound.bAtten);
	ReloadState = RS_PreClipIn;
}

simulated function Notify_ReloadAltIn()          
{   
	local int AmmoNeeded;
	
	PlayOwnedSound(DrumInSound.Sound,DrumInSound.Slot,DrumInSound.Volume,DrumInSound.bNoOverride,DrumInSound.Radius,DrumInSound.Pitch,DrumInSound.bAtten);    
	ReloadState = RS_PostClipIn; 
	
	if (Level.NetMode != NM_Client)
	{
		AmmoNeeded = default.AltAmmo - AltAmmo;
		if (AmmoNeeded > Ammo[1].AmmoAmount)
			AltAmmo +=Ammo[1].AmmoAmount;
		else
			AltAmmo = default.AltAmmo;   
		Ammo[1].UseAmmo (AmmoNeeded, True);
	}
}

simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

simulated state PendingSwitchSilencer extends PendingDualAction
{
	simulated function BeginState()	{	OtherGun.LowerHandGun();	}
	simulated function HandgunLowered (BallisticHandgun Other)	{ global.HandgunLowered(Other); if (Other == Othergun) WeaponSpecial();	}
	simulated event AnimEnd(int Channel)
	{
		Othergun.RaiseHandGun();
		global.AnimEnd(Channel);
	}
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	Super.PostNetReceive();
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

simulated function OnScopeViewChanged()
{
	super.OnScopeViewChanged();

	if (Hand < 0)
		SightOffset.Y = default.SightOffset.Y * -1;
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	if (bIsPendingHandGun || PendingHandGun!=None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	if (Othergun != None)
	{
		if (Othergun.Clientstate != WS_ReadyToFire)
			return;
		if (IsinState('DualAction'))
			return;
		if (!Othergun.IsinState('Lowered'))
		{
			GotoState('PendingSwitchSilencer');
			return;
		}
	}
	TemporaryScopeDown(0.5);
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);
}

simulated function SwitchSilencer(bool bNewValue)
{
	if(Role == ROLE_Authority)
		bServerReloading=False;
	ReloadState = RS_GearSwitch;
	
	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);
}
simulated function Notify_SilencerOn()
{
	PlaySound(SilencerOnSound,,0.5);
}
simulated function Notify_SilencerOnTurn()
{
	PlaySound(SilencerOnTurnSound,,0.5);
}
simulated function Notify_SilencerOff()
{
	PlaySound(SilencerOffSound,,0.5);
}
simulated function Notify_SilencerOffTurn()
{
	PlaySound(SilencerOffTurnSound,,0.5);
}
simulated function Notify_SilencerShow()
{
	SetBoneScale (0, 1.0, SilencerBone);
}
simulated function Notify_SilencerHide()
{
	SetBoneScale (0, 0.0, SilencerBone);
}
simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'IdleOpen';
		ReloadAnim = 'ReloadOpen';
		SilencerOnAnim = 'SilencerAddOpen';
		SilencerOffAnim = 'SilencerRemoveOpen';
		//AltReloadAnim = 'ReloadAltOpen';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
		SilencerOnAnim = 'SilencerAdd';
		SilencerOffAnim = 'SilencerRemove';
		//AltReloadAnim = 'ReloadAlt';
	}

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

function ServerSwitchSilencer(bool bNewValue)
{
	bSilenced = bNewValue;
	BFireMode[0].bAISilent = bSilenced;
	SwitchSilencer(bSilenced);
	if (bSilenced)
		BFireMode[0].FireRecoil *= 0.85;
	else BFireMode[0].FireRecoil = BFireMode[0].default.FireRecoil;
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim || Anim == ReloadAltAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'IdleOpen';
			ReloadAnim = 'ReloadOpen';
			SilencerOnAnim = 'SilencerAddOpen';
			SilencerOffAnim = 'SilencerRemoveOpen';
			ReloadAltAnim = 'ReloadAltOpen';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
			SilencerOnAnim = 'SilencerAdd';
			SilencerOffAnim = 'SilencerRemove';
			ReloadAltAnim = 'ReloadAlt';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_HKMKSpecBullets';
}

defaultproperties
{
	AltAmmo=6
	ReloadAltAnim="ReloadAlt"
	DrumInSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOn',Volume=0.500000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	DrumOutSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOff',Volume=0.500000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	SilencerBone="Silencer"
	SilencerOnAnim="SilencerAdd"
	SilencerOffAnim="SilencerRemove"
	SilencerOnSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOff'
	SilencerOnTurnSound=Sound'BW_Core_WeaponSound.Pistol.RSP-SilencerTurn'
	SilencerOffTurnSound=Sound'BW_Core_WeaponSound.Pistol.RSP-SilencerTurn'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_JCF_Tex.MK23.BigIcon_MK23'
	BigIconCoords=(X1=64,Y1=70,X2=418)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	ManualLines(0)="Semi-automatic 10mm fire. Moderate damage and fire rate. Has the option of burst fire."
	ManualLines(1)="Attaches a suppressor, reducing the effective range but removing the flash and reducing the noise output."
	ManualLines(2)="Weapon Function toggles a laser sight, reducing the hipfire spread."
	SpecialInfo(0)=(Info="0.0;-5.0;-999.0;-1.0;0.0;-999.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
	PutDownTime=0.500000
	CockAnimRate=1.250000
	ReloadAnimRate=1.250000
	CockSound=(Sound=Sound'BWBP_JCF_Sounds.MK23.mk23_cock',Volume=2.300000)
    ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-ClipHit',Volume=0.700000)
    ClipOutSound=(Sound=Sound'BWBP_JCF_Sounds.MK23.MKClipOut',Volume=1.300000)
    ClipInSound=(Sound=Sound'BWBP_JCF_Sounds.MK23.MKClipIn',Volume=1.300000)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	SightOffset=(X=-15.000000,Z=8.700000)
	SightDisplayFOV=60.000000
	ParamsClasses(0)=Class'HKMKSpecWeaponParams'
	FireModeClass(0)=Class'BWBP_JCF_Pro.HKMKSpecPrimaryFire'
	FireModeClass(1)=Class'BWBP_JCF_Pro.HKMKSpecSecondaryFire'
	bShouldDualInLoadout=False
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross4',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=79,G=78,R=82,A=251),Color2=(B=0,G=116,R=255,A=255),StartSize1=79,StartSize2=33)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.800000,X2=0.500000,Y2=1.000000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=6.000000,CurrentScale=0.000000)
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.600000
	CurrentRating=0.6
	Description="A fine and reliable weapon, produced by a rather new company, the 10mm RS8 pistol is bound for success. Featuring a 14 round, 10mm magazine, laser sight and silencer, as well as an effective closer range, 3-round burst fire mode. Use the laser sight to see exactly where your gun is aimed, and the silencer when stealth and quietness are required. The RS8 being a fairly recent firearm, first manufactured during the second-war, has not seen as much action as other older pistols, and some critics say it won't be able to stand up to a Cryon, let alone a Skrith!"
	Priority=17
	HudColor=(B=255,G=200,R=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=11
	PickupClass=Class'BWBP_JCF_Pro.HKMKSpecPickup'
	PlayerViewOffset=(X=3.000000,Y=9.000000,Z=-10.000000)
	AttachmentClass=Class'BWBP_JCF_Pro.HKMKSpecAttachment'
	IconMaterial=Texture'BWBP_JCF_Tex.MK23.SmallIcon_MK23'
	IconCoords=(X2=127,Y2=31)
	ItemName="HKMK23 Assault Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BWBP_JCF_Anims.FPm_HKMKSpec'
	DrawScale=0.300000
}
