class XM20AutoLas extends BallisticMachinegun;

var() name			BulletBone;

var bool			bBroken; 			//Ooops, your broke the shield emitter.

var() Sound 		ChargingSound;      // charging sound
var() Sound			DamageSound;		// Sound to play when it first breaks
var() Sound			BrokenSound;		// Sound to play when its very damaged

var Actor			Arc;				// The top arcs
var Actor 			GlowFX;
var() float 		AmmoRegenTime;
var() float 		ChargeupTime;
var() float 		RampTime;

var actor 			VentSteamL1;
var actor 			VentSteamL2;
var actor 			VentSteamR1;
var actor 			VentSteamR2;

var   float DesiredSpeed, BarrelSpeed;
var   int	BarrelTurn;
var() Sound BarrelSpinSound;
var() Sound BarrelStopSound;
var() Sound BarrelStartSound;
var float	RotationSpeeds[3];

simulated function DebugMessage(coerce string message)
{
	//if (PlayerController(Instigator.Controller) != None)
	//	PlayerController(Instigator.Controller).ClientMessage("DEBUG:"@message);
}

simulated function Notify_VentSteam()
{
	if (VentSteamL1 != None)
		VentSteamL1.Destroy();

	if (VentSteamL2 != None)
		VentSteamL2.Destroy();
		
	if (VentSteamR1 != None)
		VentSteamR1.Destroy();

	if (VentSteamR2 != None)
		VentSteamR2.Destroy();

	class'BUtil'.static.InitMuzzleFlash (VentSteamL1, class'CoachSteam', DrawScale, self, 'Vent1L');
	class'BUtil'.static.InitMuzzleFlash (VentSteamL2, class'CoachSteam', DrawScale, self, 'Vent2L');
	class'BUtil'.static.InitMuzzleFlash (VentSteamR1, class'CoachSteam', DrawScale, self, 'Vent1R');
	class'BUtil'.static.InitMuzzleFlash (VentSteamR2, class'CoachSteam', DrawScale, self, 'Vent2R');
}

simulated function Destroyed()
{
	if (Arc != None)	
		Arc.Destroy();
	if (VentSteamL1 != None)
		VentSteamL1.Destroy();
	if (VentSteamL2 != None)
		VentSteamL2.Destroy();
	if (VentSteamR1 != None)
		VentSteamR1.Destroy();
	if (VentSteamR2 != None)
		VentSteamR2.Destroy();
		
	super.Destroyed();
}

simulated event PostBeginPlay()
{
	super.PostbeginPlay();
	PlayAnim(IdleAnim, IdleAnimRate, 0, 1);
	FreezeAnimAt(0.0, 1);
	XM20PrimaryFire(FireMode[0]).Minigun = self;
}

//=====================================================
//			HEAT MANAGEMENT CODE
//=====================================================

function int ManageHeatInteraction(Pawn P, int HeatPerShot)
{
	local XM20HeatManager HM;
	local int HeatBonus;
	
	foreach P.BasedActors(class'XM20HeatManager', HM)
		break;
	if (HM == None)
	{
		HM = Spawn(class'XM20HeatManager',P,,P.Location + vect(0,0,-30));
		HM.SetBase(P);
	}
	
	if (HM != None)
	{
		HeatBonus = HM.Heat;
		if (Vehicle(P) != None)
			HM.AddHeat(HeatPerShot/4);
		else HM.AddHeat(HeatPerShot);
	}
	
	return heatBonus;
}

//=====================================================
//			MACHINEGUN CODE
//=====================================================

simulated function PlayReload()
{
	PlayAnim('ReloadHold', ReloadAnimRate, , 0.25);
}

// Play second half of reload anim. It will be different depending on how many bullets are being loaded
simulated function PlayReloadFinish()
{
	SetBoxVisibility();
	SetBeltVisibility(Ammo[0].AmmoAmount+MagAmmo+1);
	if (Ammo[0].AmmoAmount+MagAmmo < BeltLength+1)// Belt with no Box
		PlayAnim('ReloadFinishFew', 0.8*ReloadAnimRate, ,0.0);
	else						// Full Box and Belt
		PlayAnim('ReloadFinish', 0.8*ReloadAnimRate, ,0.0);
}

