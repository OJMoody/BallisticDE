//=============================================================================
// FMP machine pistol
//
// muh MP40
//
// by Sarge.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FMPMachinePistol extends BallisticWeapon;

var   bool		bAmped;				// AMPED UP!!! YEAH!!! WOOOO!!!! WHITE CLAWW!!!!
var() name		AmplifierBone;			// Bone to use for hiding cool shit
var() name		AmplifierBone2;			// Xav likes to make my life difficult
var() name		AmplifierOnAnim;			//
var() name		AmplifierOffAnim;		//
var() sound		AmplifierOnSound;		// Silencer stuck on sound
var() sound		AmplifierOffSound;		//
var() sound		AmplifierPowerOnSound;		// Silencer stuck on sound
var() sound		AmplifierPowerOffSound;		//
var() float		AmplifierSwitchTime;		//

var() array<Material> CamoMaterials;

replication
{
   	reliable if( Role<ROLE_Authority )
		ServerSwitchAmplifier;
		
}

//==============================================
// Amp Code
//==============================================

exec simulated function WeaponSpecial(optional byte i)
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
			CurrentWeaponMode=2;
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
		FMPAttachment(ThirdPersonActor).SetAmped(bNewValue);
		
	if (CurrentWeaponMode == 1)	//explosive
	{
		FMPAttachment(ThirdPersonActor).SetAmpColour(true, false);
		Skins[3]=CamoMaterials[1];
		Skins[4]=CamoMaterials[2];
	}
	else if (CurrentWeaponMode == 2)	//corrosive
	{
		FMPAttachment(ThirdPersonActor).SetAmpColour(false, true);
		Skins[3]=CamoMaterials[0];
		Skins[4]=CamoMaterials[3];
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

simulated function Notify_ClipOutOfSight()	{	SetBoneScale (1, 1.0, 'Bullet');	}

function ServerSwitchWeaponMode (byte newMode)
{
	super.ServerSwitchWeaponMode (newMode);
	if (!Instigator.IsLocallyControlled())
		FMPPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		
	ClientSwitchWeaponMode (CurrentWeaponMode);
}
simulated function ClientSwitchWeaponMode (byte newMode)
{
	FMPPrimaryFire(FireMode[0]).SwitchWeaponMode(newMode);
	if (newMode == 1)
	{
		FMPAttachment(ThirdPersonActor).SetAmpColour(true, false);
		Skins[3]=CamoMaterials[1];
		Skins[4]=CamoMaterials[2];
	}
	else if (newMode == 2)
	{
		FMPAttachment(ThirdPersonActor).SetAmpColour(false, true);
		Skins[3]=CamoMaterials[0];
		Skins[4]=CamoMaterials[3];
	}
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(PrevWeapon);

	if (AIController(Instigator.Controller) != None)
		bAmped = (FRand() > 0.5);

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

	/*if (Instigator != None && AIController(Instigator.Controller) != None)
	{
		AimSpread *= 0.4;
		ChaosAimSpread *= 0.4;
		RecoilMax *= 0.4;
	}*/

}
//======================================================

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'Pullout' || Anim == 'PulloutFancy' || Anim == 'Fire' || Anim == 'FireClosed' ||Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'IdleClosed';
			PutDownAnim = 'PutawayClosed';
			SelectAnim = 'PulloutClosed';
			ReloadAnim = 'ReloadEmpty';
		}
		else
		{
			IdleAnim = 'Idle';
			PutDownAnim = 'Putaway';
			SelectAnim = 'Pullout';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
}

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
// AI Interface =====
function byte BestMode()	
{		
	if (CurrentWeaponMode != 2)
	{
		CurrentWeaponMode = 2;
	}

	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     CamoMaterials[0]=Shader'BWBP_SKC_Tex.Amp.Amp-FinalGreen'
     CamoMaterials[1]=Shader'BWBP_SKC_Tex.Amp.Amp-FinalRed'
	 CamoMaterials[2]=Shader'BWBP_SKC_Tex.AMP.Amp-GlowRedShader'
	 CamoMaterials[3]=Shader'BWBP_SKC_Tex.AMP.Amp-GlowGreenShader'
     AmplifierBone="Amplifier1"
     AmplifierBone2="Amplifier2"
     AmplifierOnAnim="AmplifierOn"
     AmplifierOffAnim="AmplifierOff"
	 CockSelectAnim="PulloutFancy"
     CockSelectAnimRate=1.000000
     CockingBringUpTime=1.500000
     AmplifierOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
     AmplifierOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
     AmplifierPowerOnSound=Sound'BW_Core_WeaponSound.VPR.VPR-ClipIn'
     AmplifierPowerOffSound=Sound'BW_Core_WeaponSound.VPR.VPR-ClipOut'
	 TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBP_SKC_TexExp.MP40.BigIcon_MP40'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="240.0;25.0;0.9;80.0;0.7;0.7;0.4")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
     CockAnimPostReload="ReloadEndCock"
     CockSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Cock')
     ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50ClipHit')
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50ClipOut')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50ClipIn')
     ClipInFrame=0.650000
	 CurrentWeaponMode=0
     WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Amplified: Incendiary",ModeID="WM_FullAuto",bUnavailable=True)
     WeaponModes(2)=(ModeName="Amplified: Corrosive",ModeID="WM_FullAuto",bUnavailable=True)
     SightPivot=(Yaw=10)
     SightOffset=(X=5.000000,Y=-7.670000,Z=18.900000)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
	 AIRating=0.8
	 CurrentRating=0.8
     FireModeClass(0)=Class'BWBPAnotherPackDE.FMPPrimaryFire'
     FireModeClass(1)=Class'BWBPAnotherPackDE.FMPSecondaryFire'
     PutDownTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     Description="FMP-2012 Machine Pistol||Manufacturer: Black & Wood|Primary: Accurate Rifle Fire|Secondary: Attach Smoke Grenade||The MJ51 is a 3-round burst carbine based off the popular M50 assault rifle. It fires the 5.56mm UTC round and is more controllable than its larger cousin, though at the expense of long range accuracy and power. While the S-AR 12 is the UTC's weapon of choice for close range engagements, the MJ51 is often seen in the hands of MP and urban security details. When paired with its native CM3 Rifle Grenade attachment, the MJ51 makes an efficient riot control weapon."
     Priority=41
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
	 bNoCrosshairInScope=True
     PickupClass=Class'BWBPAnotherPackDE.FMPPickup'
     PlayerViewOffset=(X=-5.000000,Y=12.000000,Z=-15.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPAnotherPackDE.FMPAttachment'
     IconMaterial=Texture'BWBP_SKC_TexExp.MP40.SmallIcon_MP40'
     IconCoords=(X2=127,Y2=31)
     ItemName="FMPA-2012 Machine Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
	 ParamsClass=Class'FMPAWeaponParams'
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_MP40'
     DrawScale=0.30000
	 Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
     Skins(1)=Shader'BWBP_SKC_TexExp.MP40.MP40-MainShine'
     Skins(2)=Shader'BWBP_SKC_TexExp.MP40.MP40-MagShine'
     Skins(3)=Shader'BWBP_SKC_Tex.Amp.Amp-FinalRed'
	 Skins(4)=Shader'BWBP_SKC_Tex.AMP.Amp-GlowRedShader'
}
