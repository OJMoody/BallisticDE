//=============================================================================
// ProtoLMG
//=============================================================================
class ProtoSMG extends BallisticWeapon;

#exec OBJ LOAD File=BWBP_CC_Tex.utx

var() sound			MeleeFireSound;

var	bool			bAltNeedCock;			//Should SG cock after reloading
var	bool			bReloadingShotgun;	//Used to disable primary fire if reloading the shotgun
var() name			ShotgunLoadAnim, ShotgunEmptyLoadAnim;
var() name			ShotgunSGAnim;
var() name			CockSGAnim;
var() Sound			AltClipOutSound;
var() Sound			AltClipInSound;
var() Sound			AltClipSlideInSound;
var() Sound			SGCockStartSound;
var() int	     	SGShells;
var byte			OldWeaponMode;
var() float			GunCockTime;		// Used so players cant interrupt the shotgun.

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


var float StealthRating, StealthImps;


replication
{
	//reliable if (Role == ROLE_Authority)
	    //SGShells;
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;
	
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

//===========================================================================
// EmptyFire
//
// Cock shotgun if alt and needs cocking
//===========================================================================
simulated function FirePressed(float F)
{
	if (!HasAmmo())
		OutOfAmmo();
	else if (bNeedReload && ClientState == WS_ReadyToFire)
	{
		//Do nothing!
	}
	else if (bCanSkipReload && ((ReloadState == RS_Shovel) || (ReloadState == RS_PostShellIn) || (ReloadState == RS_PreClipOut)))
	{
		ServerSkipReload();
		if (Level.NetMode == NM_Client)
			SkipReload();
	}
	//mod
	else 
	{
		if (F == 0)
		{
			if (ReloadState == RS_None && bNeedCock && !bPreventReload && MagAmmo > 0 && !IsFiring() && level.TimeSeconds > FireMode[0].NextfireTime)
			{
				CommonCockGun(0);
				if (Level.NetMode == NM_Client)
					ServerCockGun(0);
			}
		}
		else if (ReloadState == RS_None && bAltNeedCock && !bPreventReload && SGShells > 0 && !IsFiring() && Level.TimeSeconds > FireMode[1].NextFireTime)
		{
			CommonCockGun(5);
			if (Level.NetMode == NM_Client)
				ServerCockGun(5);
		}
	}
}

//===========================================================================
// PlayCocking
//
// Cocks shotgun on 5
//===========================================================================
simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else if (Type == 5)
		SafePlayAnim(CockSGAnim, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None)
		TemporaryScopeDown(default.SightingTime);
}

//===========================================================================
// Reload notifies
//===========================================================================
simulated function Notify_AltClipOut()	
{	
	PlaySound(AltClipOutSound, SLOT_Misc, 0.5, ,64);	
	ReloadState = RS_PreClipIn;
}
simulated function Notify_AltClipIn()          
{   
	local int AmmoNeeded;
	
	PlaySound(AltClipInSound, SLOT_Misc, 0.5, ,64);    
	ReloadState = RS_PostClipIn; 
	if (level.NetMode != NM_Client)
	{
		AmmoNeeded = default.SGShells-SGShells;
		if (AmmoNeeded > Ammo[1].AmmoAmount)
			SGShells+=Ammo[1].AmmoAmount;
		else
			SGShells = default.SGShells;   
		Ammo[1].UseAmmo (AmmoNeeded, True);
	}
}
simulated function Notify_AltClipSlideIn()	    
{	
	PlaySound(AltClipSlideInSound, SLOT_Misc, 0.5, ,64);	
}

simulated function Notify_SGCockStart()
{
	PlaySound(SGCockStartSound, SLOT_Misc, 0.5, ,64);
}

simulated function Notify_SGCockEnd()	
{
	bAltNeedCock=false;
	ReloadState = RS_GearSwitch;					
}