simulated function Notify_M353FlapOpenedReload ()
{
	super.PlayReload();
}

// Animation notify to make gun cock after reload
simulated function Notify_CockAfterReload()
{
	if (bNeedCock && MagAmmo > 0)
		CommonCockGun(2);
	else
		PlayAnim('ReloadFinishHold', ReloadAnimRate, 0.2);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim('ReloadEndCock'))
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
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

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}
// End AI Stuff =====

function byte BestMode()
{
	return 0;
}

//=====================================================
//			SPIN CODE
//=====================================================

replication
{
	reliable if (Role < ROLE_Authority)
		SetServerTurnVelocity;
}

function SetServerTurnVelocity (int NewTVYaw, int NewTVPitch)
{
	XM20PrimaryFire(FireMode[0]).TurnVelocity.Yaw = NewTVYaw;
	XM20PrimaryFire(FireMode[0]).TurnVelocity.Pitch = NewTVPitch;
}

simulated event WeaponTick (float DT)
{
	local rotator BT;

	BT.Roll = BarrelTurn;

	SetBoneRotation('Barrels', BT);

	DesiredSpeed = RotationSpeeds[CurrentWeaponMode];

	super.WeaponTick(DT);
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		Instigator.AmbientSound = None;
		BarrelSpeed = 0;
		return true;
	}
	return false;
}

simulated event Tick (float DT)
{
	local float OldBarrelTurn;

	super.Tick(DT);

	if (FireMode[0].IsFiring() && !bServerReloading)
	{
		BarrelSpeed = BarrelSpeed + FClamp(DesiredSpeed - BarrelSpeed, -0.35*DT, GetRampUpSpeed() *DT);
		BarrelTurn += BarrelSpeed * 655360 * DT;
	}
	else if (BarrelSpeed > 0)
	{
		BarrelSpeed = FMax(BarrelSpeed-0.5*DT, 0.01);
		OldBarrelTurn = BarrelTurn;
		BarrelTurn += BarrelSpeed * 655360 * DT;
		if (BarrelSpeed <= 0.025 && int(OldBarrelTurn/10922.66667) < int(BarrelTurn/10922.66667))
		{
			BarrelTurn = int(BarrelTurn/10922.66667) * 10922.66667;
			BarrelSpeed = 0;
			PlaySound(BarrelStopSound, SLOT_None, 0.5, , 32, 1.0, true);
			Instigator.AmbientSound = None;
		}
	}
	if (BarrelSpeed > 0)
	{
		Instigator.AmbientSound = BarrelSpinSound;
		Instigator.SoundPitch = 32 + 96 * BarrelSpeed;
	}

	if (ThirdPersonActor != None)
		XM20Attachment(ThirdPersonActor).BarrelSpeed = BarrelSpeed;
}

simulated function float GetRampUpSpeed()
{
	local float mult;
	
	mult = 1 - (BarrelSpeed / RotationSpeeds[2]);
	
	return 0.075f + (0.5f * mult * mult);
}


simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode > 0 && FireCount >= 1)
		return false;
	return super.CheckWeaponMode(Mode);
}

function ServerSwitchWeaponMode (byte NewMode)
{
	if (NewMode == 255)
		NewMode = CurrentWeaponMode + 1;
	while (NewMode != CurrentWeaponMode && (NewMode >= WeaponModes.length || WeaponModes[NewMode].bUnavailable) )
	{
		if (NewMode >= WeaponModes.length)
			NewMode = 0;
		else
			NewMode++;
	}
	if (!WeaponModes[NewMode].bUnavailable)
		CurrentWeaponMode = NewMode;
}

simulated function float ChargeBar()
{
     return BarrelSpeed / DesiredSpeed;
}

