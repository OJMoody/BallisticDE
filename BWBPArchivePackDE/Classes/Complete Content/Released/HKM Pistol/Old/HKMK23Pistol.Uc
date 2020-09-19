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
class HKMK23Pistol extends BallisticHandGun;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() sound		SilencerOnTurnSound;	// Silencer screw on sound
var() sound		SilencerOffTurnSound;	//
var() float		SilencerSwitchTime;		//

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

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
	    PlayAnim(CockAnim, CockAnimRate, 0.2);
}

function ServerSwitchSilencer(bool bNewValue)
{
	SilencerSwitchTime = level.TimeSeconds + 1.5;
	bSilenced = bNewValue;
	BFireMode[0].bAISilent = bSilenced;
	//AdjustGunProperties();
}

//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	if (level.TimeSeconds < SilencerSwitchTime || ReloadState != RS_None)
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
	SilencerSwitchTime = level.TimeSeconds + 1.5;
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);
	//AdjustGunProperties();
}

/*simulated function AdjustGunProperties ()
{
//	AimAdjustTime		= default.AimAdjustTime;
	AimSpread 			= default.AimSpread;
	RecoilMax			= default.RecoilMax;
	ChaosDeclineTime	= default.ChaosDeclineTime;
	ChaosSpeedThreshold	= default.ChaosSpeedThreshold;
	ChaosAimSpread		= default.ChaosAimSpread;
	RecoilPitchFactor	= default.RecoilPitchFactor;
	RecoilYawFactor		= default.RecoilYawFactor;
	RecoilXFactor		= default.RecoilXFactor;
	RecoilYFactor		= default.RecoilYFactor;
//	RecoilMax			= default.RecoilMax;

	if (bSilenced)
	{
		BFireMode[0].RecoilPerShot = 1024;
		CrouchAimFactor		= 0.65;
		RecoilMax			*= 0.5;
		RecoilYawFactor		*= 0.7;
		ChaosDeclineTime	*= 1.2;
		RecoilXFactor		*= 0.6;
		RecoilYFactor		*= 0.6;
		ChaosSpeedThreshold	*= 0.8;
	}
	else
	{
		BFireMode[0].RecoilPerShot = BFireMode[0].default.RecoilPerShot;
		CrouchAimFactor		= default.CrouchAimFactor;
	}
}*/


simulated function SwitchSilencer(bool bNewValue)
{
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
	local float Result, Dist;
	local vector Dir;

	if (IsSlave())
		return 0;

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
	return class'AP_45ACP';
}

defaultproperties
{
     SilencerBone="joint10"
     SilencerOnAnim="SilencerOn"
     SilencerOffAnim="SilencerOff"
     SilencerOnSound=Sound'BallisticSounds2.XK2.XK2-SilenceOn'
     SilencerOffSound=Sound'BallisticSounds2.XK2.XK2-SilenceOff'
     SilencerOnTurnSound=Sound'BWAddPack-RS-Sounds.Pistol.RSP-SilencerTurn'
     SilencerOffTurnSound=Sound'BWAddPack-RS-Sounds.Pistol.RSP-SilencerTurn'
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWWeaponPackArchive-Tex.MK23.BigIcon_MK23'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Bullet=True
	 bShouldDualInLoadout=False
	 bNoCrosshairInScope=True
     SpecialInfo(0)=(Info="120.0;5.0;1.5;110.00;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway')
     MagAmmo=8
	 ManualLines(0)="Primary: .45 ACP Fire"
     ManualLines(1)="Secondary: Silencer"
     ManualLines(2)="The USP-S MK23 is considered a match grade pistol, and is capable of making a 2-inch group at 50 yards, roughly 4 MOA. Production of the original began in 1991, and it was the basis for the HK USP, which began production in 1993. The MK23 is part of a larger weapon system that includes an attachable laser aiming module, a suppressor, and some other features such as a special high-pressure match cartridge (.45 +P ammunition). The MK23 has exceptional durability in harsh environments, being waterproof and corrosion-resistant. It uses a polygonal barrel design, which is reported to improve accuracy and durability. The firearm was tested and found to be capable of firing tens of thousands of rounds without a barrel change. It remains reliable in harsh conditions, making it suitable for use by special forces.""
     CockSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.MK23.mk23_cock',Volume=2.300000)
     ClipHitSound=(Sound=Sound'BWBP4-Sounds.Glock.Glk-ClipHit',Volume=0.700000)
     ClipOutSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.MK23.MKClipOut',Volume=1.300000)
     ClipInSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.MK23.MKClipIn',Volume=1.300000)
     ClipInFrame=0.650000
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     SightPivot=(Pitch=-70)
     SightOffset=(X=-120.000000,Y=35.669998,Z=28.400000)
     SightDisplayFOV=40.000000
     SightingTime=0.250000
	 AimSpread=16
	 ChaosAimSpread=384
     JumpChaos=0.025000
     AimAdjustTime=0.350000
     ViewAimFactor=0.400000
     ViewRecoilFactor=0.200000
     ChaosDeclineTime=0.4500000
     ChaosSpeedThreshold=1400.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=0.015000
     RecoilDeclineDelay=0.250000
     FireModeClass(0)=Class'BWBPArchivePackDE.HKMK23PrimaryFire'
     FireModeClass(1)=Class'BWBPArchivePackDE.HKMk23SilencerSwitch'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     Description="USP-S MK23 .45 Handgun||Manufacturer: Classic Weapons Industries|Primary: .45 ACP Fire|Secondary: Silencer||The MK23 is considered a match grade pistol, and is capable of making a 2-inch group at 50 yards, roughly 4 MOA. Production of the original began in 1991, and it was the basis for the HK USP, which began production in 1993. The MK23 is part of a larger weapon system that includes an attachable laser aiming module, a suppressor, and some other features such as a special high-pressure match cartridge (.45 +P ammunition). The MK23 has exceptional durability in harsh environments, being waterproof and corrosion-resistant. It uses a polygonal barrel design, which is reported to improve accuracy and durability. The firearm was tested and found to be capable of firing tens of thousands of rounds without a barrel change. It remains reliable in harsh conditions, making it suitable for use by special forces."
     Priority=17
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
	 InventorySize=6
     GroupOffset=3
     PickupClass=Class'BWBPArchivePackDE.HKMK23Pickup'
     PlayerViewOffset=(X=40.000000,Y=-5.000000,Z=-25.000000)
     AttachmentClass=Class'BWBPArchivePackDE.HKMK23Attachment'
     IconMaterial=Texture'BWWeaponPackArchive-Tex.MK23.SmallIcon_MK23'
     IconCoords=(X2=127,Y2=31)
     ItemName="USP-S 23 Handgun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BWWeaponPackAnims.HKMK23Pistol'
     DrawScale=1.100000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
}
