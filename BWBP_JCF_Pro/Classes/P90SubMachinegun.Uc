//=============================================================================
// XK2SubMachinegun.
//
// A light, very rapid fire SMG which can be silenced. Low damage, fairly low
// recoil, but unstable aim and burns through ammo fast. Silencer makes it very
// hard to detect by removing tracers, using a small muzzle flash and making
// low noise of course.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class P90SubMachinegun extends BallisticWeapon;


simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
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

/*simulated state PendingSwitchSilencer extends PendingDualAction
{
	simulated function BeginState()	{	OtherGun.LowerHandGun();	}
	simulated function HandgunLowered (BallisticHandgun Other)	{ global.HandgunLowered(Other); if (Other == Othergun) WeaponSpecial();	}
	simulated event AnimEnd(int Channel)
	{
		Othergun.RaiseHandGun();
		global.AnimEnd(Channel);
	}
}*/

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
	if (Dist > 700)
		Result += 0.3;
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result -= 0.05 * B.Skill;
	if (Dist > 2000)
		Result -= (Dist-2000) / 4000;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     //SupportHandBone="pasted__Root01"
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBP_JCF_Tex.P90.BigIcon_P90'
     SightFXClass=Class'BWBP_JCF_Pro.P90SightDot'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="420.0;20.0;1.50;80.0;0.4;0.2;-999.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
     CockSound=(Sound=Sound'BWBP_JCF_Sounds.P90.P90Cock',Volume=300.500000)
     ClipOutSound=(Sound=Sound'BWBP_JCF_Sounds.P90.P90ClipInOut',Volume=300.500000)
     ClipInSound=(Sound=Sound'BWBP_JCF_Sounds.P90.P90ClipHit',Volume=300.500000)
     ClipInFrame=0.650000
     WeaponModes(1)=(ModeName="Burst of Three",bUnavailable=True)
     WeaponModes(2)=(ModeName="Burst of Six",bUnavailable=True,ModeID="WM_BigBurst",Value=6.000000)
     WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     CurrentWeaponMode=3
     bNoCrosshairInScope=True
     SightPivot=(Pitch=-100)
	 BobDamping=2.2
     SightOffset=(X=-12.000000,Y=-0.420000,Z=12.700000)
     SightDisplayFOV=40.000000
     FireModeClass(0)=Class'BWBP_JCF_Pro.P90PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectForce="SwitchToAssaultRifle"
     Description="P90 Personal Defense Weapon||Manufacturer: Classic Weapons Industries|Primary: Accurate 5.7mm Fire|Secondary: Iron Sights||The P90, originally produced by Belgian firearms manufacturer FN Herstal in the pre-war period, has been brought back to the front lines by the venerable Classic Weapons Industries. The weapon contained several innovative features including the top-mounted magazine and proprietary 5.7x28mm ammunition, designed for greater penetration of body armor than conventional pistol ammunition. The CWI P90 PDW is a reliable and accurate weapon good for use at medium and short range. Its aged design does not limit its effectiveness, and to this day the P90 poses as a viable alternative to more modern models like the XK2, XRS-10 and MR-DR88."
     DisplayFOV=55.000000
     Priority=32
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     PickupClass=Class'BWBP_JCF_Pro.P90Pickup'
     PlayerViewOffset=(X=12.000000,y=6.000000,Z=-8.200000)
     AttachmentClass=Class'BWBP_JCF_Pro.P90Attachment'
     IconMaterial=Texture'BWBP_JCF_Tex.P90.SmallIcon_P90'
     IconCoords=(X2=127,Y2=34)
     ItemName="P90 Arctic Control Unit"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
	 ParamsClass=Class'P90WeaponParams'
     Mesh=SkeletalMesh'BWBP_JCF_Anims.FPm_P90'
     DrawScale=1.000000
}