defaultproperties
{
     AimDisplacementDurationMult=1.25
     BarrelSpinSound=Sound'BallisticSounds2.XMV-850.XMV-BarrelSpinLoop'
     BarrelStopSound=Sound'BallisticSounds2.XMV-850.XMV-BarrelStop'
     BarrelStartSound=Sound'BallisticSounds2.XMV-850.XMV-BarrelStart'
	 DamageSound=Sound'PackageSounds4Pro.NEX.NEX-Overload'
     BrokenSound=Sound'BWBP2-Sounds.LightningGun.LG-Ambient'
     ChargingSound=Sound'WeaponSounds.BaseFiringSounds.BShield1'
     ManualLines(0)="Each hit heats up the target, causing subsequent shots to inflict greater damage. This effect on the target decays with time."
     ManualLines(1)="Secondary fire will toggle a directional shield. The shield has a maximum of 200 health points and will reduce incoming damage by 35 points or by 90% of its value, whichever is smaller. If the shield is broken, a minimum reserve level is required to reactivate it."
     ManualLines(2)="Effective at moderate range, against small arms, and against enemies using healing weapons and items."
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBPSomeOtherPackTex.XM20.BigIcon_XM20'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Energy=True
	 bNoCrosshairInScope=True
     SpecialInfo(0)=(Info="240.0;15.0;1.1;90.0;1.0;0.0;0.3")
     BringUpSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-Select')
     PutDownSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-Deselect')
     MagAmmo=120
     CockSound=(Sound=Sound'BallisticSounds3.USSR.USSR-Cock')
     ReloadAnim="ReloadStart"
	 ReloadAnimRate=1.500000
	 CockAnimRate=1.250000
	 CockingBringUpTime=1.400000
     ClipHitSound=(Sound=Sound'BWBP2-Sounds.LightningGun.LG-LeverDown')
     ClipOutSound=(Sound=Sound'BWBP4-Sounds.VPR.VPR-ClipOut')
     ClipInSound=(Sound=Sound'BWBP4-Sounds.VPR.VPR-ClipIn')
     ClipInFrame=0.650000 
     CurrentWeaponMode=2
     SightOffset=(X=-30.000000,Y=-0.380000,Z=10.660000)
	 SightDisplayFOV=15
     GunLength=80.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimSpread=14
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3000
	 RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.150000,OutVal=0.020000),(InVal=0.200000,OutVal=-0.050000),(InVal=0.300000),(InVal=0.400000,OutVal=-0.080000),(InVal=0.600000,OutVal=0.050000),(InVal=0.800000,OutVal=-0.030000),(InVal=1.000000,OutVal=0.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.550000),(InVal=0.500000,OutVal=0.600000),(InVal=0.600000,OutVal=0.500000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.050000
	 RecoilYFactor=0.05
     RecoilDeclineTime=1.500000
     FireModeClass(0)=Class'BWBPAnotherPackDE.XM20PrimaryFire'
     FireModeClass(1)=Class'BWBPAnotherPackDE.CSRSecondaryFire'
	 WeaponModes(0)=(ModeName="600 RPM",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="1200 RPM",ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="2400 RPM",ModeID="WM_FullAuto")
     SelectAnimRate=1.500000
     PutDownAnimRate=2.000000
     PutDownTime=0.500000
     BringUpTime=0.400000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     Description="To Do"
     Priority=194
     HudColor=(B=255,G=150,R=100)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=5
     GroupOffset=4
     PickupClass=Class'BWBPAnotherPackDE.XM20Pickup'
     PlayerViewOffset=(X=8.000000,Y=6.000000,Z=-7.500000)
     BobDamping=1.800000
     AttachmentClass=Class'BWBPAnotherPackDE.XM20Attachment'
	 bUseBigIcon=True
     IconMaterial=Texture'BWBPSomeOtherPackTex.XM20.Icon_XM20'
     IconCoords=(X2=127,Y2=31)
     ItemName="[B] Military Laser Thing"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWBPAnotherPackAnims2.ML_FPm'
     DrawScale=0.800000
}
