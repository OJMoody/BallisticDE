//=============================================================================
// T9CNPistol.
//
// Silver Beretta
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class T9CNMachinePistol extends BallisticWeapon;
  	
var bool		bFirstDraw;

var() array<Material> CamoMaterialsSlide;

replication
{
	reliable if(Role == ROLE_Authority)
        	ClientSwitchCannonMode, ClientSwitchRapidMode;
}


simulated function ClientSwitchCannonMode (byte newMode)
{
	T9CNPrimaryFire(FireMode[0]).SwitchCannonMode(newMode);
}

function DropFrom(vector StartLocation)
{
    	local int m;
	local Pickup Pickup;

	//if (IsMaster())
	/*{
		OtherGun.DropFrom(StartLocation);
		if (Instigator.Health > 0)
			return;
	}*/

    	if (!bCanThrow)
        	return;

	if (AmbientSound != None)
		AmbientSound = None;

    	ClientWeaponThrown();

	/*if (OtherGun != None)
	{
		OtherGun.bIsMaster = false;
		OtherGun.SetDualMode(false);
		OtherGun.OtherGun = None;
		bIsMaster = false;
		SetDualMode(false);
		OtherGun = None;
	}*/

    	for (m = 0; m < NUM_FIRE_MODES; m++)
    	{
        	if (FireMode[m] != None && FireMode[m].bIsFiring)
            		StopFire(m);
    	}

	if ( Instigator != None )
		DetachFromPawn(Instigator);

	Pickup = Spawn(PickupClass,self,, StartLocation);
	if ( Pickup != None )
	{
        	if (Instigator.Health > 0)
            		WeaponPickup(Pickup).bThrown = true;
    		Pickup.InitDroppedPickupFor(self);
	    	Pickup.Velocity = Velocity;
    }
    Destroy();
}

//Modified burst
simulated function PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (CurrentWeaponMode == 1)	
	{
		T9CNPrimaryFire(BFireMode[0]).bRapidMode = True;
 	}
}


// Cycle through the various weapon modes
function ServerSwitchWeaponMode (byte NewMode)
{


	if (CurrentWeaponMode > 0 && FireMode[0].IsFiring())
		return;

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
  
	// Azarael - This assumes that all firemodes implementing burst modify the primary fire alone.
	// To my knowledge, this is the case.
	// Sarge - Hard coding to work with the T9CN - Cut down
	if (CurrentWeaponMode == 1)
	{
		T9CNPrimaryFire(BFireMode[0]).bRapidMode = True;
		if (!Instigator.IsLocallyControlled())
			ClientSwitchRapidMode(True);
	}
	else if (T9CNPrimaryFire(BFireMode[0]).bRapidMode)
	{ 
		T9CNPrimaryFire(BFireMode[0]).bRapidMode = False;
		if (!Instigator.IsLocallyControlled())
			ClientSwitchRapidMode(False);
	}

	if (!Instigator.IsLocallyControlled())
		T9CNPrimaryFire(FireMode[0]).SwitchCannonMode(CurrentWeaponMode);
	ClientSwitchCannonMode (CurrentWeaponMode);

}

simulated function ClientSwitchRapidMode(bool bRapid, optional int Max)
{
	T9CNPrimaryFire(BFireMode[0]).bRapidMode = bRapid;
}



// Change some properties when using sights...
//simulated function SetScopeBehavior()
/*{
	super.SetScopeBehavior();

	bUseNetAim = default.bUseNetAim || bScopeView;
	ViewAimFactor = default.ViewAimFactor;
	ViewRecoilFactor = default.ViewRecoilFactor;
	ChaosDeclineTime = default.ChaosDeclineTime;

	if (Hand < 0)
		SightOffset.Y = default.SightOffset.Y * -1;
}*/


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

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockSim()
{
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}


simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (MagAmmo == 0)
		SetBoneScale (1, 0.0, 'Bullet');
	if (bFirstDraw && MagAmmo > 0)
	{
     		SelectAnim='Pullout';
		bFirstDraw=false;
	}
	else
	{
		SelectAnim='Pullout';
	}

	Super.BringUp(PrevWeapon);

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

	if (Instigator != None && AIController(Instigator.Controller) != None)
	{
		BallisticInstantFire(FireMode[0]).FireRate=0.160000;
	}

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
			IdleAnim = 'IdleOpen';
			ReloadAnim = 'ReloadOpen';
			SetBoneScale (1, 0.0, 'Bullet');
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

