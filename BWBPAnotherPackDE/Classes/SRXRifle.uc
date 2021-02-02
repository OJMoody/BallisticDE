class SRXRifle extends BallisticWeapon;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() float		SilencerSwitchTime;		//

var() array<Material> CamoMaterials; //We're using this for the amp

var   bool		bAmped;				// Amp installed, gun has new effects
var() name		AmplifierBone;			// Bone to use for hiding amp
var() name		AmplifierOnAnim;			//
var() name		AmplifierOffAnim;		//
var() sound		AmplifierOnSound;		// Silencer stuck on sound
var() sound		AmplifierOffSound;		//
var() sound		AmplifierPowerOnSound;		// Silencer stuck on sound
var() sound		AmplifierPowerOffSound;		//
var() float		AmplifierSwitchTime;		//

var	  Rotator	RearSightBoneRot;

//Scripted Ammo Screen Texture
var() ScriptedTexture WeaponScreen; //Scripted texture to write on
var() Material	WeaponScreenShader; //Scripted Texture with self illum applied
var() Material	ScreenBase;
var() Material	ScreenAmmoBlue; //Norm
var() Material	ScreenAmmoRed; //Low Ammo
var protected const color MyFontColor; //Why do I even need this?

var	float	AmmoBarPos;

replication
{
   	reliable if( Role<ROLE_Authority )
		ServerSwitchSilencer, ServerSwitchAmplifier;	
}

simulated function PostNetBeginPlay()
{
	//SetBoneScale(3, 0.0, 'Sight');
	SetBoneRotation('Sight',RearSightBoneRot);
	super.PostNetBeginPlay();
}

//==============================================
// Screen Code
//==============================================

simulated function ClientScreenStart()
{
	ScreenStart();
}
// Called on clients from camera when it gets to postnetbegin
simulated function ScreenStart()
{
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Client = self;
	//if (CamoIndex >= 3)
		Skins[11] = WeaponScreenShader; //Set up scripted texture.
	UpdateScreen();//Give it some numbers n shit
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
}

simulated event RenderTexture( ScriptedTexture Tex )
{
	// 0 is full, 256 is empty
	AmmoBarPos = 256-(((MagAmmo)/20.0f)*256);

	//Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenBase, MyFontColor); //Basic screen
	if (MagAmmo > 5)
	{
		Tex.DrawTile(AmmoBarPos,0,256,256,0,0,512,256,ScreenAmmoBlue, MyFontColor); //Ammo
	}
	else
	{
		Tex.DrawTile(AmmoBarPos,0,256,256,0,0,512,256,ScreenAmmoRed, MyFontColor); //Ammo
	}
	
}
	
simulated function UpdateScreen()
{
	if (Instigator.IsLocallyControlled())
	{
			WeaponScreen.Revision++;
	}
}
	
// Consume ammo from one of the possible sources depending on various factors
simulated function bool ConsumeMagAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)
{

	if (bNoMag || (BFireMode[Mode] != None && BFireMode[Mode].bUseWeaponMag == false))
		ConsumeAmmo(Mode, Load, bAmountNeededIsMax);
	else
	{
		if (MagAmmo < Load)
			MagAmmo = 0;
		else
			MagAmmo -= Load;
	}

	UpdateScreen();
	return true;
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	local int AmmoNeeded;

	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PostClipIn;
	PlayOwnedSound(ClipInSound.Sound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
	if (level.NetMode != NM_Client)
	{
		AmmoNeeded = default.MagAmmo-MagAmmo;
		if (AmmoNeeded > Ammo[0].AmmoAmount)
			MagAmmo+=Ammo[0].AmmoAmount;
		else
			MagAmmo = default.MagAmmo;
		Ammo[0].UseAmmo (AmmoNeeded, True);
	}
	UpdateScreen();
}

//==============================================
// Amp Code
//==============================================

exec simulated function ToggleAmplifier(optional byte i)
{
	if (level.TimeSeconds < AmplifierSwitchTime || level.TimeSeconds < SilencerSwitchTime || ReloadState != RS_None || SightingState != SS_None)
		return;
		
	if (bSilenced)
	{
		WeaponSpecial();
		return;
	}
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
			WeaponModes[3].bUnavailable=false;
			WeaponModes[4].bUnavailable=false;
			CurrentWeaponMode=3;
			ServerSwitchWeaponMode(3);
	}
	else
	{
			WeaponModes[0].bUnavailable=false;
			WeaponModes[3].bUnavailable=true;
			WeaponModes[4].bUnavailable=true;
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
		SRXAttachment(ThirdPersonActor).SetAmped(bNewValue);
		
	if (CurrentWeaponMode == 3)	//red
	{
		SRXAttachment(ThirdPersonActor).SetAmpColour(true, false);
		Skins[14]=CamoMaterials[0];
		Skins[15]=CamoMaterials[2];
	}
	else if (CurrentWeaponMode == 4)	//green
	{
		SRXAttachment(ThirdPersonActor).SetAmpColour(false, true);
		Skins[14]=CamoMaterials[1];
		Skins[15]=CamoMaterials[3];
	}
}

function ServerSwitchWeaponMode (byte newMode)
{
	super.ServerSwitchWeaponMode (newMode);
	if (!Instigator.IsLocallyControlled())
		SRXPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);		
		
	ClientSwitchWeaponMode (CurrentWeaponMode);
}

