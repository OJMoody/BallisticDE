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



// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();
	bUseNetAim = bScopeView;
	if (bScopeView)
	{
		AimSpread			/= 5.0;
     		RecoilDeclineTime    /= 2.0;
           AimAdjustTime		/= 3.0;
		BFireMode[0].XInaccuracy = 4.5;
		BFireMode[0].XInaccuracy = 4.5;
	}
	else
	{
		AimSpread 			= default.AimSpread;
     		RecoilDeclineTime    = default.RecoilDeclineTime;
           AimAdjustTime		= default.AimAdjustTime;
		BFireMode[0].XInaccuracy = BFireMode[0].default.XInaccuracy;
		BFireMode[0].YInaccuracy = BFireMode[0].default.YInaccuracy;
	}
}

simulated function SetDualMode (bool bDualMode)
{
	AdjustUziProperties(bDualMode);
}
simulated function AdjustUziProperties (bool bDualMode)
{
//	AimAdjustTime		= default.AimAdjustTime;
	AimSpread 			= default.AimSpread;
	ViewAimFactor		= default.ViewAimFactor;
	ViewRecoilFactor	= default.ViewRecoilFactor;
	ChaosDeclineTime	= default.ChaosDeclineTime;
	ChaosSpeedThreshold	= default.ChaosSpeedThreshold;
	ChaosAimSpread		= default.ChaosAimSpread;
	ChaosAimSpread 		*= BCRepClass.default.AccuracyScale;

	RecoilPitchFactor	= default.RecoilPitchFactor;
	RecoilYawFactor		= default.RecoilYawFactor;
	RecoilXFactor		= default.RecoilXFactor;
	RecoilYFactor		= default.RecoilYFactor;
//	RecoilMax			= default.RecoilMax;
	RecoilDeclineTime	= default.RecoilDeclineTime;

	/*if (bDualMode)
	{
		if (Instigator.IsLocallyControlled() && SightingState == SS_Active)
			StopScopeView();
		SetBoneScale(8, 0.0, SupportHandBone);
		if (AIController(Instigator.Controller) == None)
			bUseSpecialAim = true;
//		AimAdjustTime		*= 1.0;
		AimSpread			*= 2.0;
		ViewAimFactor		*= 0.6;
		ViewRecoilFactor	*= 0.75;
		ChaosDeclineTime	*= 1.2;
		ChaosSpeedThreshold	*= 0.8;
		ChaosAimSpread		*= 1.2;
		RecoilPitchFactor	*= 1.2;
		RecoilYawFactor		*= 2.0;
		RecoilXFactor		*= 1.2;
		RecoilYFactor		*= 1.2;
//		RecoilMax			*= 0.5;
		RecoilDeclineTime	*= 1.2;
		if ((IsSlave() && Othergun.Hand >= 0) || (!IsSlave() && Hand < 0))
			BallisticInstantFire(FireMode[0]).BallisticFireSound.Pitch=0.8;
	}
	else
	{
		SetBoneScale(8, 1.0, SupportHandBone);
		bUseSpecialAim = false;
	}*/

}

defaultproperties
{
     //SupportHandBone="pasted__Root01"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWWeaponPackArchive-Tex.P90.BigIcon_P90'
     SightFXClass=Class'BWBPArchivePackDE.P90SightDot'
     BCRepClass=Class'BallisticDE.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="420.0;20.0;1.50;80.0;0.4;0.2;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway')
     MagAmmo=50
     CockSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.P90.P90Cock',Volume=300.500000)
     ClipOutSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.P90.P90ClipInOut',Volume=300.500000)
     ClipInSound=(Sound=Sound'BWWeaponPack2Archive-Sounds.P90.P90ClipHit',Volume=300.500000)
     ClipInFrame=0.650000
	 
     WeaponModes(1)=(ModeName="Burst of Three",bUnavailable=True)
     WeaponModes(2)=(ModeName="Burst of Six",bUnavailable=True,ModeID="WM_BigBurst",Value=6.000000)
     WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     CurrentWeaponMode=3
     bNoCrosshairInScope=True
     SightPivot=(Pitch=-100)
     SightOffset=(X=-8.000000,Y=-0.420000,Z=12.700000)
     SightDisplayFOV=40.000000
     SightingTime=0.250000
     AimAdjustTime=1.200000
     ViewAimFactor=0.050000
     ViewRecoilFactor=0.300000
     ChaosSpeedThreshold=850.000000
	 AimSpread=32
	 ChaosAimSpread=2048
	 SprintOffSet=(Pitch=-3000,Yaw=-4000)
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.400000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=0.650000
     RecoilXFactor=0.100000
     RecoilYFactor=0.200000
     FireModeClass(0)=Class'BWBPArchivePackDE.P90PrimaryFire'
     FireModeClass(1)=Class'BCoreDE.BallisticScopeFire'
     SelectForce="SwitchToAssaultRifle"
     Description="P90 Personal Defense Weapon||Manufacturer: Classic Weapons Industries|Primary: Accurate 5.7mm Fire|Secondary: Iron Sights||The P90, originally produced by Belgian firearms manufacturer FN Herstal in the pre-war period, has been brought back to the front lines by the venerable Classic Weapons Industries. The weapon contained several innovative features including the top-mounted magazine and proprietary 5.7x28mm ammunition, designed for greater penetration of body armor than conventional pistol ammunition. The CWI P90 PDW is a reliable and accurate weapon good for use at medium and short range. Its aged design does not limit its effectiveness, and to this day the P90 poses as a viable alternative to more modern models like the XK2, XRS-10 and MR-DR88."
     DisplayFOV=55.000000
     Priority=32
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
	 InventorySize=12
     PickupClass=Class'BWBPArchivePackDE.P90Pickup'
     PlayerViewOffset=(X=12.000000,y=6.000000,Z=-8.200000)
     AttachmentClass=Class'BWBPArchivePackDE.P90Attachment'
     IconMaterial=Texture'BWWeaponPackArchive-Tex.P90.SmallIcon_P90'
     IconCoords=(X2=127,Y2=34)
     ItemName="P90 Arctic Control Unit"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BWWeaponPackAnims.P90_FPm'
     DrawScale=1.000000
}