simulated function Notify_HideBullet()
{
	if (MagAmmo < 2)
		SetBoneScale (1, 0.0, 'Bullet');
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
				SightingPhase += DT/0.15;
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
				SightingPhase -= DT/0.15;
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

defaultproperties
{
     bFirstDraw=True
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=3)
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticRecolors4.T9CN.BigIcon_BerSilver'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     InventorySize=10
     SpecialInfo(0)=(Info="1200.0;65.0;4.0;150.0;2.0;2.0;1.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway')
     MagAmmo=12
     CockAnimRate=1.200000
     CockSound=(Sound=Sound'PackageSounds4.T9CN.T9CN-Cock',Volume=1.000000)
     ReloadAnimRate=1.100000
     ClipHitSound=(Sound=Sound'PackageSounds4.T9CN.T9CN-SlideBack',Volume=1.500000)
     ClipOutSound=(Sound=Sound'PackageSounds4.T9CN.T9CN-ClipOut',Volume=1.500000)
     ClipInSound=(Sound=Sound'PackageSounds4.T9CN.T9CN-ClipIn',Volume=1.500000)
     ClipInFrame=0.650000
     FullZoomFOV=90.000000
     SightOffset=(X=-20.000000,Y=-2.950000,Z=12.700000)
     SightDisplayFOV=40.000000
     SightingTime=0.150000
     JumpOffSet=(Pitch=1000,Yaw=-500)
	 AimSpread=8
	 ChaosAimSpread=512
     JumpChaos=0.025000
     FallingChaos=0.050000
     SprintChaos=0.050000
     AimAdjustTime=0.350000
     ViewAimFactor=0.200000
     ViewRecoilFactor=0.200000
     AimDamageThreshold=480.000000
     ChaosSpeedThreshold=11200.000000
     RecoilPitchFactor=0.200000
     RecoilYawFactor=0.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.300000
     RecoilMax=4096.000000
	 RecoilDeclineDelay=0.200000
     RecoilDeclineTime=0.400000
	 ChaosDeclineTime=1.000000
     FireModeClass(0)=Class'BWBPArchivePackDE.T9CNPrimaryFire'
     IdleAnimRate=0.600000
     PutDownTime=0.600000
     BringUpTime=0.600000
     SelectForce="SwitchToAssaultRifle"
     Description="T9CN 'Hammer' Machine Pistol||Manufacturer: Drake & Co Firearms|Primary: Auto 9mm Rounds|Secondary: Iron Sights|| The T9CN was the precursor to the standard GRS9 Pistol, and it sported a rugged automatic firing mechanism and nickel finish. The automatic variant was designed with use by counter-terrorism units in mind, but sadly a lack of compensator gave the gun horrible inaccuracy and recoil. Most CTU's quickly dropped the GRS1 in favor of other more accurate machine pistols like the XRS-10 and the XK2, however infamous outlaw Var Dehidra and his cronies stole a stash of T9CN's and found good use for them. They were known for spraying them to keep enemies at bay and even tilting them to the side like gangsters of old. Their brazen use of police equipment inspired robberies throughout the cosmos!"
     Priority=156
     InventoryGroup=2
     GroupOffset=3
     PickupClass=Class'BWBPArchivePackDE.T9CNPickup'
     PlayerViewOffset=(X=-2.000000,Y=9.000000,Z=-11.000000)
     AttachmentClass=Class'BWBPArchivePackDE.T9CNAttachment'
     IconMaterial=Texture'BallisticRecolors4.T9CN.SmallIcon_BerSilver'
     IconCoords=(X2=127,Y2=31)
     ItemName="T9CN Machine Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BWBPArchivePack1Anim.M9_FP'
     DrawScale=0.280000
     Skins(0)=Shader'BallisticRecolors4.T9CN.Ber-MainShine'
     Skins(1)=Shader'BallisticRecolors4.T9CN.Ber-SlideShine'
     Skins(2)=Texture'BallisticRecolors4.T9CN.Ber-Mag'
     Skins(3)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     bFullVolume=True
     SoundRadius=256.000000
}