simulated function bool IsReloadingShotgun()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == ShotgunLoadAnim)
 		return true;
	return false;
}

function bool BotShouldReloadShotgun ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);
	
	if (AIController(Instigator.Controller) != None && bAltNeedCock && AmmoAmount(1) > 0 && BotShouldReloadShotgun() && !IsReloadingShotgun())
		ServerStartReload(1);
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	
	if (anim == CockSGAnim || anim == ShotgunEmptyLoadAnim)
	{
		bAltNeedCock=False;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
	}
	else
		Super.AnimEnd(Channel);
}

//===========================================================================
// ServerStartReload
//
// byte 1 reloads the shotgun.
//===========================================================================
function ServerStartReload (optional byte i)
{
	local int m;
	local array<byte> Loadings[2];
	
	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (i == 0 && MagAmmo >= default.MagAmmo)
	{
		if (bNeedCock)
		{
			ServerCockGun(0);
			return;
		}
	}
	// Escape on full shells
	if (i == 1 && SGShells >= default.SGShells)
	{
		if (bAltNeedCock)
		{
			ServerCockGun(5);
			return;
		}
	}
	
	if (MagAmmo < default.MagAmmo && Ammo[0].AmmoAmount > 0)
		Loadings[0] = 1;
	if (SGShells < default.SGShells && Ammo[1].AmmoAmount > 0)
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
	
	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('ReloadGun');
		
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
}

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

// Prepare to reload, set reload state, start anims. Called on client and server
simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	if (i == 1)
	{
		ReloadState = RS_PreClipOut;
		PlayReloadAlt();
	}
	else
	{
		ReloadState = RS_PreClipOut;
		PlayReload();
	}

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(default.SightingTime);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].ReloadingGun(i);

	if (i == 0)
	{
		if (bCockAfterReload)
			bNeedCock=true;
		if (bCockOnEmpty && MagAmmo < 1)
			bNeedCock=true;
	}
	bNeedReload=false;
}

simulated function PlayReloadAlt()
{
	if (SGShells == 0)
		SafePlayAnim(ShotgunEmptyLoadAnim, 1, , 0, "RELOAD");
	else
		SafePlayAnim(ShotgunLoadAnim, 1, , 0, "RELOAD");
}

//===========================================================================
// Silencer Code
//===========================================================================

function ServerSwitchSilencer(bool bNewValue)
{
	if (bNewValue == bSilenced)
		return;
		
	bSilenced = bNewValue;
	SwitchSilencer(bSilenced);
	bServerReloading=True;
	ReloadState = RS_GearSwitch;
	BFireMode[0].bAISilent = bSilenced;
	
	//ProtoSMG(BFireMode[0]).SetSilenced(bNewValue);
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
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

simulated function ApplySuppressorAim()
{
	AimComponent.AimSpread.Min *= 1.25;
	AimComponent.AimSpread.Max *= 1.25;
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

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

simulated function PlayReload()
{
	super.PlayReload();

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
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

// AI Interface =====
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

function bool CanAttack(Actor Other)
{
	if (bAltNeedCock)
	{
		if (IsReloadingShotgun())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadShotgun())
		{
			ServerStartReload(1);
			return false;
		}
	}
	return super.CanAttack(Other);
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
	ShotgunLoadAnim="ReloadAlt"
	ShotgunEmptyLoadAnim="ReloadEmptyAlt"
	//SGCockStartSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-Cock',Volume=2.000000)
	AltClipOutSound=Sound'BW_Core_WeaponSound.M50.M50GrenOpen'
	AltClipInSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
	AltClipSlideInSound=Sound'BW_Core_WeaponSound.M50.M50GrenClose'
	SGShells=6
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
	WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(ModeName="Photon Burst")
	WeaponModes(2)=(ModeName="Full Auto")
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
	Mesh=SkeletalMesh'BWBP_CC_Anim.FPm_ProtoLMG'
	DrawScale=0.400000
}
