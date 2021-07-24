//=============================================================================
// R9000ERifle.
//
// Powerful, accurate semi automatic rifle with good power and reasonable
// reload time, but low clip capacity. Secondary fire makes it the weapon it is
// by providing a powerful scope. Holding secondary zooms in further initially,
// but the player can still use Prev and Next weapon to adjust.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class R9000ERifle extends BallisticWeapon;

//===========================================================================
// Roll switch
//===========================================================================

function ServerSwitchWeaponMode (byte NewMode)
{
	local int m;
	
	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (NewMode == 255)
		NewMode = CurrentWeaponMode + 1;
	if (NewMode == CurrentWeaponMode)
		return;
	
	while (NewMode != CurrentWeaponMode && (NewMode >= WeaponModes.length || WeaponModes[NewMode].bUnavailable) )
	{
		if (NewMode >= WeaponModes.length)
			NewMode = 0;
		else
			NewMode++;
	}

	if (!WeaponModes[NewMode].bUnavailable)
	{
		CommonSwitchWeaponMode(NewMode);
		ClientSwitchWeaponMode(CurrentWeaponMode);
		NetUpdateTime = Level.TimeSeconds - 1;
	}
	
	R9A1Attachment(ThirdPersonActor).CurrentTracerMode = CurrentWeaponMode;
		
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;

	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('ReloadGun');

	CommonStartReload(0);	//Server animation
	ClientStartReload(0);	//Client animation
}

exec simulated function SwitchWeaponMode (optional byte ModeNum)	
{
	if (ClientState == WS_PutDown || ClientState == WS_Hidden)
		return;
	bRedirectSwitchToFiremode=True;
	PendingMode = CurrentWeaponMode;
}

exec simulated function WeaponModeRelease()
{
	bRedirectSwitchToFiremode=False;
	ServerSwitchWeaponMode(PendingMode);
	CurrentWeaponMode = PendingMode;
}

simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	if (bRedirectSwitchToFiremode)
	{
		PendingMode--;
		if (PendingMode >= WeaponModes.Length)
			PendingMode = WeaponModes.Length-1;
		return None;
	}

	return Super.PrevWeapon(CurrentChoice, CurrentWeapon);
}

simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	if (bRedirectSwitchToFiremode)
	{
		PendingMode++;
		if (PendingMode >= WeaponModes.Length)
			PendingMode = 0;
		return None;
	}

	return Super.NextWeapon(CurrentChoice, CurrentWeapon);
}

simulated function bool PutDown()
{
	if (Instigator.IsLocallyControlled())
	{
		bRedirectSwitchToFiremode = False;
		PendingMode = CurrentWeaponMode;
	}
	
	return Super.PutDown();
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;
	local int i;
	local byte StartMode;

	Super(Weapon).NewDrawWeaponInfo (C, YPos);
	
	DrawCrosshairs(C);
	
	if (bSkipDrawWeaponInfo)
		return;

	ScaleFactor = C.ClipX / 1600;  // C.ClipY / 900 is correct...
	
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	Temp = string(Ammo[0].AmmoAmount);

	C.TextSize(Temp, XL, YL);

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		if (!bRedirectSwitchToFiremode)
		{
			// Draw the spare ammo amount
			if (Temp == "0")
				C.DrawColor = class'hud'.default.RedColor;
			C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
			C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
			C.DrawText(Temp, false);
			C.DrawColor = class'hud'.default.WhiteColor;
	
			C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
			C.TextSize(WeaponModes[CurrentWeaponMode].ModeName , XL, YL2);
			C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
			C.CurY = C.ClipY - (130 * ScaleFactor * class'HUD'.default.HudScale) - YL2 - YL;
			C.DrawText(WeaponModes[CurrentWeaponMode].ModeName, false);
		}
		
		else
		{
			StartMode = PendingMode - 2;
			if (StartMode >= WeaponModes.Length)
				StartMode = (WeaponModes.Length-1) - (255 - StartMode);
				
				//case -2: desire 3
				//case -1: desire 2
				//case 0: desire 1
				//case 1: desire 0
				//case 2: desire -1
				
				
			for (i=-2; i<3; i++)
			{
				if (i != 0)
					C.SetDrawColor(255,128,128,255 - (75 * Abs(i)));
				else C.SetDrawColor(255,255,255,255);
				C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
				C.TextSize(WeaponModes[StartMode].ModeName, XL, YL2);
				C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
				C.CurY = C.ClipY - (130 * ScaleFactor * class'HUD'.default.HudScale) - (YL2 * (-i +1)) - YL;
				C.DrawText(WeaponModes[StartMode].ModeName, false);
				
				StartMode++;
				if (StartMode >= WeaponModes.Length)
					StartMode = 0;
			}
		}
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
// Cocking
//===========================================================================

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None && Type != 1)
		TemporaryScopeDown(0.5);
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockAimed()
{
	bNeedCock = False;
	ReloadState = RS_Cocking;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
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
function byte BestMode()	{	return 0;	}

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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 2048, 3072); 
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.9;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.9;	}
// End AI Stuff =====

