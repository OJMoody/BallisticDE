//=============================================================================
// HKMK23Pistol.
//
// Semi Automatic pistol with good damage, 12 round clip, good accracy when
// used carefully, but mainly, its the default weapon.
// Secondary fixes affixes a silencer for stealth operations.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HKMK23Pistol extends BallisticHandgun;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() sound		SilencerOnTurnSound;	// Silencer screw on sound
var() sound		SilencerOffTurnSound;	//
var() float		SilencerSwitchTime;		//
var   Rotator	TipRotation;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
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

simulated function PlayIdle()
{
	super.PlayIdle();

	if (bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}


simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
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
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
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
	return class'AP_45ACP';
}

defaultproperties
{
     TipRotation=(Yaw=-32768)
	 SilencerBone="Joint10"
     SilencerOnAnim="SilencerOn"
     SilencerOffAnim="SilencerOff"
     SilencerOnSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOn'
     SilencerOffSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOff'
     SilencerOnTurnSound=Sound'BW_Core_WeaponSound.Pistol.RSP-SilencerTurn'
     SilencerOffTurnSound=Sound'BW_Core_WeaponSound.Pistol.RSP-SilencerTurn'
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBP_JCF_Tex.MK23.BigIcon_MK23'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
	 bNoCrosshairInScope=True
     SpecialInfo(0)=(Info="120.0;5.0;1.5;110.00;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
	 BringUpTime=0.7
	 SelectAnimRate=1.2
	 ManualLines(0)="Primary: .45 ACP Fire"
     ManualLines(1)="Secondary: Silencer"
     ManualLines(2)="The USP-S MK23 is considered a match grade pistol, and is capable of making a 2-inch group at 50 yards, roughly 4 MOA. Production of the original began in 1991, and it was the basis for the HK USP, which began production in 1993. The MK23 is part of a larger weapon system that includes an attachable laser aiming module, a suppressor, and some other features such as a special high-pressure match cartridge (.45 +P ammunition). The MK23 has exceptional durability in harsh environments, being waterproof and corrosion-resistant. It uses a polygonal barrel design, which is reported to improve accuracy and durability. The firearm was tested and found to be capable of firing tens of thousands of rounds without a barrel change. It remains reliable in harsh conditions, making it suitable for use by special forces."
     CockSound=(Sound=Sound'BWBP_JCF_Sounds.MK23.mk23_cock',Volume=2.300000)
     ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-ClipHit',Volume=0.700000)
     ClipOutSound=(Sound=Sound'BWBP_JCF_Sounds.MK23.MKClipOut',Volume=1.300000)
     ClipInSound=(Sound=Sound'BWBP_JCF_Sounds.MK23.MKClipIn',Volume=1.300000)
     ClipInFrame=0.650000
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     SightPivot=(Pitch=-70)
     SightOffset=(X=-25.000000,Y=9.750000,Z=7.700000)
     SightDisplayFOV=40.000000
     SightingTime=0.250000
	 BobDamping=2.250000
     FireModeClass(0)=Class'BWBP_JCF_Pro.HKMK23PrimaryFire'
     FireModeClass(1)=Class'BWBP_JCF_Pro.HKMk23SecondaryFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     Description="USP-S MK23 .45 Handgun||Manufacturer: Classic Weapons Industries|Primary: .45 ACP Fire|Secondary: Silencer||The MK23 is considered a match grade pistol, and is capable of making a 2-inch group at 50 yards, roughly 4 MOA. Production of the original began in 1991, and it was the basis for the HK USP, which began production in 1993. The MK23 is part of a larger weapon system that includes an attachable laser aiming module, a suppressor, and some other features such as a special high-pressure match cartridge (.45 +P ammunition). The MK23 has exceptional durability in harsh environments, being waterproof and corrosion-resistant. It uses a polygonal barrel design, which is reported to improve accuracy and durability. The firearm was tested and found to be capable of firing tens of thousands of rounds without a barrel change. It remains reliable in harsh conditions, making it suitable for use by special forces."
     Priority=17
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=30
     PickupClass=Class'BWBP_JCF_Pro.HKMK23Pickup'
     PlayerViewOffset=(X=15.000000,Y=-3.000000,Z=-8.000000)
     AttachmentClass=Class'BWBP_JCF_Pro.HKMK23Attachment'
     IconMaterial=Texture'BWBP_JCF_Tex.MK23.SmallIcon_MK23'
     IconCoords=(X2=127,Y2=31)
     ItemName=".45 MK23 Handgun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
	 ParamsClasses(0)=Class'BallisticProV55.MD24WeaponParams'
	 ParamsClasses(1)=Class'BWBP_JCF_Pro.HKMK23PistolWeaponParamsClassic'
     Mesh=SkeletalMesh'BWBP_JCF_Anims.FPm_HKMK'
     DrawScale=0.300000
}