simulated function ClientSwitchWeaponMode (byte newMode)
{
	SRXPrimaryFire(FireMode[0]).SwitchWeaponMode(newMode);
	if (newMode == 3)	//red
	{
		SRXAttachment(ThirdPersonActor).SetAmpColour(true, false);
		Skins[14]=CamoMaterials[0];
		Skins[15]=CamoMaterials[2];
	}
	else if (newMode == 4)	//green
	{
		SRXAttachment(ThirdPersonActor).SetAmpColour(false, true);
		Skins[14]=CamoMaterials[1];
		Skins[15]=CamoMaterials[3];
	}
}

//==============================================
// Suppressor Code
//==============================================

exec simulated function WeaponSpecial(optional byte i)
{
	if (level.TimeSeconds < SilencerSwitchTime || level.TimeSeconds < AmplifierSwitchTime || ReloadState != RS_None || SightingState != SS_None)
		return;
		
	if (bAmped)
	{
		ToggleAmplifier();
		return;
	}
		
	TemporaryScopeDown(0.5);
	SilencerSwitchTime = level.TimeSeconds + 2.0;
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);
}

function ServerSwitchSilencer(bool bNewValue)
{
	SilencerSwitchTime = level.TimeSeconds + 2.0;
	bSilenced = bNewValue;
	BFireMode[0].bAISilent = bSilenced;
	
	bServerReloading=True;
	ReloadState = RS_GearSwitch;
	
	if (bSilenced)
	{
		BallisticInstantFire(BFireMode[0]).TraceRange.Max = 10000;
		BallisticInstantFire(BFireMode[0]).TraceRange.Min = 10000;
	}
	else
		BallisticInstantFire(BFireMode[0]).TraceRange = BallisticInstantFire(BFireMode[0]).default.TraceRange;
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
		
	if (Role == ROLE_Authority)
		SRXAttachment(ThirdPersonActor).SetSilenced(bNewValue);	
}
simulated function Notify_SilencerOn()	{	PlaySound(SilencerOnSound,,0.5);	}
simulated function Notify_SilencerOff()	{	PlaySound(SilencerOffSound,,0.5);	}

simulated function Notify_SilencerShow(){	SetBoneScale (0, 1.0, SilencerBone);	}
simulated function Notify_SilencerHide(){	SetBoneScale (0, 0.0, SilencerBone);	}

simulated function Notify_AmplifierOn()	{	PlaySound(AmplifierOnSound,,0.5);	}
simulated function Notify_AmplifierOff()	{	PlaySound(AmplifierOffSound,,0.5);	}

simulated function Notify_AmplifierShow(){	SetBoneScale (2, 1.0, AmplifierBone);	}
simulated function Notify_AmplifierHide(){	SetBoneScale (2, 0.0, AmplifierBone);	}

simulated function Notify_ClipOutOfSight()	{	SetBoneScale (1, 1.0, 'Bullet');	}

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

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_SRXClip';
}

//Kaboodles' neat idle anim fix.
simulated function PlayIdle()
{
	if (BFireMode[0].IsFiring())
		return;
	if (bPendingSightUp)
		ScopeBackUp();
	else if (SightingState != SS_None)
	{
		if (SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
	}
	else if (bScopeView)
	{
		if(SafePlayAnim(ZoomOutAnim, 1.0))
			FreezeAnimAt(0.0);
	}
	else
	    SafeLoopAnim(IdleAnim, IdleAnimRate, IdleTweenTime, ,"IDLE");
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(PrevWeapon);

	if (Instigator != None && AIController(Instigator.Controller) == None) //Player Screen ON
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
	}
	
	SetBoneScale (2, 0.0, AmplifierBone);

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bAmped)
		SetBoneScale (2, 1.0, AmplifierBone);
	else
		SetBoneScale (2, 0.0, AmplifierBone);
	
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
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	Result += (Dist-1000) / 2000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

