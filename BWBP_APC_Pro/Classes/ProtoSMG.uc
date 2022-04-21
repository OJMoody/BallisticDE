//=============================================================================
// ProtoLMG
//=============================================================================
class ProtoSMG extends BallisticWeapon;

#exec OBJ LOAD File=BWBP_CC_Tex.utx

var   bool			bSilenced;				// Silencer on. Silenced
var() name			SilencerBone;			// Bone to use for hiding silencer
var() name			SilencerOnAnim;			// Think hard about this one...
var() name			SilencerOffAnim;		//
var() sound			SilencerOnSound;		// Silencer stuck on sound
var() sound			SilencerOffSound;		//
var() sound			SilencerOnTurnSound;	// Silencer screw on sound
var() sound			SilencerOffTurnSound;	//

var rotator ScopeSightPivot;
var vector ScopeSightOffset;

var rotator IronSightPivot;
var vector IronSightOffset;

var Name 			ReloadAltAnim;
var() int			PhotonMagAmmo;
var BUtil.FullSound DrumInSound, DrumHitSound, DrumOutSound;
var	bool			bAltNeedCock;			//Should SG cock after reloading

var float StealthRating, StealthImps;

replication
{
	reliable if (Role == ROLE_Authority)
		PhotonMagAmmo;
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
}

//=====================================================================
// SUPPRESSOR CODE
//=====================================================================
function ServerSwitchSilencer(bool bNewValue)
{
	if (bSilenced == bNewValue)
		return;

	bSilenced = bNewValue;
	SwitchSilencer(bSilenced);
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	TemporaryScopeDown(0.5);
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);

	StealthImpulse(0.1);
}

simulated function SwitchSilencer(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
	ReloadState = RS_GearSwitch;
	
	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);

	OnSuppressorSwitched();
}

simulated function OnRecoilParamsChanged()
{
	Super.OnRecoilParamsChanged();

	if (bSilenced)
		ApplySuppressorRecoil();
}

simulated function ApplySuppressorAim()
{
	AimComponent.AimSpread.Min *= 1.25;
	AimComponent.AimSpread.Max *= 1.25;
}

function ApplySuppressorRecoil()
{
	RcComponent.XRandFactor *= 0.7f;
	RcComponent.YRandFactor *= 0.7f;
}

simulated function StealthImpulse(float Amount)
{
	if (Instigator.IsLocallyControlled())
		StealthImps = FMin(1.0, StealthImps + Amount);
}

simulated function OnSuppressorSwitched()
{
	if (bSilenced)
	{
		ApplySuppressorAim();
		SightingTime *= 1.25;
	}
	else
	{
		AimComponent.Recalculate();
		SightingTime = default.SightingTime;
	}
}

simulated function Notify_SilencerAdd()
{
	PlaySound(SilencerOnSound,,0.5);
}

simulated function Notify_SilencerOnTurn()
{
	PlaySound(SilencerOnTurnSound,,0.5);
}

simulated function Notify_SilencerRemove()
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

simulated function PlayReload()
{
	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	super.PlayReload();

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}
simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		Instigator.AmbientSound = UsedAmbientSound;
		Instigator.SoundVolume = default.SoundVolume;
		Instigator.SoundPitch = default.SoundPitch;
		Instigator.SoundRadius = default.SoundRadius;
		Instigator.bFullVolume = false;
		return true;
	}
	return false;
}

