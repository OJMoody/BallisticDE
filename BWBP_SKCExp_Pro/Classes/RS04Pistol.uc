//=============================================================================
// RS04Pistol.
//
// A medium power pistol with a flasht lgIJELHtn
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RS04Pistol extends BallisticHandGun;

var() name		SilencerBone;			// Bone to use for hiding silencer

var	  byte			CurrentWeaponMode2;

var Projector	FlashLightProj;
var Emitter		FlashLightEmitter;
var bool		bLightsOn;
var bool		bFirstDraw;
var vector		TorchOffset;
var() Sound		TorchOnSound;
var() Sound		TorchOffSound;
var() Sound		DrawSoundQuick;		//For first draw

var() name		FlashlightAnim;
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() sound		SilencerOnTurnSound;	// Silencer screw on sound
var() sound		SilencerOffTurnSound;	//

replication
{
	reliable if (Role < ROLE_Authority)
		ServerFlashLight, ServerSwitchSilencer;
}

simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}



exec simulated function WeaponSpecial(optional byte i)
{
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
	RS04Attachment(ThirdPersonActor).bLightsOn = bLightsOn;
}

simulated function StartProjector()
{
	if (FlashLightProj == None)
		FlashLightProj = Spawn(class'MRS138TorchProjector',self,,location);
	AttachToBone(FlashLightProj, 'tip2');
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
		TazLoc = GetBoneCoords('tip2').Origin;
		TazRot = GetBoneRotation('tip2');
		if (FlashLightEmitter != None)
		{
			FlashLightEmitter.SetLocation(TazLoc);
			FlashLightEmitter.SetRotation(TazRot);
			Canvas.DrawActor(FlashLightEmitter, false, false, DisplayFOV);
		}
	}
}



simulated function SetBurstModeProps()
{
	if (CurrentWeaponMode == 1)
	{
		BFireMode[0].FireRate = 0.04;
		BFireMode[0].FireRecoil = 256;
		BFireMode[0].FireChaos = BFireMode[0].default.FireChaos;
	}
	else if (CurrentWeaponMode == 2)
	{
		BFireMode[0].FireRate = 0.2;
		BFireMode[0].FireRecoil = 128;
		BFireMode[0].FireChaos = 0.1;
	}
	else
	{
		BFireMode[0].FireRate = BFireMode[0].default.FireRate;
		BFireMode[0].FireRecoil = BFireMode[0].default.FireRecoil;
		BFireMode[0].FireChaos = BFireMode[0].default.FireChaos;
	}
}
simulated function ServerSwitchWeaponMode (byte NewMode)
{
	super.ServerSwitchWeaponMode (NewMode);
	SetBurstModeProps();
}