defaultproperties
{
	RearSightBoneRot=(Yaw=16384)
	
	CamoMaterials[0]=Shader'BWBP_SKC_Tex.Amp.Amp-FinalRed'
	CamoMaterials[1]=Shader'BWBP_SKC_Tex.Amp.Amp-FinalGreen'
	CamoMaterials[2]=Shader'BWBP_SKC_Tex.AMP.Amp-GlowRedShader'
	CamoMaterials[3]=Shader'BWBP_SKC_Tex.AMP.Amp-GlowGreenShader'
	
	MyFontColor=(R=255,G=255,B=255,A=255)
    WeaponScreen=ScriptedTexture'BWBP_OP_Tex.SRX.SRX-ScriptLCD'
    WeaponScreenShader=Shader'BWBP_OP_Tex.SRX.SRX-ScriptLCD-SD'
	ScreenBase=Texture'BWBP_OP_Tex.SRX.SRX-Screen'
	ScreenAmmoBlue=Texture'BWBP_OP_Tex.SRX.SRX-Screen'
	ScreenAmmoRed=FinalBlend'BWBP_OP_Tex.SRX.SRX-ScreenRed-FB'
	
	AmplifierBone="Amp"
    AmplifierOnAnim="AddAMP"
    AmplifierOffAnim="RemoveAMP"
    AmplifierOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
    AmplifierOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
	
	SilencerBone="Silencer"
	SilencerOnAnim="AddSilencer"
	SilencerOffAnim="RemoveSilencer"
	SilencerOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
	
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=3)
	BigIconMaterial=Texture'BWBP_OP_Tex.SRX.BigIcon_SRXRifle'
	BigIconCoords=(Y2=240)
	BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
	bWT_Bullet=True
	ManualLines(0)="7.62mm Fire"
	ManualLines(1)="Attach/Detach AMP. Corrosive does extra damage to Shield while Explosive damage does radius damage."
	ManualLines(2)="Attach/Detach Silencer."
	SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;1.0;0.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Putaway')
	CockAnimRate=1.200000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Cock',Volume=0.650000)
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-ClipIn')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-ClipHit')
	ClipInFrame=0.650000
	WeaponModes(1)=(bUnavailable=True)
    WeaponModes(2)=(bUnavailable=True)
    WeaponModes(3)=(ModeName="Amplified: Explosive",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
    WeaponModes(4)=(ModeName="Amplified: Corrosive",ModeID="WM_Burst",Value=3.000000,bUnavailable=True)
	CurrentWeaponMode=0
	FullZoomFOV=70.000000
	bNoCrosshairInScope=True
	SightPivot=(Pitch=-128,Yaw=16)
	SightOffset=(X=-10.000000,Y=-0.670000,Z=27.200000)
	SightDisplayFOV=25.000000
	GunLength=72.000000
	ParamsClass=Class'SRXWeaponParams'
	FireModeClass(0)=Class'BWBPAnotherPackDE.SRXPrimaryFire'
	FireModeClass(1)=Class'BWBPAnotherPackDE.SRXSecondaryFire'
	SelectAnimRate=1.350000
	BringUpTime=0.350000
	PutDownTime=0.350000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.80000
	CurrentRating=0.80000
	Description="All weapons evolve over time, adapting to new environments and forms of combat, the SRK-650 Battle Rifle is no exception. NDTR's improvement over the original SRS-900 model, the SRK was created to stand up to the harsh winters of Kalendra with more rugged ergonomics, a holo-sight for closer ranged engagements and a digital ammo counter. But NDTR went one step and beyond by allowing the SRK to not just accept silencers, but also the new elemental AMP tech to counter Cryon armor and Krao hordes with acidic and explosive tech respectively. Slated to join it's longer ranged brother in due time, the SRK will be a blessing for the UTC troops, and a curse for their enemies."
	Priority=40
	HudColor=(B=50,G=50,R=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=4
	PickupClass=Class'BWBPAnotherPackDE.SRXPickup'
	PlayerViewOffset=(X=-2.000000,Y=10.000000,Z=-20.000000)
	AttachmentClass=Class'BWBPAnotherPackDE.SRXAttachment'
	IconMaterial=Texture'BWBP_OP_Tex.SRX.SmallIcon_SRXRifle'
	IconCoords=(X2=127,Y2=31)
	ItemName="SRK-650 Battle Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_SRX'
	DrawScale=0.500000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
    Skins(1)=Texture'BWBP_OP_Tex.SRX.SRX-RifleDark'
    Skins(2)=Texture'BWBP_OP_Tex.SRX.SRX-StockBlack'
    Skins(3)=Texture'BWBP_OP_Tex.SRX.SRX-Irons'
    Skins(4)=Texture'BWBP_OP_Tex.SRX.SRX-Holo'
    Skins(5)=Texture'BWBP_OP_Tex.SRX.SRX-Cable'
    Skins(6)=Texture'BWBP_OP_Tex.SRX.SRX-Plating'
    Skins(7)=Texture'BWBP_OP_Tex.SRX.SRX-Barrel'
    Skins(8)=Texture'BWBP_OP_Tex.SRX.SRX-Misc'
    Skins(9)=Texture'BWBP_OP_Tex.SRX.SRX-Muzzle'
    Skins(10)=Texture'UCGeneric.SolidColours.Black'
    Skins(11)=Texture'BWBP_OP_Tex.SRX.SRX-ScreenMask'
    Skins(12)=Shader'BWBP_OP_Tex.SRX.SRX-Reticle-S'
    Skins(13)=Texture'BWBP_OP_Tex.SRX.SRX-Supp'
    Skins(14)=Shader'BWBP_SKC_Tex.AMP.Amp-FinalRed'
	Skins(15)=Shader'BWBP_SKC_Tex.AMP.Amp-GlowRedShader'
}