//===========================================================================
// Dual scoping
//===========================================================================
exec simulated function ScopeView()
{
	if (ZoomType == ZT_Fixed && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	if (SightingState == SS_None)
	{
		if (ZoomType == ZT_Fixed)
		{
			SightPivot = IronSightPivot;
			SightOffset = IronSightOffset;
			ZoomType = ZT_Irons;
			ScopeViewTex = None;
			SightingTime = default.SightingTime;
		}
	}
	
	Super.ScopeView();
}

exec simulated function ScopeViewRelease()
{
	if (ZoomType != ZT_Irons && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	Super.ScopeViewRelease();
}

simulated function ScopeViewTwo()
{
	if (ZoomType == ZT_Irons && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	if (SightingState == SS_None)
	{
		ScopeViewTex = Texture'BWBP_CC_Tex.ProtoLMG.ProtoScope1';
		if (ZoomType == ZT_Irons)
		{
			SightPivot = ScopeSightPivot;
			SightOffset = ScopeSightOffset;
			ZoomType = ZT_Fixed;
			SightingTime = 0.4;
		}
	}
	
	Super.ScopeView();
}

simulated function ScopeViewTwoRelease()
{
	if (ZoomType == ZT_Irons && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	Super.ScopeViewRelease();
}

// Swap sighted offset and pivot for left handers
simulated function SetHand(float InHand)
{
	IronSightPivot = default.SightPivot;
	IronSightOffset = default.SightOffset;

	super.SetHand(InHand);
	if (Hand < 0)
	{
		if (ZoomType != ZT_Irons)
		{
			ScopeSightOffset.Y = ScopeSightOffset.Y * -1;
			ScopeSightPivot.Roll = ScopeSightPivot.Roll * -1;
			ScopeSightPivot.Yaw = ScopeSightPivot.Yaw * -1;
		}
		else
		{
			IronSightOffset.Y = IronSightOffset.Y * -1;
			IronSightPivot.Roll = IronSightPivot.Roll * -1;
			IronSightPivot.Yaw = IronSightPivot.Yaw * -1;
		}
	}
}

//=====================================================================
// Photon Fire
//=====================================================================
simulated function float ChargeBar()
{
	return float(PhotonMagAmmo)/float(default.PhotonMagAmmo);
}

//=====================================================================
// AI INTERFACE CODE
//=====================================================================
simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1 || bAltNeedCock)
		return 0;
	else if (MagAmmo < 1)
		return 1;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	VDot = Normal(B.Enemy.Velocity) Dot Normal(Instigator.Location - B.Enemy.Location);

	Result = FRand()-0.3;
	// Too far for grenade
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	if (VSize(B.Enemy.Velocity) > 50)
	{
		// Straight lines
		if (Abs(VDot) > 0.8)
			Result += 0.1;
		// Enemy running away
		if (VDot < 0)
			Result -= 0.2;
		else
			Result += 0.2;
	}
	// Higher than enemy
//	if (Height < 0)
//		Result += 0.1;
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}
// End AI Stuff =====

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
	ScopeSightPivot=(Roll=-4096)
	ScopeSightOffset=(X=15.000000,Y=-3.000000,Z=24.000000)
	
	SilencerBone="Silencer"
	SilencerOnAnim="SilencerOn"
	SilencerOffAnim="SilencerOff"
	SilencerOnSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOff'
	SilencerOnTurnSound=SoundGroup'BW_Core_WeaponSound.XK2.XK2-SilencerTurn'
	SilencerOffTurnSound=SoundGroup'BW_Core_WeaponSound.XK2.XK2-SilencerTurn'
	//AltClipOutSound=Sound'BW_Core_WeaponSound.M50.M50GrenOpen'
	//AltClipInSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
	//AltClipSlideInSound=Sound'BW_Core_WeaponSound.M50.M50GrenClose'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_CC_Tex.ProtoLMG.BigIcon_ProtoLMG'
	BigIconCoords=(X1=16,Y1=30)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	bWT_Shotgun=True
	bWT_Machinegun=True
	ManualLines(0)="Automatic 7.62mm fire. High power, but shorter effective range and suffers from high recoil."
	ManualLines(1)="Engages the secondary shotgun. Has a shorter range than other shotguns and moderate spread."
	ManualLines(2)="Effective at close to medium range."
	SpecialInfo(0)=(Info="240.0;25.0;0.9;85.0;0.1;0.9;0.4")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
	MagAmmo=50
	CockAnimPostReload="Cock"
	CockAnimRate=1.400000
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-Cock',Volume=2.000000)
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50ClipHit')
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-MagOut',Volume=2.000000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-MagIn',Volume=2.000000)
	ClipInFrame=0.700000
	bAltTriggerReload=True
	WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Photon Burst")
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bNoCrosshairInScope=False
	SightPivot=(Pitch=128)
	SightOffset=(X=-10.000000,Y=-0.950000,Z=25.000000)
	GunLength=16.000000
	ParamsClasses(0)=Class'ProtoWeaponParams' 
	ParamsClasses(1)=Class'ProtoWeaponParams' 
	AmmoClass[0]=Class'BWBP_APC_Pro.Ammo_Proto'
	AmmoClass[1]=Class'BWBP_APC_Pro.Ammo_Proto'
	FireModeClass(0)=Class'BWBP_APC_Pro.ProtoPrimaryFire'
	FireModeClass(1)=Class'BWBP_APC_Pro.ProtoScopeFire'
	SelectAnimRate=1.000000
	PutDownAnimRate=1.000000
	PutDownTime=1.000000
	BringUpTime=1.000000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.750000
	CurrentRating=0.750000
	Description="Dipheox's most popular weapon, the CYLO Versatile Urban Assault Weapon is designed with one goal in mind: Brutal close quarters combat. The CYLO accomplishes this goal quite well, earning itself the nickname of Badger with its small frame, brutal effectiveness, and unpredictability. UTC refuses to let this weapon in the hands of its soldiers because of its erratic firing and tendency to jam.||The CYLO Versatile UAW is fully capable for urban combat. The rifle's caseless 7.62mm rounds can easily shoot through doors and thin walls, while the shotgun can clear a room quickly with its semi-automatic firing. Proper training with the bayonet can turn the gun itself into a deadly melee weapon."
	DisplayFOV=55.000000
	Priority=41
	HudColor=(G=135)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=6
	GroupOffset=10
	PickupClass=Class'BWBP_APC_Pro.ProtoPickup'
	PlayerViewOffset=(X=16.000000,Y=7.000000,Z=-17.000000)
	BobDamping=2.000000
	AttachmentClass=Class'BWBP_APC_Pro.ProtoAttachment'
	IconMaterial=Texture'BWBP_CC_Tex.ProtoLMG.SmallIcon_ProtoLMG'
	IconCoords=(X2=127,Y2=31)
	ItemName="[B] FC-01B PROTO Light Machinegun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	bShowChargingBar=True
	Mesh=SkeletalMesh'BWBP_CC_Anim.FPm_ProtoLMG'
	DrawScale=0.400000
}