simulated function PlayIdle()
{
	super.PlayIdle();

	if (bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (CurrentWeaponMode != CurrentWeaponMode2)
	{
		SetBurstModeProps();
		CurrentWeaponMode2 = CurrentWeaponMode;
	}
	Super.PostNetReceive();
}


simulated function TickFireCounter (float DT)
{
    if (CurrentWeaponMode == 1)
    {
        if (!IsFiring() && FireCount > 0 && FireMode[0].NextFireTime - level.TimeSeconds < -0.5)
            FireCount = 0;
    }
    else
        super.TickFireCounter(DT);
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

/*
// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();

	bUseNetAim = default.bUseNetAim || bScopeView;
	if (bScopeView)
	{
		ViewRecoilFactor = 0.2;
		ChaosDeclineTime *= 0.9;
	}
	else
		SightOffset = default.SightOffset;
	if (Hand < 0)
		SightOffset.Y = default.SightOffset.Y * -1;
}*/

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

function ServerSwitchSilencer(bool bNewValue)
{
	BFireMode[0].bAISilent = true;
     	BFireMode[0].FireRecoil=64.000000;
}
simulated function SwitchSilencer(bool bNewValue)
{
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

/*simulated function SetDualMode (bool bDualMode)
{
	if (bDualMode)
	{
		if (Instigator.IsLocallyControlled() && SightingState == SS_Active)
			StopScopeView();
		SetBoneScale(8, 0.0, SupportHandBone);
		if (AIController(Instigator.Controller) == None)
			bUseSpecialAim = true;
		if (bAimDisabled)
			return;
//		AimAdjustTime		*= 1.0;
		AimSpread			*= 1.4;
		ViewAimFactor		*= 0.0;
		ViewRecoilFactor	*= 0.25;
		ChaosDeclineTime	*= 1.2;
		//ChaosTurnThreshold	*= 0.8;
		ChaosSpeedThreshold	*= 0.8;
		ChaosAimSpread		*= 1.2;
		RecoilPitchFactor	*= 1.2;
		RecoilYawFactor		*= 1.2;
		RecoilXFactor		*= 1.2;
		RecoilYFactor		*= 1.2;
//		RecoilMax			*= 1.0;
		RecoilDeclineTime	*= 1.2;
     	SelectAnim = 'Pullout';
		
	}
	else
	{
		SetBoneScale(8, 1.0, SupportHandBone);
		bUseSpecialAim = false;
		if (bAimDisabled)
			return;
//		AimAdjustTime		= default.AimAdjustTime;
		AimSpread 			= default.AimSpread;
		ViewAimFactor		= default.ViewAimFactor;
		ViewRecoilFactor	= default.ViewRecoilFactor;
		ChaosDeclineTime	= default.ChaosDeclineTime;
		//ChaosTurnThreshold	= default.ChaosTurnThreshold;
		ChaosSpeedThreshold	= default.ChaosSpeedThreshold;
		ChaosAimSpread		= default.ChaosAimSpread;
		ChaosAimSpread 		*= BCRepClass.default.AccuracyScale;
		RecoilPitchFactor	= default.RecoilPitchFactor;
		RecoilYawFactor		= default.RecoilYawFactor;
		RecoilXFactor		= default.RecoilXFactor;
		RecoilYFactor		= default.RecoilYFactor;
//		RecoilMax			= default.RecoilMax;
		RecoilDeclineTime	= default.RecoilDeclineTime;
	}
}*/


simulated function BringUp(optional Weapon PrevWeapon)
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



	Super.BringUp(PrevWeapon);
	/*if (Instigator != None && AIController(Instigator.Controller) != None)
	{
     			CurrentWeaponMode=2;
			ServerSwitchWeaponMode(2);
	}
	if (Instigator != None && AIController(Instigator.Controller) != None && FRand() > 0.5)
		WeaponSpecial();
	else if (bLightsOn && Instigator.IsLocallyControlled())
	{
		bLightsOn=false;
		WeaponSpecial();
	}*/


	//SetBurstModeProps();
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'FireOpen' || Anim == 'Pullout' || Anim == 'PulloutAlt' || Anim == 'Fire' || Anim == 'FireDualOpen' || Anim == 'FireDual' ||Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'IdleOpen';
			PutDownAnim = 'PutawayOpen';
			ReloadAnim = 'ReloadOpen';
			FlashlightAnim = 'FlashLightToggleOpen';
		}
		else
		{
			IdleAnim = 'Idle';
			PutDownAnim = 'Putaway';
			ReloadAnim = 'Reload';
			FlashlightAnim = 'FlashLightToggle';
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

	if (MagAmmo < 2)
		SetBoneScale (1, 0.0, 'Bullet');
}


// HARDCODED SIGHTING TIME
simulated function TickSighting (float DT)
{
	if (SightingState == SS_None || SightingState == SS_Active)
		return;

	if (SightingState == SS_Raising)
	{	// Raising gun to sight position
		if (SightingPhase < 1.0)
		{
			if ((bScopeHeld || bPendingSightUp) && CanUseSights())
				SightingPhase += DT/0.20;
			else
			{
				SightingState = SS_Lowering;

				Instigator.Controller.bRun = 0;
			}
		}
		else
		{	// Got all the way up. Now go to scope/sight view
			SightingPhase = 1.0;
			SightingState = SS_Active;
			ScopeUpAnimEnd();
		}
	}
	else if (SightingState == SS_Lowering)
	{	// Lowering gun from sight pos
		if (SightingPhase > 0.0)
		{
			if (bScopeHeld && CanUseSights())
				SightingState = SS_Raising;
			else
				SightingPhase -= DT/0.20;
		}
		else
		{	// Got all the way down. Tell the system our anim has ended...
			SightingPhase = 0.0;
			SightingState = SS_None;
			ScopeDownAnimEnd();
			DisplayFOv = default.DisplayFOV;
		}
	}
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

	//if (IsSlave())
		//return 0;

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
	return class'AP_M806Clip';
}

defaultproperties
{
     bFirstDraw=True
	 bLightsOn=False
     TorchOffset=(X=-75.000000)
     TorchOnSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
     TorchOffSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
     DrawSoundQuick=Sound'BWBP_SKC_Sounds.M1911.RS04-QuickDraw'
     FlashlightAnim="FlashLightToggle"
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBP_SKC_TexExp.M1911.BigIcon_RS04'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="60.0;6.0;1.0;110.0;0.2;0.0;0.0")
     BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.RS04-Draw')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
	 bShouldDualInLoadout=False
     CockSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806-Cock',Volume=1.100000)
     ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.RS04-SlideLock',Volume=0.400000)
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-StockOut',Volume=1.100000)
     ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.RS04-ClipIn',Volume=1.100000)
     ClipInFrame=0.650000
     WeaponModes(0)=(ModeName="Semi-Automatic")
     WeaponModes(1)=(ModeName="Small Burst",Value=2.000000)
     WeaponModes(2)=(bUnavailable=True)
     WeaponModes(3)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
     CurrentWeaponMode=0
     SightOffset=(X=-20.000000,Y=-1.9500000,Z=17.000000)
	 SightPivot=(Roll=-256)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
	 bNoCrosshairInScope=True
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=175,G=178,R=176,A=160),Color2=(G=0),StartSize1=52,StartSize2=40)
	 NDCrosshairInfo=(SpreadRatios=(Y1=0.800000,Y2=1.000000),MaxScale=6.000000)
		
	 FireModeClass(0)=Class'BWBP_SKCExp_Pro.RS04PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKCExp_Pro.RS04SecondaryFire'
     PutDownTime=0.600000
     BringUpTime=0.800000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     Description="RS04 .45 Compact||Manufacturer: Drake & Co Firearms|Primary: .45 Fire|Secondary: Flashlight||A brand new precision handgun designed by Drake & Co firearms, the Redstrom .45 is to be the military version of the current 10mm RS8. Dubbed the RS04, this unique and accurate pistol is still in its prototype stages. The .45 HV rounds used in the RS04 prototype allow for much improved stopping power at the expense of clip capacity and recoil. Current features include a tactical flashlight and a quick loading double shot firemode. Currently undergoing combat testing by private military contractors, the 8-round Redstrom is seen frequently in the battlefields of corporate warfare. The RS04 .45 Compact model is the latest variant."
     Priority=155
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=31
     PickupClass=Class'BWBP_SKCExp_Pro.RS04Pickup'
     PlayerViewOffset=(Y=9.000000,Z=-14.000000)
     AttachmentClass=Class'BWBP_SKCExp_Pro.RS04Attachment'
     IconMaterial=Texture'BWBP_SKC_TexExp.M1911.SmallIcon_RS04'
     IconCoords=(X2=127,Y2=31)
     ItemName="RS04 Compact Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
	 ParamsClasses(0)=Class'RS04PistolWeaponParamsArena'
	 ParamsClasses(1)=Class'RS04WeaponParamsClassic'
	 ParamsClasses(2)=Class'RS04WeaponParamsRealistic'
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_RS04'
     DrawScale=0.350000
     Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
     Skins(1)=Shader'BWBP_SKC_TexExp.M1911.RS04-MainShine'
}
