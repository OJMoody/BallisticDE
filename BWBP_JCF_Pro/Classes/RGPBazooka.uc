//=============================================================================
// G5Bazooka.
//
// Big rocket launcher. Fires a dangerous, not too slow moving rocket, with
// high damage and a fair radius. Low clip capacity, long reloading times and
// hazardous close combat temper the beast though.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RGPBazooka extends BallisticWeapon;

var() BUtil.FullSound	HatchSound;
//var   Actor				Camera;
var   bool				bCamView;


var   Actor			CurrentRocket;			//Current rocket of interest. The rocket that can be used as camera or directed with laser


/*simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (class'BallisticReplicationInfo'.default.bNoReloading && AmmoAmount(0) > 1)
		SetBoneScale (0, 1.0, 'Rocket');
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



/*simulated function bool PutDown()
{
	if (Super.PutDown())
	{

     		if (MagAmmo < 1)
			SetBoneScale (0, 0.0, 'Rocket');

		return true;
	}
	return false;
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
function byte BestMode()	{	return 0;	}

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
	if (Dist < 500)
		Result -= 0.6;
	else if (Dist > 3000)
		Result -= 0.3;
	result += 0.2 - FRand()*0.4;
	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====

/*simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	bScopeHeld=true;
	if (bCamView && (CurrentRocket == None || PlayerController(Instigator.Controller).ViewTarget == CurrentRocket))
		PlayerView();
	else if (CurrentRocket != None)
	{
		ReloadState = RS_None;
		ServerWeaponSpecial(i);
		bCamView=true;
		if (G5Mortar(CurrentRocket)!=None)
			G5Mortar(CurrentRocket).OnDie = RocketDie;
		PlayScopeUp();
	}
}

exec simulated function WeaponSpecialRelease(optional byte i)
{
	bScopeHeld=false;
}*/

/*simulated function ClientRocketDie(Actor Rocket)
{
	if (level.netMode == NM_Client)
		RocketDie(Rocket);
}

simulated function RocketDie(Actor Rocket)
{
	if (Role == ROLE_Authority && Instigator!= None && !Instigator.IsLocallyControlled())
		ClientRocketDie(Rocket);
}*/

/*simulated function PlayReload()
{
	bNeedCock=false;
	if (bScopeView && Instigator.Controller.IsA( 'PlayerController' ))
	{
		PlayerController(Instigator.Controller).EndZoom();
		class'BUtil'.static.PlayFullSound(self, ZoomOutSound);
	}

	SetBoneScale (0, 1.0, 'Rocket');
	if (MagAmmo < 1)
		PlayAnim('Reload', StartShovelAnimRate, , 0);
	else
		PlayAnim('Reload', ReloadAnimRate, , 0);
}*/


/*simulated function PlayShovelEnd()
{

	Super.PlayReload();
}*/


/*simulated function Notify_EGpHideRocket ()
{
	if (Level.NetMode == NM_DedicatedServer)
		return;
	if (!class'BallisticReplicationInfo'.default.bNoReloading || AmmoAmount(0) < 1)
		SetBoneScale (0, 0.0, 'Rocket');
}*/

defaultproperties
{
     PlayerSpeedFactor=0.850000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BWBP_JCF_Tex.rgp.BigIcon_RPG'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     bWT_Super=True
     SpecialInfo(0)=(Info="400.0;35.0;1.0;100.0;0.9;0.0;1.5")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Putaway')
     MagAmmo=4
     CockSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Lever')
     ReloadAnim="ReloadLoop"
     ReloadAnimRate=1.150000
     ClipOutSound=(Sound=Sound'BWBP_JCF_Sounds.RPG.Reload',Volume=2.500000)
     ClipInSound=(Sound=Sound'BWBP_JCF_Sounds.RPG.Reload',Volume=2.000000)
     bShovelLoad=True
	 bCanSkipReload=True
     StartShovelAnim="ReloadStart"
     EndShovelAnim="ReloadEnd"
     WeaponModes(0)=(ModeName="Single Fire")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     SightPivot=(Yaw=-512)
     SightOffset=(X=-20.000000,Y=-9.500000,Z=9.750000)
     SightDisplayFOV=40.000000
     FireModeClass(0)=Class'BWBP_JCF_Pro.RGPPrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectAnimRate=0.600000
     PutDownAnimRate=0.800000
     PutDownTime=0.800000
     BringUpTime=1.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.750000
     CurrentRating=0.750000
     Description="RPG-7 Anti-Tank Launcher||Manufacturer: Classic Weapons Industries|Primary: Powerful Rocket Fire|Secondary: Iron Sights||Ah, the RPG-7. The arch enemy of armored columns ever since its pre-war inception. The RPG-7 is a portable, shoulder mounted, anti-tank rocket propelled grenade launcher with a rugged, reliable design and a high powered warhead. While its anti-tank warhead may not be as accurate as the guidable G5's or as powerful as the SM-AT/AA's, it can still devastate infantry and disable lightly armored vehicles."
     Priority=199
     CenteredOffsetY=10.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     PickupClass=Class'BWBP_JCF_Pro.RGPPickup'
     PlayerViewOffset=(X=10.000000,Y=8.000000,Z=-8.000000)
     BobDamping=1.800000
     AttachmentClass=Class'BWBP_JCF_Pro.RGPAttachment'
     IconMaterial=Texture'BWBP_JCF_Tex.rgp.SmallIcon_RPG'
     IconCoords=(X2=127,Y2=35)
     ItemName="RGP-7 Soldier Rocket Launcher"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
	 ParamsClasses(0)=Class'RGPBazookaWeaponParamsArena'
     Mesh=SkeletalMesh'BWBP_JCF_Anims.FPm_RGP'
     DrawScale=1.200000
}
