//=============================================================================
// M806Pistol.
//
// Semi Automatic pistol with decent damage, 12 round clip, good accracy when
// used carefully, but mainly, its the default weapon.
// Secondary fixes to unpredictable aiming by providing a laser sight so that
// the user knows where to expect the bullets.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DEPistol extends BallisticHandgun;

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

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('Cock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
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
// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();

	bUseNetAim = bScopeView;
	if (bScopeView)
	{
		ViewRecoilFactor = 0.3;
		ChaosDeclineTime *= 1.5;
	}
}



// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()	{	return 0;	}


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
function float SuggestAttackStyle()	{	return 0.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     SupportHandBone="pasted__Root1"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWWeaponPack-Tex.DE.BigIcon_DE'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     InventorySize=26
     bWT_Bullet=True
     SpecialInfo(0)=(Info="180.0;18.0;2.0;125.0;0.45;0.3;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway')
     MagAmmo=7
     CockSound=(Sound=Sound'BallisticSounds2.M806.M806-Cock')
     ClipHitSound=(Sound=Sound'BWWeaponPack2-Sounds.DE.DEClipHit',Volume=350.500000)
     ClipOutSound=(Sound=Sound'BWWeaponPack2-Sounds.DE.DEClipOut',Volume=350.500000)
     ClipInSound=(Sound=Sound'BWWeaponPack2-Sounds.DE.DEClipIn',Volume=350.500000)
     ClipInFrame=0.650000
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     SightPivot=(Pitch=100)
     SightOffset=(X=-18.000000,Y=12.770000,Z=11.100000)
     SightDisplayFOV=40.000000
     SprintOffSet=(Pitch=-5125,Yaw=-5125)
     JumpOffSet=(Pitch=1000,Yaw=-500)
     JumpChaos=0.350000
     AimAdjustTime=0.350000
     ViewAimFactor=0.300000
     ViewRecoilFactor=0.200000
     ChaosDeclineTime=0.450000
     ChaosSpeedThreshold=750.000000
     RecoilYawFactor=0.400000
     RecoilXFactor=0.350000
     RecoilYFactor=0.320000
     RecoilMax=5000.000000
     RecoilDeclineTime=0.400000
     RecoilDeclineDelay=0.200000
     FireModeClass(0)=Class'BWBPArchivePackDE.DEPrimaryFire'
     FireModeClass(1)=Class'BCoreDE.BallisticScopeFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     bSniping=True
     Description="Desert Eagle .50 Pistol||Manufacturer: Classic Weapons Industries|Primary: 50 cal Fire|Secondary: Iron Sights||The extremely high powered .50 Desert Eagle is back! Don't be fooled by those Enravion AH208 knock offs, CWI's Desert Eagle is the real deal. Manufactured using pre-war methods and design documents, this DE .50 is as close as you can get to the original. The original was a large-framed gas-operated semi-automatic pistol designed by Magnum Research in the U.S. whose fame lasts to this day."
     Priority=44
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     GroupOffset=3
     PickupClass=Class'BWBPArchivePackDE.DEPickup'
     PlayerViewOffset=(X=10.000000,Y=-2.000000,Z=-9.000000)
     AttachmentClass=Class'BWBPArchivePackDE.DEAttachment'
     IconMaterial=Texture'BWWeaponPack-Tex.DE.SmallIcon_DE'
     IconCoords=(X2=127,Y2=49)
     ItemName="Desert Eagle .50 Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BWWeaponPackAnims.DE'
     DrawScale=0.400000
}
