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
class T9CNPistol extends BallisticWeapon;


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
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBP_SKC_TexExp.T9CN.BigIcon_BerSilver'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="420.0;20.0;1.50;80.0;0.4;0.2;-999.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
     MagAmmo=18
	 BobDamping=2.200000
     CockSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-Cock',Volume=300.500000)
     ClipHitSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-SlideBack',Volume=1.500000)
	 ClipOutSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-ClipOut',Volume=300.500000)
     ClipInSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-ClipIn',Volume=300.500000)
     ClipInFrame=0.650000
     WeaponModes(1)=(ModeName="Burst of Three",bUnavailable=True)
     WeaponModes(2)=(ModeName="Burst of Six",bUnavailable=True,ModeID="WM_BigBurst",Value=6.000000)
     WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     CurrentWeaponMode=3
     bNoCrosshairInScope=False
     SightOffset=(X=-16.000000,Y=-2.110000,Z=9.00000)
     SightDisplayFOV=40.000000
     FireModeClass(0)=Class'BWBP_SKCExp_Pro.T9CNPrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectForce="SwitchToAssaultRifle"
     Description="The T9CN was the precursor to the standard GRS9 Pistol, and it sported a rugged automatic firing mechanism and nickel finish. The automatic variant was designed with use by counter-terrorism units in mind, but sadly a lack of compensator gave the gun horrible inaccuracy and recoil. Most CTU's quickly dropped the T9CN in favor of other more accurate machine pistols like the XRS-10 and the XK2, however infamous outlaw Var Dehidra and his cronies stole a stash of T9CN's and found good use for them. They were known for spraying them to keep enemies at bay and even tilting them to the side like gangsters of old. Their brazen use of police equipment inspired robberies throughout the cosmos!"
     DisplayFOV=55.000000
     Priority=32
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     PickupClass=Class'BWBP_SKCExp_Pro.T9CNPickup'
     PlayerViewOffset=(X=7.000000,Y=6.000000,Z=-7.000000)
     AttachmentClass=Class'BWBP_SKCExp_Pro.T9CNAttachment'
     IconMaterial=Texture'BWBP_SKC_TexExp.T9CN.SmallIcon_BerSilver'
     IconCoords=(X2=127,Y2=32)
     ItemName="T9CN Automatic Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
	 ParamsClass=Class'T9CNWeaponParams'
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_T9CN'
     DrawScale=0.200000
}