defaultproperties
{

     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_R78'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Bolt-action sniper rifle fire with explosive rounds. High damage, long range, slow fire rate and deals damage to targets near the struck target."
     ManualLines(1)="Engages the scope."
     ManualLines(2)="Does not use tracer rounds. Effective at long range and against clustered enemies."
     SpecialInfo(0)=(Info="240.0;25.0;0.5;60.0;10.0;0.0;0.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Putaway')
	 PutDownTime=0.5
     CockAnim="Cock"
	 CockSound=(Sound=Sound'BWBP_SKC_Sounds.R78NS.R78NS-Cock')
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78-ClipHit')
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78-ClipOut')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78-ClipIn')
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Semi-Automatic")
     WeaponModes(1)=(ModeName="Incendiary")
     WeaponModes(2)=(ModeName="Radiation")
     CurrentWeaponMode=0
	 BobDamping=2.4
     ScopeXScale=1.333000
     ScopeViewTex=Texture'BW_Core_WeaponTex.R78.RifleScopeView'
     ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=20.000000
     bNoCrosshairInScope=True
     SightPivot=(Roll=-1024)
     SightOffset=(Y=-1.600000,Z=22.000000)
     MinZoom=4.000000
     MaxZoom=16.000000
     ZoomStages=2
     GunLength=80.000000
     ParamsClasses(0)=Class'R9000EWeaponParamsArena'
     ParamsClasses(1)=Class'R9000EWeaponParamsClassic'
     FireModeClass(0)=Class'BWBP_APC_Pro.R9000EPrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     bSniping=True
     Description="Precision weapons often haven't had the need to get with the times, that was until the second Skrith war broke out. While the regular marksman weapons and sniper rifles did their job against high value targets, the ever-changing situation eventually cultivated a need to upgrade their long ranged capabilities.  Enravion, hearing the call, managed to upgrade their old R98 platform into a new breed, the R9000-E 'Chimera' Modular Sniper Rifle or 'MSR' for short. In addition to much needed upgrades like being chambered in .338 Lapua Magnum, cold bore floating barrel and picatinny rails, the Chimera earns it's nickname for its ability to accept the AMP system that's prevalent on several weapon systems already. Though it can be outfitted for different environments, the traditional long rifle is the way to go, with the amp to either ignite Krao or fry Cryons with radiation, the Chimera is a force to be reckoned with."
     DisplayFOV=55.000000
     Priority=33
     HudColor=(B=50,G=50,R=200)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=9
     GroupOffset=2
     PickupClass=Class'BWBP_APC_Pro.R9000EPickup'
     PlayerViewOffset=(X=12.000000,Y=7.000000,Z=-14.000000)
     AttachmentClass=Class'BWBP_APC_Pro.R9000EAttachment'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_R78'
     IconCoords=(X2=127,Y2=31)
     ItemName="R9000-E 'Chimera' Modular Sniper Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWBP_CC_Anim.FPm_R9000E'
     DrawScale=0.300000
}
