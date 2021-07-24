//=============================================================================
// MGLauncher.
//
// Multiple Grenade LauncherLauncher!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AutoGLauncher extends BallisticWeapon;

var() Material	MatDef;
var() Material	MatArmed;
var() Rotator	DrumRot;

var bool bRemoteGrenadeOut;

replication
{
	unreliable if (Role == ROLE_Authority)
		ClientUpdateGrenadeStatus;
}

function ServerSwitchWeaponMode (byte NewMode)
{
	if (CurrentWeaponMode > 0 && FireMode[0].IsFiring())
		return;
	super.ServerSwitchWeaponMode (NewMode);
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (anim == FireMode[0].FireAnim || (FireMode[1] != None && anim == FireMode[1].FireAnim))
	{
		bPreventReload=false;
		DrumRot.Roll -= 65535 / 6 ;
		SetBoneRotation('drum',DrumRot);	
	}
	
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		bPreventReload=False;
		DrumRot.Roll -= 65535 / 6 ;
		SetBoneRotation('drum',DrumRot);	
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
		if (Channel == 0)
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
			PlayShovelEnd();
			ReloadState = RS_EndShovel;
			return;
		}
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
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
		ReloadState = RS_None;
}

function UpdateGrenadeStatus(bool bDetonatable)
{
	bRemoteGrenadeOut = bDetonatable;
	
	if (bDetonatable)
		Skins[2]=MatArmed;
	else
		Skins[2]=MatDef;
		
	if (Role == ROLE_Authority && !Instigator.IsLocallyControlled())
		ClientUpdateGrenadeStatus(bDetonatable);
}

simulated function ClientUpdateGrenadeStatus(bool bDet)
{
	bRemoteGrenadeOut = bDet;
	if (bDet)
		Skins[2]=MatArmed;
	else
		Skins[2]=MatDef;
}

simulated function bool HasAmmo()
{
	if (bRemoteGrenadeOut)
		return true;
	return Super.HasAmmo();
}

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount <=0 && MagAmmo <= 0)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 1024, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return -0.2;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return 0.2;
}
// End AI Stuff =====

simulated function Notify_BrassOut()
{
//	BFireMode[0].EjectBrass();
}

defaultproperties
{
	MatDef=Texture'BWBP_SKC_Tex.MGL.MGL-ScreenBase'
	MatArmed=Texture'BWBP_SKC_Tex.MGL.MGL-Screen'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	TeamSkins(1)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_SKC_Tex.MGL.BigIcon_MGL'
	IdleTweenTime=0.000000
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_Projectile=True
	bWT_Super=True
	ManualLines(0)="Launches a grenade. Fire rate, damage and explosive radius are good. These grenades have an arming delay and if striking a surface when unarmed will ricochet. Direct impacts will always result in explosion."
	ManualLines(1)="Employs a manually controlled grenade. Pressing altfire again detonates the grenade."
	ManualLines(2)="Effective with height advantage and at medium range."
	SpecialInfo(0)=(Info="300.0;30.0;0.5;60.0;0.0;1.0;0.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Putaway')
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Pump',Volume=2.300000,Radius=32.000000)
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOff',Volume=1.700000,Radius=32.000000)
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOn',Volume=1.700000,Radius=32.000000)
	ClipInFrame=0.325000
	StartShovelAnim="ReloadStart"
	EndShovelAnim="ReloadEnd"
	WeaponModes(0)=(ModeName="Automatic",bUnavailable=True,ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Impact",ModeID="WM_FullAuto",bUnavailable=True)
	WeaponModes(2)=(ModeName="4-Round Burst",bUnavailable=True)
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	SightPivot=(Pitch=512)
	SightOffset=(X=-30.000000,Y=12.450000,Z=14.850000)
	GunLength=48.000000
	ParamsClasses(0)=Class'AutoGLWeaponParamsArena'
	ParamsClasses(1)=Class'AutoGLWeaponParamsClassic'
	FireModeClass(0)=Class'AutoGLPrimaryFire'
	FireModeClass(1)=Class'AutoGLPrimaryFire'
	SelectAnimRate=1.500000
	PutDownAnimRate=2.000000
	PutDownTime=0.660000
	BringUpTime=0.660000
	AIRating=0.900000
	CurrentRating=0.900000
	Description="Sometimes you need more grenades than just 6. That is when you call on the AG-81. It has 18 grenades."
	Priority=245
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=8
	PickupClass=Class'BWBP_SKCExp_Pro.AutoGLPickup'
	PlayerViewOffset=(X=5.000000,Y=-1.000000,Z=-7.000000)
	AttachmentClass=Class'BWBP_SKCExp_Pro.AutoGLAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.MGL.SmallIcon_MGL'
	IconCoords=(X2=127,Y2=35)
	ItemName="[B] AGR-81 Auto GL"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=25
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_MGL'
	DrawScale=0.130000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Texture'BWBP_SKC_Tex.MGL.MGL-Main'
	Skins(2)=Texture'BWBP_SKC_Tex.MGL.MGL-ScreenBase'
	Skins(3)=Shader'BWBP_SKC_Tex.MGL.MGL-HolosightGlowBasic'
}
