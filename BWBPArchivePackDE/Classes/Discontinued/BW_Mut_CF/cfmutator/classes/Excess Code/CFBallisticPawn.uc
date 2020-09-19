//=============================================================================
// CFBallisticPawn.
//
// Pawn for:
// - disabling crosshairs and turret crosshairs
// - set "Long Throw" grenade weapon mode default
// - set "Flare" BORT weapon mode default
// - Remove "Grenade" BORT weapon mode
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFBallisticPawn extends BallisticPawn DependsOn(BallisticWeapon) DependsOn(CF_PickupMeshCache);

//var float startTime;

var bool pawnNetInit;

var bool bDisableCrosshairs;
var bool bDisableTurretCrosshairs;
var bool bSetGrenadeLongThrowDefault;
var int iAdrenaline;
var int iAdrenalineCap;
var float dieSoundAmplifier;
var float dieSoundRangeAmplifier;
var float hitSoundAmplifier;
var float hitSoundRangeAmplifier;
var float jumpDamageAmplifier;
var bool bNeckBreak;
var bool bAchievements;
var Material RealSkinsExt[9];

var PlayerController PrevPlayerController;
var bool bUpdateCrosshair;

var bool bNeckBroken;

//=============================================================================
// ACHIEVEMENTS
//=============================================================================
var CFClientServiceActor ServiceActor;

var CFLocalClientServiceActor lsa;

var bool bBirthControl;

var Texture 	ASniper;
var Texture 	AExplosives;
var Texture 	AGas;
var Texture 	AMelee;
var Texture 	AMG;
var Texture 	APyro;
var Texture 	ARevolver;
var Texture		ABlunt;
var Texture		AHead;
var Texture		ASpawn;

var Texture 	ASniperG;
var Texture 	AExplosivesG;
var Texture 	AGasG;
var Texture 	AMeleeG;
var Texture 	AMGG;
var Texture 	APyroG;
var Texture 	ARevolverG;
var Texture		ABluntG;
var Texture		AHeadG;
var Texture		ASpawnG;

var float BadgeStarEffectExpireTime[10];

var Material 	ARevolverS;
var Material 	AHeadS;
var Material 	AMGS;
var Material 	ASniperS;
var Material 	AExplosivesS;
var Material 	ASpawnS;
var Material 	AMeleeS;
var Material 	ABluntS;
var Material 	APyroS;
var Material 	AGasS;
//=============================================================================
// ACHIEVEMENTS
//=============================================================================

//=============================================================================
// BULLET TIME STUFF
//=============================================================================
var Material BulletTimeOverlay;

var bool bulletTimeInitiated;

struct bulletTimedGunsVars
{
	var float IdleAnimRate;
	var float RestAnimRate;
	var float AimAnimRate;
	var float RunAnimRate;
	var float SelectAnimRate;
	var float PutDownAnimRate;
	var float PutDownTime;
	var float BringUpTime;
	var float DownDelay;

	var float CockAnimRate;
	var float ReloadAnimRate;
	var float StartShovelAnimRate;
	var float EndShovelAnimRate;
	var float SightingTime;
	var float RecoilDeclineDelay;
	var float BFireModeOneTweenTime;
	var float BFireModeOneFireEndAnimRate;
	var float BFireModeTwoTweenTime;
	var float BFireModeTwoFireEndAnimRate;
	var float IdleTweenTime;
};

struct bulletTimedGunsDefaultVars
{
	var string weaponClass;
	var float defaultSightingTime;
};

var array<bulletTimedGunsDefaultVars> bulletTimedGunsDefaulsOriginal; // this list holds the default values
var array<Weapon> bulletTimedGuns;
var array<bulletTimedGunsVars> bulletTimedGunsOriginal;
//=============================================================================
// BULLET TIME STUFF
//=============================================================================

var Rotator lockedViewRotation, originalViewRotation;
var bool bLockedView;
var Weapon grabGun;
var BCSprintControl sprinter;
var bool bAnimatedPickups;

replication
{
	reliable if(Role == ROLE_Authority && bNetInitial)
		bDisableCrosshairs, bDisableTurretCrosshairs, bSetGrenadeLongThrowDefault,
		iAdrenaline, iAdrenalineCap, dieSoundAmplifier, dieSoundRangeAmplifier, hitSoundAmplifier, hitSoundRangeAmplifier, jumpDamageAmplifier, bNeckBreak, bAchievements, bAnimatedPickups;

	reliable if(Role == ROLE_Authority)
		ScoreKnifeKill, ScoreMGKill, ScoreGrenadeKill, ScoreBluntKill, ServiceActor, ScoreSuicide, ScoreSpawnKill, ScoreHeadshot,
		ScoreRevKill, ScorePyroKill, ScoreSniperKill, ScoreGasKill, initiateBulletTime, lsa, StartPickupAnimation;
}

simulated function Timer()
{
	killBirthControlTimer();
}

simulated function AddPickupOverlay()
{

}

//=============================================================================
// ACHIEVEMENTS
//=============================================================================
function DrawHUD(Canvas C)
{
	local float HudOpacity;
	local float HudScale;
	local float badgeScale;
	local bool bWeaponbar;

	if(Level.NetMode == NM_DedicatedServer)
	{
		Super.DrawHUD(C);
		return;
	}

	if(PlayerController(Controller) != none)
	{
		HudOpacity = PlayerController(Controller).myHUD.HudOpacity;
		HudScale = PlayerController(Controller).myHUD.HudScale;
		bWeaponbar = PlayerController(Controller).myHUD.bShowWeaponBar;
	}else
	{
		HudOpacity = 255;
		HudScale = 1.0;
		bWeaponbar = false;
	}

	badgeScale = 128 * HudScale;

	Super.DrawHUD(C);

	if(bAchievements && bWeaponbar && lsa != none && ServiceActor != none)
	{
		// left
		if(ServiceActor.iRevolver != 0 && ServiceActor.iRevolver >= 5 && lsa.revCurrent != none && lsa.revCurrent == ServiceActor.pri) // REVOLVER
		{
			C.SetDrawColor(255,255,255,255);
			C.SetPos(10, (C.SizeY *0.5) - 370);
			C.DrawTile(ARevolver, badgeScale, badgeScale, 0, 0, 128, 128);

			if(Level.TimeSeconds < BadgeStarEffectExpireTime[0])
			{
				C.SetDrawColor(255,255,255,255);
				C.SetPos(10, (C.SizeY *0.5) - 370);
				C.DrawTile(ARevolverS, badgeScale, badgeScale, 0, 0, 128, 128);
			}
		}else
		{
			C.SetDrawColor(255,255,255,HudOpacity);
			C.SetPos(10, (C.SizeY *0.5) - 370);
			C.DrawTile(ARevolverG, badgeScale, badgeScale, 0, 0, 128, 128);
		}

		if(ServiceActor.iMGKills != 0 && ServiceActor.iMGKills >= 5 && lsa.mgCurrent != none && lsa.mgCurrent == ServiceActor.pri) // MG
		{
			C.SetDrawColor(255,255,255,255);
			C.SetPos(10, (C.SizeY *0.5) - 232);
			C.DrawTile(AMG, badgeScale, badgeScale, 0, 0, 128, 128);

			if(Level.TimeSeconds < BadgeStarEffectExpireTime[1])
			{
				C.SetDrawColor(255,255,255,255);
				C.SetPos(10, (C.SizeY *0.5) - 232);
				C.DrawTile(AMGS, badgeScale, badgeScale, 0, 0, 128, 128);
			}
		}else
		{
			C.SetDrawColor(255,255,255,HudOpacity);
			C.SetPos(10, (C.SizeY *0.5) - 232);
			C.DrawTile(AMGG, badgeScale, badgeScale, 0, 0, 128, 128);
		}

		if(ServiceActor.iSniperKills >= 5 && lsa.sniperCurrent != none && lsa.sniperCurrent == ServiceActor.pri) // Sniper
		{
			C.SetDrawColor(255,255,255,255);
			C.SetPos(10, (C.SizeY *0.5) - 84);
			C.DrawTile(ASniper, badgeScale, badgeScale, 0, 0, 128, 128);

			if(Level.TimeSeconds < BadgeStarEffectExpireTime[2])
			{
				C.SetDrawColor(255,255,255,255);
				C.SetPos(10, (C.SizeY *0.5) - 84);
				C.DrawTile(ASniperS, badgeScale, badgeScale, 0, 0, 128, 128);
			}
		}else
		{
			C.SetDrawColor(255,255,255,HudOpacity);
			C.SetPos(10, (C.SizeY *0.5) - 84);
			C.DrawTile(ASniperG, badgeScale, badgeScale, 0, 0, 128, 128);
		}

		if(ServiceActor.iGrenadeKills != 0 && lsa.grenadeCurrent != none && lsa.grenadeCurrent == ServiceActor.pri) // Explosive
		{
			C.SetDrawColor(255,255,255,255);
			C.SetPos(10, (C.SizeY *0.5) + 64);
			C.DrawTile(AExplosives, badgeScale, badgeScale, 0, 0, 128, 128);

			if(Level.TimeSeconds < BadgeStarEffectExpireTime[3])
			{
				C.SetDrawColor(255,255,255,255);
				C.SetPos(10, (C.SizeY *0.5) + 64);
				C.DrawTile(AExplosivesS, badgeScale, badgeScale, 0, 0, 128, 128);
			}
		}else
		{
			C.SetDrawColor(255,255,255,HudOpacity);
			C.SetPos(10, (C.SizeY *0.5) + 64);
			C.DrawTile(AExplosivesG, badgeScale, badgeScale, 0, 0, 128, 128);
		}

		if(ServiceActor.iSpawnKills != 0 && lsa.spawnCurrent != none && lsa.spawnCurrent == ServiceActor.pri) // Spawn raid
		{
			C.SetDrawColor(255,255,255,255);
			C.SetPos(10, (C.SizeY *0.5) + 212);
			C.DrawTile(ASpawn, badgeScale, badgeScale, 0, 0, 128, 128);

			if(Level.TimeSeconds < BadgeStarEffectExpireTime[4])
			{
				C.SetDrawColor(255,255,255,255);
				C.SetPos(10, (C.SizeY *0.5) + 212);
				C.DrawTile(ASpawnS, badgeScale, badgeScale, 0, 0, 128, 128);
			}
		}else
		{
			C.SetDrawColor(255,255,255,HudOpacity);
			C.SetPos(10, (C.SizeY *0.5) + 212);
			C.DrawTile(ASpawnG, badgeScale, badgeScale, 0, 0, 128, 128);
		}

		// right
		if(ServiceActor.iHeadshots != 0 && ServiceActor.iHeadshots >=3 && lsa.hsCurrent != none && lsa.hsCurrent == ServiceActor.pri) // HEADSHOT
		{
			C.SetDrawColor(255,255,255,255);
			C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) - 370);
			C.DrawTile(AHead, badgeScale, badgeScale, 0, 0, 128, 128);

			if(Level.TimeSeconds < BadgeStarEffectExpireTime[5])
			{
				C.SetDrawColor(255,255,255,255);
				C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) - 370);
				C.DrawTile(AHeadS, badgeScale, badgeScale, 0, 0, 128, 128);
			}
		}else
		{
			C.SetDrawColor(255,255,255,HudOpacity);
			C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) - 370);
			C.DrawTile(AHeadG, badgeScale, badgeScale, 0, 0, 128, 128);
		}

		if(ServiceActor.iKnifeKills != 0 && lsa.knifeCurrent != none && lsa.knifeCurrent == ServiceActor.pri) // MELEE
		{
			C.SetDrawColor(255,255,255,255);
			C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) - 232);
			C.DrawTile(AMelee, badgeScale, badgeScale, 0, 0, 128, 128);

			if(Level.TimeSeconds < BadgeStarEffectExpireTime[6])
			{
				C.SetDrawColor(255,255,255,255);
				C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) - 232);
				C.DrawTile(AMeleeS, badgeScale, badgeScale, 0, 0, 128, 128);
			}
		}else
		{
			C.SetDrawColor(255,255,255,HudOpacity);
			C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) - 232);
			C.DrawTile(AMeleeG, badgeScale, badgeScale, 0, 0, 128, 128);
		}

		if(ServiceActor.iBluntKills != 0 && lsa.bluntCurrent != none && lsa.bluntCurrent == ServiceActor.pri) // BLUNT
		{
			C.SetDrawColor(255,255,255,255);
			C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) - 84);
			C.DrawTile(ABlunt, badgeScale, badgeScale, 0, 0, 128, 128);

			if(Level.TimeSeconds < BadgeStarEffectExpireTime[7])
			{
				C.SetDrawColor(255,255,255,255);
				C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) - 84);
				C.DrawTile(ABluntS, badgeScale, badgeScale, 0, 0, 128, 128);
			}
		}else
		{
			C.SetDrawColor(255,255,255,HudOpacity);
			C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) - 84);
			C.DrawTile(ABluntG, badgeScale, badgeScale, 0, 0, 128, 128);
		}

		if(ServiceActor.iPyro != 0 && ServiceActor.iPyro >=5 && lsa.pyroCurrent != none && lsa.pyroCurrent == ServiceActor.pri) // PYRO
		{
			C.SetDrawColor(255,255,255,255);
			C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) + 64);
			C.DrawTile(APyro, badgeScale, badgeScale, 0, 0, 128, 128);

			if(Level.TimeSeconds < BadgeStarEffectExpireTime[8])
			{
				C.SetDrawColor(255,255,255,255);
				C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) + 64);
				C.DrawTile(APyroS, badgeScale, badgeScale, 0, 0, 128, 128);
			}
		}else
		{
			C.SetDrawColor(255,255,255,HudOpacity);
			C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) + 64);
			C.DrawTile(APyroG, badgeScale, badgeScale, 0, 0, 128, 128);
		}

		if(ServiceActor.iGas != 0 && lsa.gasCurrent != none && lsa.gasCurrent == ServiceActor.pri) // GAS
		{
			C.SetDrawColor(255,255,255,255);
			C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) + 212);
			C.DrawTile(AGas, badgeScale, badgeScale, 0, 0, 128, 128);

			if(Level.TimeSeconds < BadgeStarEffectExpireTime[9])
			{
				C.SetDrawColor(255,255,255,255);
				C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) + 212);
				C.DrawTile(AGasS, badgeScale, badgeScale, 0, 0, 128, 128);
			}
		}else
		{
			C.SetDrawColor(255,255,255,HudOpacity);
			C.SetPos(C.SizeX - badgeScale - 10, (C.SizeY *0.5) + 212);
			C.DrawTile(AGasG, badgeScale, badgeScale, 0, 0, 128, 128);
		}
	}
}

//=============================================================================
// ACHIEVEMENTS
//=============================================================================

simulated function PostNetBeginPlay()
{
	if(!pawnNetInit)
	{
		pawnNetInit = true;

		if(Controller != none)
		{
			if(Controller.Adrenaline < iAdrenaline)
			{
				Controller.Adrenaline = iAdrenaline;
			}
			Controller.AdrenalineMax = iAdrenalineCap;
		}
	}
	Super.PostNetBeginPlay();
}

//function PossessedBy(Controller c)
//{
//	if(Bot(c) != none)
//	{
//		Weapon = Spawn(class'BCoreV25.NullGun', self);
//	}
//	Super.PossessedBy(c);
//}

Event PreBeginPlay()
{
//	if(Controller != none)
//	if(Bot(Controller) != none)
//	{
		Weapon = Spawn(class'BCoreV25.NullGun', self);
//	}
	Super.PreBeginPlay();
}

simulated event Tick(float deltaSeconds)
{
	local BallisticTurret turret;
	local BallisticWeapon bw;

	super.Tick(deltaSeconds);

	if(bDisableTurretCrosshairs && bUpdateCrosshair && PrevPlayerController != None && BallisticTurret(PrevPlayerController.Pawn) != None)
	{
		bUpdateCrosshair=false;

		turret = BallisticTurret(PrevPlayerController.Pawn);
		bw = BallisticWeapon(turret.Weapon);

		if(bw != none)
		{
			if(bw.bOldCrosshairs)
				bw.bOldCrosshairs = false;
				bw.CustomCrosshair = 0;
				bw.bGlobalCrosshair = false;
				bw.CrosshairCfg.Pic1 = none;
				bw.crosshairCfg.Pic2 = none;
		}
	}
}

//=============================================================================
// WEAPON CHANGES
// ACHIEVEMENTS
//=============================================================================
simulated function ServerChangedWeapon(Weapon OldWeapon, Weapon NewWeapon)
{
	local BallisticWeapon bw;
	local BallistichandGrenade grenade;
	local BallisticWeapon.WeaponModeType LongThrowMode, AutoThrowMode, GrenadeChangeIndicator;
	local byte LongThrowID, AutoThrowID;
	local array<BallisticWeapon.WeaponModeType> GrenadeWeaponModes;
	local int i;
	local float InvisTime;

	if(NewWeapon != none)
		bw = BallisticWeapon(NewWeapon);

	if(bw != none && bSetGrenadeLongThrowDefault && bw != none && BallistichandGrenade(bw) != none)
	{
		LongThrowID = -1;
		AutoThrowID = -1;

		grenade = BallistichandGrenade(bw);
		if(grenade.WeaponModes.Length > 2 && grenade.WeaponModes[grenade.WeaponModes.length -1].ModeName != "C")
		{
			GrenadeWeaponModes = grenade.WeaponModes;
			for(i = 0; i < grenade.WeaponModes.length; i++)
			{
				if(grenade.WeaponModes[i].ModeName == "Long Throw")
				{
					LongThrowID = i;
					LongThrowMode = grenade.WeaponModes[i];
					break;
				}
			}
			if(LongThrowID != -1)
			{
				GrenadeWeaponModes.Remove(LongThrowID, 1);
				GrenadeWeaponModes.Insert(0, 1);
				GrenadeWeaponModes[0] = LongThrowMode;
			}
			grenade.WeaponModes = GrenadeWeaponModes;

			for(i = 0; i < grenade.WeaponModes.length; i++)
			{
				if(grenade.WeaponModes[i].ModeName == "Auto Throw")
				{
					AutoThrowID = i;
					AutoThrowMode = grenade.WeaponModes[i];
					break;
				}
			}
			if(AutoThrowID != -1)
			{
				GrenadeWeaponModes.Remove(AutoThrowID, 1);
				GrenadeWeaponModes.Insert(GrenadeWeaponModes.Length, 1);
				GrenadeWeaponModes[GrenadeWeaponModes.Length -1] = AutoThrowMode;
			}
			GrenadeChangeIndicator.bUnavailable = true;
			GrenadeChangeIndicator.ModeName = "C";

			GrenadeWeaponModes.Insert(GrenadeWeaponModes.Length, 1);
			GrenadeWeaponModes[GrenadeWeaponModes.Length -1] = GrenadeChangeIndicator;

			grenade.WeaponModes = GrenadeWeaponModes;
		}
	}

	if ( bInvis )
	{
	    if ( (OldWeapon != None) && (OldWeapon.OverlayMaterial == InvisMaterial) )
		    InvisTime = OldWeapon.ClientOverlayCounter;
	    else
		    InvisTime = 20000;
	}
	if (HasUDamage() || bInvis)
		SetWeaponOverlay(None, 0.f, true);

	Super(Pawn).ServerChangedWeapon(OldWeapon, NewWeapon);

	if (bInvis)
		SetWeaponOverlay(InvisMaterial, InvisTime, true);
	else if (HasUDamage())
		SetWeaponOverlay(UDamageWeaponMaterial, UDamageTime - Level.TimeSeconds, false);

	if(Weapon != none) // check fucking shit you shit fuckers of EPIC
	{
		if (bBerserk)
			Weapon.StartBerserk();
		else if ( Weapon.bBerserk )
			Weapon.StopBerserk();
	}

		if(bulletTimeInitiated && NewWeapon != none)
			startWeaponBulletTime(NewWeapon, true);
}

simulated event Attach(Actor Other)
{
	// hide attachements if invisible
	if(bInvis && (XMV850Pack(Other) != None || M75Pack(Other) != None || HVCMk9Pack(Other) != None || RX22ATank(Other) != None))
		Other.bHidden = true;
}

function ChangedWeapon()
{
	local BallisticWeapon bw;
	local BallistichandGrenade grenade;
	local BallisticWeapon.WeaponModeType LongThrowMode, AutoThrowMode, GrenadeChangeIndicator;
	local byte LongThrowID, AutoThrowID;
	local array<BallisticWeapon.WeaponModeType> GrenadeWeaponModes;
	local int i;

	Super.ChangedWeapon();

	if(Weapon != none)
		bw = BallisticWeapon(Weapon);

	if(bDisableCrosshairs && bw != none){
		if(bw.bOldCrosshairs)
			bw.bOldCrosshairs = false;
		bw.CustomCrosshair = 0;
		bw.bGlobalCrosshair = false;
		bw.CrosshairCfg.Pic1 = none;
		bw.crosshairCfg.Pic2 = none;
	}

	if(bSetGrenadeLongThrowDefault && bw != none && BallistichandGrenade(bw) != none)
	{
		LongThrowID = -1;
		AutoThrowID = -1;

		grenade = BallistichandGrenade(bw);
		if(grenade.WeaponModes.Length > 2 && grenade.WeaponModes[grenade.WeaponModes.length -1].ModeName != "C")
		{
			GrenadeWeaponModes = grenade.WeaponModes;
			for(i = 0; i < grenade.WeaponModes.length; i++)
			{
				if(grenade.WeaponModes[i].ModeName == "Long Throw")
				{
					LongThrowID = i;
					LongThrowMode = grenade.WeaponModes[i];
					break;
				}
			}
			if(LongThrowID != -1)
			{
				GrenadeWeaponModes.Remove(LongThrowID, 1);
				GrenadeWeaponModes.Insert(0, 1);
				GrenadeWeaponModes[0] = LongThrowMode;
			}
			grenade.WeaponModes = GrenadeWeaponModes;

			for(i = 0; i < grenade.WeaponModes.length; i++)
			{
				if(grenade.WeaponModes[i].ModeName == "Auto Throw")
				{
					AutoThrowID = i;
					AutoThrowMode = grenade.WeaponModes[i];
					break;
				}
			}
			if(AutoThrowID != -1)
			{
				GrenadeWeaponModes.Remove(AutoThrowID, 1);
				GrenadeWeaponModes.Insert(GrenadeWeaponModes.Length, 1);
				GrenadeWeaponModes[GrenadeWeaponModes.Length -1] = AutoThrowMode;
			}

			GrenadeChangeIndicator.bUnavailable = true;
			GrenadeChangeIndicator.ModeName = "C";

			GrenadeWeaponModes.Insert(GrenadeWeaponModes.Length, 1);
			GrenadeWeaponModes[GrenadeWeaponModes.Length -1] = GrenadeChangeIndicator;

			grenade.WeaponModes = GrenadeWeaponModes;
		}
	}

	if(bulletTimeInitiated && Weapon != none)
		startWeaponBulletTime(Weapon, true);
}
//=============================================================================
// WEAPON CHANGES
// ACHIEVEMENTS
//=============================================================================

simulated event StartDriving(Vehicle V)
{
	PrevPlayerController = PlayerController(Controller);
	Super.StartDriving(V);
}

simulated event StopDriving(Vehicle V)
{
	Super.StopDriving(V);
	bUpdateCrosshair = true; // update (remove) the crosshair when mounting the next time
}

//=============================================================================
// ACHIEVEMENTS
//=============================================================================
function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	local bool skipMessage;
	local CFBallisticPawn killerPawn;

	skipMessage = false;

	if(bAchievements)
	{
		// in case you fail because of lava volumes or you fly to high and fall too deep
		if(Killer == None)
		{
			ServerScoreSuicide(skipMessage);

		}
		if(Killer != none && Killer.Pawn != none  && (CFBallisticPawn(Killer.Pawn) != none || Vehicle(Killer.Pawn) != none))
		{
			// check whenver the killer pawn is in a vehicle or not
			if(Vehicle(Killer.Pawn) == None)
				killerPawn = CFBallisticPawn(Killer.Pawn);
		  	else
		  		killerPawn = CFBallisticPawn(Vehicle(Killer.Pawn).Driver);

			// suicide
			if(Killer == Controller)
			{
				ServerScoreSuicide(skipMessage);

				Super.Died(Killer, damageType, HitLocation);
				return;
			}

			// headshots
			if(damageType.ClassIsChildOf(damageType, class'BallisticV25.DT_BWBullet') && class<DT_BWBullet>(damageType).default.bHeaddie)
			{
				xPlayerReplicationInfo(Killer.PlayerReplicationInfo).headcount = 0;

				killerPawn.ServerScoreHeadshot();

				if(PlayerController(Killer) != none)
					PlayerController(Killer).ReceiveLocalizedMessage(class'XGame.SpecialKillMessage', 0, Killer.PlayerReplicationInfo, None, None);
			}

			// spawn kill
			if(bBirthControl)
			{
				// handling for birthcontrol message
				killerPawn.ServerScoreSpawnKill(killerPawn, self, skipMessage);

				// skip following messages but count
				skipMessage = true;
			}

			// knife kills
			if(damageType.ClassIsChildOf(damageType, class'BallisticV25.DT_BWBlade'))
				killerPawn.ServerScoreKnifeKill(killerPawn, self, skipMessage);

	  		// blunt kills
			else if(
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DT_BWBlunt') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTMRS138Tazer')
			)
				killerPawn.ServerScoreBluntKill(CFBallisticPawn(Killer.Pawn), self, skipMessage);

			// pyro kills
			else if(damageType.ClassIsChildOf(damageType, class'BallisticV25.DT_BWFire'))
				killerPawn.ServerScorePyroKill(killerPawn, self, skipMessage);

			// gas kills
			else if(damageType.ClassIsChildOf(damageType, class'BallisticV25.DTT10Gas'))
				killerPawn.ServerScoreGasKill(killerPawn, self, skipMessage);

			// mg kills
			else if(
			  damageType.ClassIsChildOf(damageType, class'BallisticV25.DTXMV850MG') ||
			  damageType.ClassIsChildOf(damageType, class'BallisticV25.DTXMV850MGHead') ||
			  damageType.ClassIsChildOf(damageType, class'BallisticV25.DTM925MG') ||
			  damageType.ClassIsChildOf(damageType, class'BallisticV25.DTM925MGHead') ||
			  damageType.ClassIsChildOf(damageType, class'BallisticV25.DTM353MG') ||
			  damageType.ClassIsChildOf(damageType, class'BallisticV25.DTM353MGHead')
			  )
				killerPawn.ServerScoreMGKill(killerPawn, self, skipMessage);

			// Sniper Rifle
			else if(
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTR78Rifle') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTR78RifleHead') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTM75Railgun') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTM75RailgunHead') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTR9Rifle') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTR9RifleHead') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTMarlinRifle') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTMarlinRifleHead')
			)
				killerPawn.ServerScoreSniperKill(killerPawn, self, skipMessage);

			// Revolver kills
			else if(
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTleMatRevolver') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTleMatrevolverHead') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTleMatShotgun') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTleMatShotgunHead') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTD49Revolver') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTD49RevolverHead')
			)
				killerPawn.ServerScoreRevKill(killerPawn, self, skipMessage);

			// grenade kills
			else if(
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTFP9BombRadius') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTFP9Bomb') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTNRP57RolledRadius') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTNRP57GrenadeRadius') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTNRP57Grenade') ||
				damageType.ClassIsChildOf(damageType, class'BallisticV25.DTNRP57Held')
			)
				killerPawn.ServerScoreGrenadeKill(killerPawn, self, skipMessage);
		}
		killBirthControlTimer();
	}
	Super.Died(Killer, damageType, HitLocation);
}

function killBirthControlTimer()
{
	SetTimer(0.0, false);
	bBirthControl = false;
}

function startBirthControlTimer(float timerRate)
{
	SetTimer(timerRate, true);
}


simulated function ScoreHeadshot(PlayerReplicationInfo formerOwner, PlayerReplicationInfo currentOwner)
{
	if(ServiceActor.iHeadshots <= 255 && Level.NetMode == NM_Client)
		ServiceActor.iHeadshots += 1;

		// our peak is high and we own the achievement
	// we draw the badge start effect only when we arent the former achievement owner
	if(lsa != none && ServiceActor.iHeadshots >= 3 && ServiceActor.iHeadshots >= lsa.headshotsPeak && currentOwner != none && currentOwner == ServiceActor.pri && (formerOwner == none || formerOwner != ServiceActor.pri))
	{
		BadgeStarEffectExpireTime[5] = Level.TimeSeconds + 0.9;
	}
}

function ServerScoreHeadshot()
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iHeadshots <= 255)
		ServiceActor.iHeadshots += 1;

	if(lsa != none && ServiceActor.iHeadshots > lsa.headshotsPeak)
	{
		lsa.headshotsPeak = ServiceActor.iHeadshots;

		// we are the new owner of the achievement, old owner goes into former
		if(lsa.hsCurrent != none)
			lsa.hsFormer = lsa.hsCurrent;

		if(ServiceActor.iHeadshots >= 3)
			lsa.hsCurrent = ServiceActor.pri; // we are the current achievement owner
	}

	ScoreHeadshot(lsa.hsFormer, lsa.hsCurrent);
}


function ServerScoreSuicide(bool skipMessage)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iSuicides <= 255)
		ServiceActor.iSuicides += 1;

	if(!skipMessage && ServiceActor.iSuicides <= 20)
	{
		if(class'CFMasochistMessageBC'.default.KillString[Min(ServiceActor.iSuicides-1,19)] != "")
		{
			if(Controller != none)
				Level.Game.BroadcastLocalized(Controller, class'CFMasochistMessageBC',ServiceActor.iSuicides, Controller.PlayerReplicationInfo, none, none);
		}
	}

	// client stuff
	ScoreSuicide(skipMessage);
}

simulated function ScoreSuicide(bool skipMessage)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iSuicides <= 255 && Level.NetMode == NM_Client)
		ServiceActor.iSuicides += 1;

	if(!skipMessage && ServiceActor.iSuicides <= 20)
	{
		if(PlayerController(Controller) != none && IsLocallyControlled())
			PlayerController(Controller).ReceiveLocalizedMessage(class'CFMasochistMessage', ServiceActor.iSuicides, Controller.PlayerReplicationInfo, none, none);
	}
}

function ServerScoreKnifeKill(CFBallisticPawn k, CFBallisticPawn s, bool skipMessage)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iKnifeKills <= 255)
		ServiceActor.iKnifeKills += 1;

	if(lsa != none && ServiceActor.iKnifeKills > lsa.knifeKillsPeak)
	{
		lsa.knifeKillsPeak = ServiceActor.iKnifeKills;

		// we are the new owner of the achievement, old owner goes into former
		if(lsa.knifeCurrent != none)
			lsa.knifeFormer = lsa.knifeCurrent;

		lsa.knifeCurrent = ServiceActor.pri; // we are the current achievement owner
	}

	if(!skipMessage && ServiceActor.iKnifeKills <= 15)
	{
		if(class'CFHrDoctorMessageBC'.default.KillString[Min(ServiceActor.iKnifeKills-1,14)] != "")
		{
			if(Controller != none)
				Level.Game.BroadcastLocalized(Controller, class'CFHrDoctorMessageBC',ServiceActor.iKnifeKills, k.PlayerReplicationInfo, s.PlayerReplicationInfo, none);
		}
	}

	ScoreKnifeKill(skipMessage, lsa.knifeFormer, lsa.knifeCurrent);
}

simulated function ScoreKnifeKill(bool skipMessage, PlayerReplicationInfo formerOwner, PlayerReplicationInfo currentOwner)
{
	if(ServiceActor.iKnifeKills <= 255 && Level.NetMode == NM_Client)
		ServiceActor.iKnifeKills += 1;

	// our peak is high and we own the achievement
	// we draw the badge start effect only when we arent the former achievement owner
	if(lsa != none && ServiceActor.iKnifeKills >= lsa.knifeKillsPeak && currentOwner != none && currentOwner == ServiceActor.pri && (formerOwner == none || formerOwner != ServiceActor.pri))
	{
		BadgeStarEffectExpireTime[6] = Level.TimeSeconds + 0.9;
	}

	if(!skipMessage && ServiceActor.iKnifeKills <= 15)
	{
		if(PlayerController(Controller) != none && IsLocallyControlled())
			PlayerController(Controller).ReceiveLocalizedMessage(class'CFHrDoctorMessage', ServiceActor.iKnifeKills, Controller.PlayerReplicationInfo, none, none);
	}
}

function ServerScoreSniperKill(CFBallisticPawn k, CFBallisticPawn s, bool skipMessage)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iSniperKills <= 255)
		ServiceActor.iSniperKills += 1;

	if(lsa != none && ServiceActor.iSniperKills > lsa.SniperPeak)
	{
		lsa.SniperPeak = ServiceActor.iSniperKills;

		// we are the new owner of the achievement, old owner goes into former
		if(lsa.sniperCurrent != none)
			lsa.sniperFormer = lsa.sniperCurrent;

		if(ServiceActor.iSniperKills >= 5)
			lsa.sniperCurrent = ServiceActor.pri; // we are the current achievement owner
	}

	if(!skipMessage && ServiceActor.iSniperKills <= 15)
	{
//		if(class'CFHrDoctorMessageBC'.default.KillString[Min(ServiceActor.iKnifeKills-1,14)] != "")
//		{
//			if(Controller != none)
//				Level.Game.BroadcastLocalized(Controller, class'CFHrDoctorMessageBC',ServiceActor.iKnifeKills, k.PlayerReplicationInfo, s.PlayerReplicationInfo, none);
//		}
	}

		// client stuff
	ScoreSniperKill(skipMessage, lsa.sniperFormer, lsa.sniperCurrent);
}

simulated function ScoreSniperKill(bool skipMessage, PlayerReplicationInfo formerOwner, PlayerReplicationInfo currentOwner)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iSniperKills <= 255 && Level.NetMode == NM_Client)
		ServiceActor.iSniperKills += 1;

	// our peak is high and we own the achievement
	// we draw the badge start effect only when we arent the former achievement owner
	if(lsa != none && ServiceActor.iSniperKills >= 5 && ServiceActor.iSniperKills >= lsa.SniperPeak && currentOwner != none && currentOwner == ServiceActor.pri && (formerOwner == none || formerOwner != ServiceActor.pri))
	{
		BadgeStarEffectExpireTime[2] = Level.TimeSeconds + 0.9;
	}

	if(!skipMessage && ServiceActor.iSniperKills <= 15)
	{
//		if(PlayerController(Controller) != none && IsLocallyControlled())
//			PlayerController(Controller).ReceiveLocalizedMessage(class'CFHrDoctorMessage', ServiceActor.iKnifeKills, Controller.PlayerReplicationInfo, none, none);
	}
}

function ServerScoreSpawnKill(CFBallisticPawn k, CFBallisticPawn s, bool skipMessage)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iSpawnKills <= 255)
		ServiceActor.iSpawnKills += 1;

	if(lsa != none && ServiceActor.iSpawnKills > lsa.spawnKillsPeak)
	{
		lsa.spawnKillsPeak = ServiceActor.iSpawnKills;

		// we are the new owner of the achievement, old owner goes into former
		if(lsa.spawnCurrent != none)
			lsa.spawnFormer = lsa.spawnCurrent;

		lsa.spawnCurrent = ServiceActor.pri; // we are the current achievement owner
	}

	if(!skipMessage && ServiceActor.iSpawnKills <= 15)
	{
		if(class'CFHrDoctorMessageBC'.default.KillString[Min(ServiceActor.iSpawnKills-1,14)] != "")
		{
			if(Controller != none)
				Level.Game.BroadcastLocalized(Controller, class'CFSpawnKillMessageBC',ServiceActor.iSpawnKills, k.PlayerReplicationInfo, s.PlayerReplicationInfo, none);
		}
	}

	ScoreSpawnKill(skipMessage, lsa.spawnFormer, lsa.spawnCurrent);
}

simulated function ScoreSpawnKill(bool skipMessage, PlayerReplicationInfo formerOwner, PlayerReplicationInfo currentOwner)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iSpawnKills <= 255 && Level.NetMode == NM_Client)
		ServiceActor.iSpawnKills += 1;

	// our peak is high and we own the achievement
	// we draw the badge start effect only when we arent the former achievement owner
	if(lsa != none && ServiceActor.iSpawnKills >= lsa.spawnKillsPeak && currentOwner != none && currentOwner == ServiceActor.pri && (formerOwner == none || formerOwner != ServiceActor.pri))
	{
		BadgeStarEffectExpireTime[4] = Level.TimeSeconds + 0.9;
	}

	if(!skipMessage && ServiceActor.iSpawnKills <= 15)
	{
		if(PlayerController(Controller) != none && IsLocallyControlled())
			PlayerController(Controller).ReceiveLocalizedMessage(class'CFSpawnKillMessage', ServiceActor.iSpawnKills, Controller.PlayerReplicationInfo, none, none);
	}
}

function ServerScoreBluntKill(CFBallisticPawn k, CFBallisticPawn s, bool skipMessage)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iBluntKills <= 255)
		ServiceActor.iBluntKills += 1;

	if(lsa != none && ServiceActor.iBluntKills > lsa.bluntKillsPeak)
	{
		lsa.bluntKillsPeak = ServiceActor.iBluntKills;

		// we are the new owner of the achievement, old owner goes into former
		if(lsa.bluntCurrent != none)
			lsa.bluntFormer = lsa.bluntCurrent;

		lsa.bluntCurrent = ServiceActor.pri; // we are the current achievement owner
	}

	if(!skipMessage && ServiceActor.iBluntKills <= 15)
	{
		if(class'CFBluntMessageBC'.default.KillString[Min(ServiceActor.iBluntKills-1,14)] != "")
		{
			if(Controller != none)
				Level.Game.BroadcastLocalized(Controller, class'CFBluntMessageBC',ServiceActor.iBluntKills, k.PlayerReplicationInfo, s.PlayerReplicationInfo, none);
		}
	}

	ScoreBluntKill(skipMessage, lsa.bluntFormer, lsa.bluntCurrent);
}

simulated function ScoreBluntKill(bool skipMessage, PlayerReplicationInfo formerOwner, PlayerReplicationInfo currentOwner)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iBluntKills <= 255 && Level.NetMode == NM_Client)
		ServiceActor.iBluntKills += 1;

		// our peak is high and we own the achievement
	// we draw the badge start effect only when we arent the former achievement owner
	if(lsa != none && ServiceActor.iBluntKills >= lsa.bluntKillsPeak && currentOwner != none && currentOwner == ServiceActor.pri && (formerOwner == none || formerOwner != ServiceActor.pri))
	{
		BadgeStarEffectExpireTime[7] = Level.TimeSeconds + 0.9;
	}

	if(!skipMessage && ServiceActor.iBluntKills <= 15)
	{
		if(PlayerController(Controller) != none && IsLocallyControlled())
			PlayerController(Controller).ReceiveLocalizedMessage(class'CFBluntMessage', ServiceActor.iBluntKills, Controller.PlayerReplicationInfo, none, none);
	}
}

function ServerScoreMGKill(CFBallisticPawn k, CFBallisticPawn s, bool skipMessage)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iMGKills <= 255)
		ServiceActor.iMGKills += 1;

	if(lsa != none && ServiceActor.iMGKills > lsa.mgKillsPeak)
	{
		lsa.mgKillsPeak = ServiceActor.iMGKills;

		// we are the new owner of the achievement, old owner goes into former
		if(lsa.mgCurrent != none)
			lsa.mgFormer = lsa.mgCurrent;

		if(ServiceActor.iMGKills >= 5)
			lsa.mgCurrent = ServiceActor.pri; // we are the current achievement owner
	}

	if(!skipMessage && ServiceActor.iMGKills <= 20)
	{
		if(class'CFMGMessageBC'.default.KillString[Min(ServiceActor.iMGKills-1,19)] != "")
		{
			if(Controller != none)
				Level.Game.BroadcastLocalized(Controller, class'CFMGMessageBC',ServiceActor.iMGKills, k.PlayerReplicationInfo, s.PlayerReplicationInfo, none);
		}
	}

	ScoreMGKill(skipMessage, lsa.mgFormer, lsa.mgCurrent);
}

simulated function ScoreMGKill(bool skipMessage, PlayerReplicationInfo formerOwner, PlayerReplicationInfo currentOwner)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iMGKills <= 255 && Level.NetMode == NM_Client)
		ServiceActor.iMGKills += 1;

	// our peak is high and we own the achievement
	// we draw the badge start effect only when we arent the former achievement owner
	if(lsa != none && ServiceActor.iMGKills >= 5 && ServiceActor.iMGKills >= lsa.mgKillsPeak && currentOwner != none && currentOwner == ServiceActor.pri && (formerOwner == none || formerOwner != ServiceActor.pri))
	{
		BadgeStarEffectExpireTime[1] = Level.TimeSeconds + 0.9;
	}

	if(!skipMessage && ServiceActor.iMGKills <= 20)
	{
		if(PlayerController(Controller) != none && IsLocallyControlled())
			PlayerController(Controller).ReceiveLocalizedMessage(class'CFMGMessage', ServiceActor.iMGKills, Controller.PlayerReplicationInfo, none, none);
	}
}

function ServerScoreRevKill(CFBallisticPawn k, CFBallisticPawn s, bool skipMessage)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iRevolver <= 255)
		ServiceActor.iRevolver += 1;

	if(lsa != none && ServiceActor.iRevolver > lsa.revolverPeak)
	{
		lsa.revolverPeak = ServiceActor.iRevolver;

		// we are the new owner of the achievement, old owner goes into former
		if(lsa.revCurrent != none)
			lsa.revFormer = lsa.revCurrent;
		if(ServiceActor.iRevolver >= 5)
			lsa.revCurrent = ServiceActor.pri; // we are the current achievement owner
	}

	if(!skipMessage && ServiceActor.iRevolver <= 20)
	{
//		if(class'CFMGMessageBC'.default.KillString[Min(ServiceActor.iMGKills-1,19)] != "")
//		{
//			if(Controller != none)
//				Level.Game.BroadcastLocalized(Controller, class'CFMGMessageBC',ServiceActor.iMGKills, k.PlayerReplicationInfo, s.PlayerReplicationInfo, none);
//		}
	}

	// client stuff
	ScoreRevKill(skipMessage, lsa.revFormer, lsa.revCurrent);
}

simulated function ScoreRevKill(bool skipMessage, PlayerReplicationInfo formerOwner, PlayerReplicationInfo currentOwner)
{
	if(ServiceActor.iRevolver <= 255 && Level.NetMode == NM_Client)
		ServiceActor.iRevolver += 1;

	// our peak is high and we own the achievement
	// we draw the badge start effect only when we arent the former achievement owner
	if(lsa != none && ServiceActor.iRevolver >= 5 && ServiceActor.iRevolver >= lsa.revolverPeak && currentOwner != none && currentOwner == ServiceActor.pri && (formerOwner == none || formerOwner != ServiceActor.pri))
	{
		BadgeStarEffectExpireTime[0] = Level.TimeSeconds + 0.9;
	}

	if(!skipMessage && ServiceActor.iRevolver <= 20)
	{
//		if(PlayerController(Controller) != none && IsLocallyControlled())
//			PlayerController(Controller).ReceiveLocalizedMessage(class'CFMGMessage', ServiceActor.iMGKills, Controller.PlayerReplicationInfo, none, none);
	}
}

function ServerScoreGrenadeKill(CFBallisticPawn k, CFBallisticPawn s, bool skipMessage)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iGrenadeKills <= 255)
		ServiceActor.iGrenadeKills += 1;

	if(lsa != none && ServiceActor.iGrenadeKills > lsa.grenadeKillsPeak)
	{
		lsa.grenadeKillsPeak = ServiceActor.iGrenadeKills;

		// we are the new owner of the achievement, old owner goes into former
		if(lsa.grenadeCurrent != none)
			lsa.grenadeFormer = lsa.grenadeCurrent;

		lsa.grenadeCurrent = ServiceActor.pri; // we are the current achievement owner
	}

	if(!skipMessage && ServiceActor.iGrenadeKills <= 15)
	{

		if(class'CFExplosiveMessageBC'.default.KillString[Min(ServiceActor.iGrenadeKills-1,14)] != "")
		{
			if(Controller != none)
				Level.Game.BroadcastLocalized(Controller, class'CFExplosiveMessageBC',ServiceActor.iGrenadeKills, k.PlayerReplicationInfo, s.PlayerReplicationInfo, none);
		}
	}
	ScoreGrenadeKill(skipMessage, lsa.grenadeFormer, lsa.grenadeCurrent);
}

simulated function ScoreGrenadeKill(bool skipMessage, PlayerReplicationInfo formerOwner, PlayerReplicationInfo currentOwner)
{
	if(ServiceActor == none)
			return;

	if(ServiceActor.iGrenadeKills <= 255 && Level.NetMode == NM_Client)
		ServiceActor.iGrenadeKills += 1;

	// our peak is high and we own the achievement
	// we draw the badge start effect only when we arent the former achievement owner
	if(lsa != none && ServiceActor.iGrenadeKills >= lsa.grenadeKillsPeak && currentOwner != none && currentOwner == ServiceActor.pri && (formerOwner == none || formerOwner != ServiceActor.pri))
	{
		BadgeStarEffectExpireTime[3] = Level.TimeSeconds + 0.9;
	}

	if(!skipMessage && ServiceActor.iGrenadeKills <= 15)
	{
		if(PlayerController(Controller) != none)
			PlayerController(Controller).ReceiveLocalizedMessage(class'CFExplosiveMessage', ServiceActor.iGrenadeKills, Controller.PlayerReplicationInfo, none, none);
	}
}

simulated function ScorePyroKill(bool skipMessage, PlayerReplicationInfo formerOwner, PlayerReplicationInfo currentOwner)
{
	if(ServiceActor == none)
			return;

	if(ServiceActor.iPyro <= 255 && Level.NetMode == NM_Client)
		ServiceActor.iPyro += 1;

	// our peak is high and we own the achievement
	// we draw the badge start effect only when we arent the former achievement owner
	if(lsa != none && ServiceActor.iPyro >= 5 && ServiceActor.iPyro >= lsa.pyroPeak && currentOwner != none && currentOwner == ServiceActor.pri && (formerOwner == none || formerOwner != ServiceActor.pri))
	{
		BadgeStarEffectExpireTime[8] = Level.TimeSeconds + 0.9;
	}

	if(!skipMessage && ServiceActor.iPyro <= 15)
	{
//		if(PlayerController(Controller) != none)
//			PlayerController(Controller).ReceiveLocalizedMessage(class'CFExplosiveMessage', ServiceActor.iGrenadeKills, Controller.PlayerReplicationInfo, none, none);
	}
}

function ServerScorePyroKill(CFBallisticPawn k, CFBallisticPawn s, bool skipMessage)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iPyro <= 255)
		ServiceActor.iPyro += 1;

	if(lsa != none && ServiceActor.iPyro > lsa.pyroPeak)
	{
		lsa.pyroPeak = ServiceActor.iPyro;
		// we are the new owner of the achievement, old owner goes into former
		if(lsa.pyroCurrent != none)
			lsa.pyroFormer = lsa.pyroCurrent;

		if(ServiceActor.iPyro >= 5)
			lsa.pyroCurrent = ServiceActor.pri; // we are the current achievement owner
	}

	if(!skipMessage && ServiceActor.iPyro <= 15)
	{

//		if(class'CFExplosiveMessageBC'.default.KillString[Min(ServiceActor.iGrenadeKills-1,14)] != "")
//		{
//			if(Controller != none)
//				Level.Game.BroadcastLocalized(Controller, class'CFExplosiveMessageBC',ServiceActor.iGrenadeKills, k.PlayerReplicationInfo, s.PlayerReplicationInfo, none);
//		}
	}

	ScorePyroKill(skipMessage, lsa.pyroFormer, lsa.pyroCurrent);
}


simulated function ScoreGasKill(bool skipMessage, PlayerReplicationInfo formerOwner, PlayerReplicationInfo currentOwner)
{
	if(ServiceActor == none)
			return;

	if(ServiceActor.iGas <= 255 && Level.NetMode == NM_Client)
		ServiceActor.iGas += 1;

	// our peak is high and we own the achievement
	// we draw the badge start effect only when we arent the former achievement owner
	if(lsa != none && ServiceActor.iGas >= lsa.GasPeak && currentOwner != none && currentOwner == ServiceActor.pri && (formerOwner == none || formerOwner != ServiceActor.pri))
	{
		BadgeStarEffectExpireTime[9] = Level.TimeSeconds + 0.9;
	}

	if(!skipMessage && ServiceActor.iGas <= 15)
	{
//		if(PlayerController(Controller) != none)
//			PlayerController(Controller).ReceiveLocalizedMessage(class'CFExplosiveMessage', ServiceActor.iGrenadeKills, Controller.PlayerReplicationInfo, none, none);
	}
}

function ServerScoreGasKill(CFBallisticPawn k, CFBallisticPawn s, bool skipMessage)
{
	if(ServiceActor == none)
		return;

	if(ServiceActor.iGas <= 255)
		ServiceActor.iGas += 1;

	if(lsa != none && ServiceActor.iGas > lsa.GasPeak)
	{
		lsa.GasPeak = ServiceActor.iGas;
		// we are the new owner of the achievement, old owner goes into former
		if(lsa.gasCurrent != none)
			lsa.gasFormer = lsa.gasCurrent;

		lsa.gasCurrent = ServiceActor.pri; // we are the current achievement owner
	}

	if(!skipMessage && ServiceActor.iGas <= 15)
	{

//		if(class'CFExplosiveMessageBC'.default.KillString[Min(ServiceActor.iGrenadeKills-1,14)] != "")
//		{
//			if(Controller != none)
//				Level.Game.BroadcastLocalized(Controller, class'CFExplosiveMessageBC',ServiceActor.iGrenadeKills, k.PlayerReplicationInfo, s.PlayerReplicationInfo, none);
//		}
	}

	ScoreGasKill(skipMessage, lsa.gasFormer, lsa.gasCurrent);
}
//=============================================================================
// ACHIEVEMENTS
//=============================================================================

function PlayDyingSound()
{
	local float pitch;

	if(lsa.bulletTime)
		pitch = 0.4;
	else
		pitch = 1;

	// Dont play dying sound if a skeleton. Tricky without vocal chords.
	if ( bSkeletized )
		return;

	/*
		if ( bGibbed )
		{
			PlaySound(GibGroupClass.static.GibSound(), SLOT_Pain,clamp(3.5*TransientSoundVolume*dieSoundAmplifier, 3.5*TransientSoundVolume, 255),true,500*dieSoundRangeAmplifier);
			return;
		}
	*/

	if( bNeckBroken )
	{
		if(SoundGroupClass == class'xBotSoundGroup')
		{
			PlaySound(Sound'CFMutatorSnd.DamageType.NeckBrokenRobot', SLOT_Pain,clamp(3.5*TransientSoundVolume*dieSoundAmplifier, 2.5*TransientSoundVolume, 255),true,500*dieSoundRangeAmplifier);
		}else
		{
			PlaySound(Sound'CFMutatorSnd.DamageType.NeckBrokenHuman', SLOT_Pain,clamp(3.5*TransientSoundVolume*dieSoundAmplifier, 2.5*TransientSoundVolume, 255),true,500*dieSoundRangeAmplifier);
		}
  		return;
	}

	if ( HeadVolume.bWaterVolume )
	{
		PlaySound(GetSound(EST_Drown), SLOT_Pain,clamp(2.5*TransientSoundVolume*dieSoundAmplifier, 2.5*TransientSoundVolume, 255),true,500*dieSoundRangeAmplifier, pitch);
		return;
	}
	PlaySound(SoundGroupClass.static.GetDeathSound(), SLOT_Pain,clamp(2.5*TransientSoundVolume*dieSoundAmplifier, 2.5*TransientSoundVolume, 255), true,500*dieSoundRangeAmplifier, pitch);
}

function PlayTakeHit(vector HitLocation, int Damage, class<DamageType> DamageType)
{
	local float pitch;

	if(lsa.bulletTime)
		pitch = 0.4;
	else
		pitch = 1;

	PlayDirectionalHit(HitLocation);


	if( Level.TimeSeconds - LastPainSound < MinTimeBetweenPainSounds )
		return;

	LastPainSound = Level.TimeSeconds;
	if( HeadVolume.bWaterVolume )
	{
		if( DamageType.IsA('Drowned') )
			PlaySound( GetSound(EST_Drown), SLOT_Pain,clamp(hitSoundAmplifier*1.5*TransientSoundVolume, 1.5*TransientSoundVolume, 255) );
		else
			PlaySound( GetSound(EST_HitUnderwater), SLOT_Pain,clamp(hitSoundAmplifier*1.5*TransientSoundVolume, 1.5*TransientSoundVolume, 255) );
		return;
	}

	PlaySound(SoundGroupClass.static.GetHitSound(), SLOT_Pain,clamp(hitSoundAmplifier*2.0*TransientSoundVolume, 2*TransientSoundVolume, 255),,200*hitSoundRangeAmplifier, pitch);
}

singular event BaseChange()
{
	local float decorMass;

	if ( bInterpolating )
		return;
	if ( (base == None) && (Physics == PHYS_None) )
		SetPhysics(PHYS_Falling);
	// Pawns can only set base to non-pawns, or pawns which specifically allow it.
	// Otherwise we do some damage and jump off.
	else if ( Pawn(Base) != None && Base != DrivenVehicle )
	{
		if ( !Pawn(Base).bCanBeBaseForPawns )
		{
			// in case we deal enough damage, we break the neck
			if(bNeckBreak && Pawn(Base).Health <= ((1-Velocity.Z/400)* Mass/Base.Mass)*jumpDamageAmplifier)
			{
				Base.TakeDamage( (1-Velocity.Z/400)* Mass/Base.Mass *jumpDamageAmplifier, Self,Location,0.5 * Velocity , class'CFDTNeckBreak');
			}
			else
			{
				Base.TakeDamage( (1-Velocity.Z/400)* Mass/Base.Mass *jumpDamageAmplifier, Self,Location,0.5 * Velocity , class'Crushed');
			}
			JumpOffPawn();
		}
	}
	else if ( (Decoration(Base) != None) && (Velocity.Z < -400) )
	{
		decorMass = FMax(Decoration(Base).Mass, 1);
		Base.TakeDamage((-2* Mass/decorMass * Velocity.Z/400), Self, Location, 0.5 * Velocity, class'Crushed');
	}
}

function bool AddShieldStrength(int ShieldAmount)
{
	local BallisticArmor BA;
	local int OldShieldStrength;

	BA = BallisticArmor(FindInventoryType(class'BallisticArmor'));
	if (BA != None)
	{
		OldShieldStrength = BA.Charge;
		BA.Charge = Clamp(BA.Charge + ShieldAmount,0, ShieldStrengthMax);
		BA.SetShieldDisplay(BA.Charge);
	}
	else
	{
		BA = spawn(class'CFBallisticArmor',self);
		BA.Charge = ShieldAmount;
		BA.GiveTo (self, none);
	}
	if (BA == None)
		return super(xPawn).AddShieldStrength(ShieldAmount);

	return (BA.Charge != OldShieldStrength);
}

simulated function TickFX(float DeltaTime)
{
	local int i,NumSkins;
	local Actor pack;
	local RX22ATank tank;

	if(bInvis && !bOldInvis) // Going invisible
	{
		if ( Left(string(Skins[0]),21) ~= "UT2004PlayerSkins.Xan" )
			Skins[2] = Material(DynamicLoadObject("UT2004PlayerSkins.XanMk3V2_abdomen", class'Material'));

		// Hack for Agent Smith model fail materials
		if ( Left(string(Skins[0]),20) ~= "smithskins.smithbody" )
		{
			Skins[2] = Material(DynamicLoadObject("smithskins.shadeenviro", class'Material'));
			Skins[3] = Material(DynamicLoadObject("smithskins.smithhead_shader", class'Material'));
			Skins[4] = Material(DynamicLoadObject("smithskins.smithshoe_shader", class'Material'));
		}

		// Save the 'real' non-invis skin
		NumSkins = Clamp(Skins.Length,2,10);

		for ( i=0; i<NumSkins; i++ )
		{
			RealSkinsExt[i] = Skins[i];
			Skins[i] = InvisMaterial;
		}

		// Remove/disallow projectors on invisible people
		Projectors.Remove(0, Projectors.Length);
		bAcceptsProjectors = false;

		// Invisible - no shadow
		if(PlayerShadow != None)
			PlayerShadow.bShadowActive = false;

		// No giveaway flames either
		RemoveFlamingEffects();

		// railgun, minigun attachements
		for (i=0;i<Attached.length;i++)
		{
			if (XMV850Pack(Attached[i]) != None || M75Pack(Attached[i]) != None || HVCMk9Pack(Attached[i]) != None)
			{
				pack = Attached[i];
				pack.bHidden = true;
				break;
			}
		}

		foreach BasedActors(class'RX22ATank', tank)
		{
			tank.bHidden = true;
			break;
		}
	}
	else if(!bInvis && bOldInvis) // Going visible
	{
		NumSkins = Clamp(Skins.Length,2,10);

		for ( i=0; i<NumSkins; i++ )
			Skins[i] = RealSkinsExt[i];

		bAcceptsProjectors = Default.bAcceptsProjectors;

		if(PlayerShadow != None)
			PlayerShadow.bShadowActive = true;

		// railgun, minigun attachements
		for (i=0;i<Attached.length;i++)
		{
			if (XMV850Pack(Attached[i]) != None || M75Pack(Attached[i]) != None || HVCMk9Pack(Attached[i]) != None || RX22ATank(Attached[i]) != None)
			{
				pack = Attached[i];
				pack.bHidden = false;
				break;
			}
		}
		foreach BasedActors(class'RX22ATank', tank)
		{
			tank.bHidden = false;
		}
	}

	bOldInvis = bInvis;

	bDrawCorona = ( !bNoCoronas && !bInvis && (Level.NetMode != NM_DedicatedServer)	&& !bPlayedDeath && (Level.GRI != None) && Level.GRI.bAllowPlayerLights
					&& (PlayerReplicationInfo != None) );

	if ( bDrawCorona && (PlayerReplicationInfo.Team != None) )
	{
		if ( PlayerReplicationInfo.Team.TeamIndex == 0 )
			Texture = Texture'RedMarker_t';
		else
			Texture = Texture'BlueMarker_t';
	}
}

simulated function PlayDying(class<DamageType> DamageType, vector HitLoc)
{
	if (bNeckBreak && DamageType != None && DamageType == class'CFMutator.CFDTNeckBreak')
	{
		bNeckBroken = true;
	}

	if(lsa.bulletTime && bulletTimeInitiated)
	{
		bulletTimeInitiated = false;

		if(Controller != none && CFBallisticPlayer(Controller) != none)
		{
			if(Level.NetMode != NM_ListenServer)
				PlaySound(Sound'CFMutatorSnd.BulletTime.bt_end', SLOT_MISC, 2.0, true);
			else if(Level.NetMode != NM_Client)
				CFBallisticPlayer(Controller).PlayBulletTimeSound(false);
		}
	}

	Super.PlayDying(DamageType, HitLoc);
}

function PlayDyingAnimation(class<DamageType> DamageType, vector HitLoc)
{
	local vector shotDir, hitLocRel, deathAngVel, shotStrength;
	local float maxDim;
	local string RagSkelName;
	local KarmaParamsSkel skelParams;
	local bool PlayersRagdoll;
	local PlayerController pc;

	if ( Level.NetMode != NM_DedicatedServer )
	{
		// Is this the local player's ragdoll?
		if(OldController != None)
			pc = PlayerController(OldController);
		if( pc != None && pc.ViewTarget == self )
			PlayersRagdoll = true;

		// In low physics detail, if we were not just controlling this pawn,
		// and it has not been rendered in 3 seconds, just destroy it.
		if( (Level.PhysicsDetailLevel != PDL_High) && !PlayersRagdoll && (Level.TimeSeconds - LastRenderTime > 3) )
		{
			Destroy();
			return;
		}

		// Try and obtain a rag-doll setup. Use optional 'override' one out of player record first, then use the species one.
		if( RagdollOverride != "")
			RagSkelName = RagdollOverride;
		else if(Species != None)
			RagSkelName = Species.static.GetRagSkelName( GetMeshName() );
		else
			Log("xPawn.PlayDying: No Species");

		// If we managed to find a name, try and make a rag-doll slot availbale.
		if( RagSkelName != "" )
		{
			KMakeRagdollAvailable();
		}

		if( KIsRagdollAvailable() && RagSkelName != "" )
		{
			skelParams = KarmaParamsSkel(KParams);
			skelParams.KSkeleton = RagSkelName;

			// Stop animation playing.
			StopAnimating(true);

			if( DamageType != None )
			{
				if ( DamageType.default.bLeaveBodyEffect )
					// TearOffMomentum = vect(0,0,0);

				if( DamageType.default.bKUseOwnDeathVel )
				{
					RagDeathVel = DamageType.default.KDeathVel;
					RagDeathUpKick = DamageType.default.KDeathUpKick;
				}
			}

			// Set the dude moving in direction he was shot in general
			shotDir = Normal(TearOffMomentum);
			shotStrength = RagDeathVel * shotDir;

			// Calculate angular velocity to impart, based on shot location.
			hitLocRel = TakeHitLocation - Location;

			// We scale the hit location out sideways a bit, to get more spin around Z.
			hitLocRel.X *= RagSpinScale;
			hitLocRel.Y *= RagSpinScale;

			// If the tear off momentum was very small for some reason, make up some angular velocity for the pawn
			if( VSize(TearOffMomentum) < 0.01 )
			{
				//Log("TearOffMomentum magnitude of Zero");
				deathAngVel = VRand() * 18000.0;
			}
			else
			{
				deathAngVel = RagInvInertia * (hitLocRel Cross shotStrength);
			}

			// Set initial angular and linear velocity for ragdoll.
			// Scale horizontal velocity for characters - they run really fast!
			if ( DamageType.Default.bRubbery )
				skelParams.KStartLinVel = vect(0,0,0);
			if ( Damagetype.default.bKUseTearOffMomentum )
			{
				if(DamageType.ClassIsChildOf(DamageType, class'BallisticV25.DT_BWShell'))
					skelParams.KStartLinVel = (TearOffMomentum + Velocity) * 6; // TODO ADD SETTING
				else if(ClassIsChildOf(DamageType, class'BallisticV25.DTD49Revolver') || ClassIsChildOf(DamageType, class'BallisticV25.DTD49RevolverHead'))
					skelParams.KStartLinVel = (TearOffMomentum + Velocity) * 1.75; // TODO ADD SETTING
				else
					skelParams.KStartLinVel = (TearOffMomentum + Velocity) * 1.5;
			}
			else
			{
				skelParams.KStartLinVel.X = 0.6 * Velocity.X;
				skelParams.KStartLinVel.Y = 0.6 * Velocity.Y;
				skelParams.KStartLinVel.Z = 1.0 * Velocity.Z;
					skelParams.KStartLinVel += shotStrength;
			}
			// If not moving downwards - give extra upward kick
			if( !DamageType.default.bLeaveBodyEffect && !DamageType.Default.bRubbery && (Velocity.Z > -10) )
				skelParams.KStartLinVel.Z += RagDeathUpKick * 3;

			if ( DamageType.Default.bRubbery )
			{
				Velocity = vect(0,0,0);
				skelParams.KStartAngVel = vect(0,0,0);
			}
			else
			{
				skelParams.KStartAngVel = deathAngVel;

				// Set up deferred shot-bone impulse
				maxDim = Max(CollisionRadius, CollisionHeight);

				skelParams.KShotStart = TakeHitLocation - (1 * shotDir);
				skelParams.KShotEnd = TakeHitLocation + (2*maxDim*shotDir);
				skelParams.KShotStrength = RagShootStrength;
			}

			// If this damage type causes convulsions, turn them on here.
			if(DamageType != None && DamageType.default.bCauseConvulsions)
			{
				RagConvulseMaterial=DamageType.default.DamageOverlayMaterial;
				skelParams.bKDoConvulsions = true;
		    }

			// Turn on Karma collision for ragdoll.
			KSetBlockKarma(true);

			// Set physics mode to ragdoll.
			// This doesn't actaully start it straight away, it's deferred to the first tick.
			SetPhysics(PHYS_KarmaRagdoll);

			// If viewing this ragdoll, set the flag to indicate that it is 'important'
			if( PlayersRagdoll )
				skelParams.bKImportantRagdoll = true;

			skelParams.bRubbery = DamageType.Default.bRubbery;
			bRubbery = DamageType.Default.bRubbery;

			skelParams.KActorGravScale = RagGravScale;

			return;
		}
		// jag
	}

	// non-ragdoll death fallback
	Velocity += TearOffMomentum;
	BaseEyeHeight = Default.BaseEyeHeight;
	SetTwistLook(0, 0);
	SetInvisibility(0.0);
	PlayDirectionalDeath(HitLoc);
	SetPhysics(PHYS_Falling);
}

simulated function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType)
{
	if(damageType == class'Fell')
	{
		super.TakeDamage( Damage * 10, InstigatedBy, Hitlocation, Momentum, damageType);
	}
	else
		super.TakeDamage( Damage, InstigatedBy, Hitlocation, Momentum, damageType);
}

function EnableUDamageAdrenalined()
{
	UDamageTime = Level.GRI.TimeLimit*60;
	LightType = LT_Steady;
	bDynamicLight = true;
	SetWeaponOverlay(UDamageWeaponMaterial, Level.GRI.TimeLimit*60 , false);
}

//=============================================================================
// BULLET TIME STUFF
//=============================================================================
simulated function initiateBulletTime(bool bBulletTimeInitiator)
{
	local int i;
	local Inventory Inv;

	// used in switch weapon stuff, switched weapons shall also be modified. Thought, kinda stupid to switch guns in bullet time, but who knows who play :|
	//bulletTimeInitiated = bBulletTimeInitiator;


	if(bBulletTimeInitiator)
	{
		bulletTimeInitiated = true;
		Level.GRI.WeaponBerserk = 10;
		startWeaponBulletTime(Weapon, true);

		// account for robo sounds
		if(SoundGroupClass == class'xBotSoundGroup' && Controller != none && CFBallisticPlayer(Controller) != none)
		{
			CFBallisticPlayer(Controller).HeartBeat=Sound'CFMutatorSnd.BulletTime.bt_heartcyber';
		}
	}else
	{
		// revert back the weaponberserk to original values
		Level.GRI.WeaponBerserk = 1.0;

		// we change now the default properties of the changed gun classes back
  		for(i = 0; i < bulletTimedGunsDefaulsOriginal.Length; i++)
	 	{
			restoreGunClassDefaultProperties(bulletTimedGunsDefaulsOriginal[i].weaponClass, i);
		}
		bulletTimedGunsDefaulsOriginal.remove(0, bulletTimedGunsDefaulsOriginal.length);

		for(i = 0; i < bulletTimedGuns.Length; i++)
	 	{
	 		// we need to find the weapon in our inventory and change it there. It appears that changing the weapon in the array direct has no effect.

			for( Inv=Inventory; Inv!=None; Inv=Inv.Inventory )
			{
				if ( Inv == bulletTimedGuns[i] )
					stopWeaponBulletTime(Weapon(Inv), i);
			}
		}

		// empty the arrays for the next usage
		bulletTimedGuns.Remove(0, bulletTimedGuns.Length);
		bulletTimedGunsOriginal.remove(0, bulletTimedGunsOriginal.Length);
	}
}

simulated function serverInitiateBulletTime(bool bBulletTimeInitiator, float normalSpeed)
{
	local int i;
	local Inventory Inv;

	// used in switch weapon stuff, switched weapons shall also be modified. Thought, kinda stupid to switch guns in bullet time, but who knows who play :|
	//bulletTimeInitiated = bBulletTimeInitiator;

	if(bBulletTimeInitiator)
	{
		bulletTimeInitiated = true;
		lsa.bulletTime = true;
		startWeaponBulletTime(Weapon, true);
	}
	else
	{
		lsa.stopBulletTime(normalSpeed);
		Level.GRI.WeaponBerserk = 1.0;

		// we change now the default properties of the changed gun classes back
  		for(i = 0; i < bulletTimedGunsDefaulsOriginal.Length; i++)
	 	{
			restoreGunClassDefaultProperties(bulletTimedGunsDefaulsOriginal[i].weaponClass, i);
		}
		bulletTimedGunsDefaulsOriginal.remove(0, bulletTimedGunsDefaulsOriginal.length);

		for(i = 0; i < bulletTimedGuns.Length; i++)
	 	{
	 		// we need to find the weapon in our inventory and change it there. It appears that changing the weapon in the array direct has no effect.

			for( Inv=Inventory; Inv!=None; Inv=Inv.Inventory )
			{
				if ( Inv == bulletTimedGuns[i] )
					stopWeaponBulletTime(Weapon(Inv), i);
			}
		}

		// empty the arrays for the next usage
		bulletTimedGuns.Remove(0, bulletTimedGuns.Length);
		bulletTimedGunsOriginal.remove(0, bulletTimedGunsOriginal.Length);
	}
}

simulated function startWeaponBulletTime(Weapon w, bool checkOther)
{
	local int i, l, dl;
	local bulletTimedGunsVars original;
	local bulletTimedGunsDefaultVars originalDefaults;
	local bool changeDefault;

	changeDefault = true;

	l = bulletTimedGuns.Length;
	dl = bulletTimedGunsDefaulsOriginal.Length;

 	for(i =0; i < l; i++)
 	{
 		if(bulletTimedGuns[i] == w)
 		{
 			return;
		}
	}

	// we check if our class is already in the array of defaults, if so, we can skip any changes of the default properties,
	// but still need to change the instance properties
 	if(BulletTimedGunClassAlreadyListed(String(w.Class)))
 		changeDefault = false;
	else
		originalDefaults.weaponClass = String(w.Class);

	w.CheckSuperBerserk();

	original.IdleAnimRate = w.default.IdleAnimRate;
	w.IdleAnimRate = w.IdleAnimRate * Level.GRI.WeaponBerserk;

	original.RestAnimRate = w.default.RestAnimRate;
	w.RestAnimRate = w.RestAnimRate * Level.GRI.WeaponBerserk;

	original.AimAnimRate = w.default.AimAnimRate;
	w.AimAnimRate = w.AimAnimRate * Level.GRI.WeaponBerserk;

	original.RunAnimRate = w.default.RunAnimRate;
	w.RunAnimRate = w.RunAnimRate * Level.GRI.WeaponBerserk;

	original.SelectAnimRate = w.default.SelectAnimRate;
	w.SelectAnimRate = w.SelectAnimRate * Level.GRI.WeaponBerserk;

 	original.PutDownAnimRate = w.default.PutDownAnimRate;
	w.PutDownAnimRate = w.PutDownAnimRate * Level.GRI.WeaponBerserk;

	original.PutDownTime = w.default.PutDownTime;
	w.PutDownTime = w.PutDownTime / Level.GRI.WeaponBerserk;

	original.BringUpTime = w.default.BringUpTime;
	w.BringUpTime = w.BringUpTime / Level.GRI.WeaponBerserk;

	original.DownDelay = w.default.DownDelay;
	w.DownDelay = w.DownDelay / Level.GRI.WeaponBerserk;

	if(BallisticWeapon(w) != none)
	{
		original.CockAnimRate = BallisticWeapon(w).default.CockAnimRate;
		BallisticWeapon(w).CockAnimRate = BallisticWeapon(w).CockAnimRate * Level.GRI.WeaponBerserk;

		original.ReloadAnimRate = BallisticWeapon(w).default.ReloadAnimRate;
		BallisticWeapon(w).ReloadAnimRate = BallisticWeapon(w).ReloadAnimRate * Level.GRI.WeaponBerserk;

		original.StartShovelAnimRate = BallisticWeapon(w).default.CockAnimRate;
		BallisticWeapon(w).StartShovelAnimRate = BallisticWeapon(w).CockAnimRate * Level.GRI.WeaponBerserk;

		original.EndShovelAnimRate = BallisticWeapon(w).default.CockAnimRate;
		BallisticWeapon(w).EndShovelAnimRate = BallisticWeapon(w).CockAnimRate * Level.GRI.WeaponBerserk;

		original.SightingTime = BallisticWeapon(Weapon).default.SightingTime;
		BallisticWeapon(w).SightingTime = BallisticWeapon(w).SightingTime / Level.GRI.WeaponBerserk;

		if(changeDefault)
		{
			originalDefaults.defaultSightingTime = BallisticWeapon(w).default.SightingTime;
			BallisticWeapon(w).default.SightingTime = BallisticWeapon(w).default.SightingTime / Level.GRI.WeaponBerserk;
		}

		original.RecoilDeclineDelay = BallisticWeapon(w).default.RecoilDeclineDelay;
		BallisticWeapon(w).RecoilDeclineDelay = BallisticWeapon(w).RecoilDeclineDelay / Level.GRI.WeaponBerserk;

		if(BallisticWeapon(w).BFireMode[0] != none)
		{
			original.BFireModeOneTweenTime = BallisticWeapon(w).BFireMode[0].TweenTime;
			BallisticWeapon(w).BFireMode[0].TweenTime = BallisticWeapon(w).BFireMode[0].TweenTime / Level.GRI.WeaponBerserk;

			original.BFireModeOneFireEndAnimRate = BallisticWeapon(w).BFireMode[0].FireEndAnimRate;
			BallisticWeapon(w).BFireMode[0].FireEndAnimRate = BallisticWeapon(w).BFireMode[0].FireEndAnimRate * Level.GRI.WeaponBerserk;
		}

		if(BallisticWeapon(w).BFireMode[1] != none)
		{
			original.BFireModeTwoFireEndAnimRate = BallisticWeapon(w).BFireMode[1].FireEndAnimRate;
			BallisticWeapon(w).BFireMode[1].FireEndAnimRate = BallisticWeapon(w).BFireMode[1].FireEndAnimRate * Level.GRI.WeaponBerserk;

			original.BFireModeTwoTweenTime = BallisticWeapon(w).BFireMode[1].TweenTime;
			BallisticWeapon(w).BFireMode[1].TweenTime = BallisticWeapon(w).BFireMode[1].TweenTime / Level.GRI.WeaponBerserk;
		}

		original.IdleTweenTime = BallisticWeapon(w).default.IdleTweenTime;
		BallisticWeapon(w).IdleTweenTime = BallisticWeapon(w).IdleTweenTime / Level.GRI.WeaponBerserk;

		if(BallisticHandgun(w) != none && BallisticHandgun(w).OtherGun != none && checkOther)
		{
			startWeaponBulletTime(BallisticHandgun(w).OtherGun, false);
		}
	}

	bulletTimedGunsOriginal.insert(l, 1); // here we put the original gun properties
	bulletTimedGunsOriginal[l] = original;

	bulletTimedGuns.Insert(l, 1);  // and here we put the guns itself
 	bulletTimedGuns[l] = w;

	// we add the bullet time gun class, later we need to iterate over this array and change the defaults back. This accounts for a problem when instigator throws a changed weapon
	// or dies during the bullet time
	if(changeDefault)
  	{
		  bulletTimedGunsDefaulsOriginal.Insert(dl, 1); // here we put the original gun class default properties
		  bulletTimedGunsDefaulsOriginal[dl] = originalDefaults;
  	}
}

simulated function stopWeaponBulletTime(Weapon w, int i)
{
	w.StopBerserk();

	w.IdleAnimRate = bulletTimedGunsOriginal[i].IdleAnimRate;
	w.RestAnimRate = bulletTimedGunsOriginal[i].RestAnimRate;
	w.AimAnimRate =  bulletTimedGunsOriginal[i].AimAnimRate;
	w.RunAnimRate =  bulletTimedGunsOriginal[i].RunAnimRate;
	w.SelectAnimRate = bulletTimedGunsOriginal[i].SelectAnimRate;
	w.PutDownAnimRate = bulletTimedGunsOriginal[i].PutDownAnimRate;
	w.PutDownTime = bulletTimedGunsOriginal[i].PutDownTime;
	w.BringUpTime = bulletTimedGunsOriginal[i].BringUpTime;
	w.DownDelay = bulletTimedGunsOriginal[i].DownDelay;

	if(BallisticWeapon(w) != none)
	{
		BallisticWeapon(w).CockAnimRate = bulletTimedGunsOriginal[i].CockAnimRate;
		BallisticWeapon(w).ReloadAnimRate = bulletTimedGunsOriginal[i].ReloadAnimRate;
		BallisticWeapon(w).StartShovelAnimRate = bulletTimedGunsOriginal[i].StartShovelAnimRate;
		BallisticWeapon(w).EndShovelAnimRate = bulletTimedGunsOriginal[i].EndShovelAnimRate;

		BallisticWeapon(w).SightingTime = bulletTimedGunsOriginal[i].SightingTime;
		BallisticWeapon(w).RecoilDeclineDelay = bulletTimedGunsOriginal[i].RecoilDeclineDelay;

		if(BallisticWeapon(w).BFireMode[0] != none)
		{
			BallisticWeapon(w).BFireMode[0].TweenTime = bulletTimedGunsOriginal[i].BFireModeOneTweenTime;
			BallisticWeapon(w).BFireMode[0].FireEndAnimRate = bulletTimedGunsOriginal[i].BFireModeOneFireEndAnimRate;
		}

		if(BallisticWeapon(w).BFireMode[1] != none)
		{
			BallisticWeapon(w).BFireMode[1].TweenTime = bulletTimedGunsOriginal[i].BFireModeTwoTweenTime;
			BallisticWeapon(w).BFireMode[1].FireEndAnimRate = bulletTimedGunsOriginal[i].BFireModeTwoFireEndAnimRate;
		}

		BallisticWeapon(w).IdleTweenTime = bulletTimedGunsOriginal[i].IdleTweenTime;
	}

	// this class will have the default properties changed and can be removed from the final iteration afterwards
	restoreGunClassInstanceDefaultProperties(w, getGunClassDefaultPropertiesIndex(String(w.Class)));
	// TODO remove from list
}

// function which checks if the gunclass is already in the array
simulated function bool BulletTimedGunClassAlreadyListed(string c)
{
	local int i;

	for(i =0; i < bulletTimedGunsDefaulsOriginal.length; i++)
		 if(bulletTimedGunsDefaulsOriginal[i].weaponClass ~= c)
			return true;

	return false;
}

simulated function int getGunClassDefaultPropertiesIndex(string c)
{
	local int i;

	for(i =0; i < bulletTimedGunsDefaulsOriginal.Length; i++)
		if(bulletTimedGunsDefaulsOriginal[i].weaponClass ~= c)
			return i;

	return -1;
}

// this function restores the guns class default properties
// it will spawn the weapon to change the default properties
simulated function restoreGunClassDefaultProperties(string strName, int i)
{
	local class<weapon> wcl;
	local weapon w;

	wcl = class<weapon>(DynamicLoadObject(strName,class'Class'));

	w = Spawn(wcl);

	restoreGunClassInstanceDefaultProperties(w, i);
	w.Destroy();

}

// this function restores the guns class default properties
simulated function restoreGunClassInstanceDefaultProperties(Weapon w, int i)
{
	local int position, x;

	if(i == -1)
		position = getGunClassDefaultPropertiesIndex(String(w.Class));
	else
		position = i;

	if(position != -1)
	{
		// we can change now the default properties
		if(BallisticWeapon(w) != none)
		{
			BallisticWeapon(w).default.SightingTime = bulletTimedGunsDefaulsOriginal[x].defaultSightingTime;
		}
	}
}

// toss out a weapon
function TossWeapon(Vector TossVel)
{
	local bool skipToss;

	skipToss = false;

	if(RX22AFlamer(Weapon) != none && Weapon.ThirdPersonActor != none && RX22AAttachment(Weapon.ThirdPersonActor).GasTank.GoneOff())
		skipToss = true;

	if(!lsa.bulletTime && !skipToss)
	{
		Super.TossWeapon(TossVel);
		}
}

//=============================================================================
// BULLET TIME STUFF
//=============================================================================


simulated function StartPickupAnimation(Pickup pick)
{
	local Weapon newWeapon;
	local CF_PickupMeshCache.PickupMeshInfo pmi;
	local int iSuccess;

	pmi = class'CF_PickupMeshCache'.static.AutoWeaponInfo(string(pick.InventoryType), iSuccess);

	if(iSuccess != -1)
	{
		switch(pmi.AnimNo)
		{
			case 1:
				newWeapon = self.spawn(class'CFMutator.CFGrabHandGrab',,,self.Location);
			break;

			case 2:
				newWeapon = self.spawn(class'CFMutator.CFGrabHandGrabAlt',,,self.Location);
			break;

			case 3:
				newWeapon = self.spawn(class'CFMutator.CFGrabHandAction',,,self.Location);
			break;

			case 4:
				newWeapon = self.spawn(class'CFMutator.CFGrabHandPistol',,,self.Location);
			break;

			case 5:
				newWeapon = self.spawn(class'CFMutator.CFGrabHandPistolAlt',,,self.Location);
			break;

			case 6:
				newWeapon = self.spawn(class'CFMutator.CFGrabHandGrenade',,,self.Location);
			break;

			case 7:
				newWeapon = self.spawn(class'CFMutator.CFGrabHandGrenadeAlt',,,self.Location);
			break;

			case 8:
				newWeapon = self.spawn(class'CFMutator.CFGrabHandKnife',,,self.Location);
			break;

			case 9:
				newWeapon = self.spawn(class'CFMutator.CFGrabHandKnifeAlt',,,self.Location);
			break;
		}

		originalViewRotation = GetViewRotation();


		CFGrabHand(newWeapon).originalViewRotation = originalViewRotation;
		CFGrabHand(newWeapon).pmi = pmi;
		CFGrabHand(newWeapon).pick = pick;
		CFGrabHand(newWeapon).InventoryType = pick.InventoryType;
		CFGrabHand(newWeapon).pickupAmmo = class<BallisticWeapon>(pick.InventoryType).default.MagAmmo;
		CFGrabhand(newWeapon).ItemName = class<BallisticWeapon>(pick.InventoryType).default.ItemName;
		CFGrabhand(newWeapon).SpawnMesh();

		newWeapon.GiveTo(self);

		self.PendingWeapon = newWeapon;
		self.ChangedWeapon();

  		lockedViewRotation = Rotator(Normal(pick.Location - (Location + EyePosition())));
		SetViewRotation(lockedViewRotation);

		bLockedView = true;
		bSpecialCalcView = true;
		bMovable = false;
	}
}

function bool SpecialCalcView(out Actor ViewActor, out vector CameraLocation, out rotator CameraRotation)
{
	//local vector newTargetLocation;

	ViewActor = self;
	CameraLocation = Location + EyePosition(); // wont change over time
/*
	Lerp(alpha, a, b); // alpha must represend the Time left. Point A and B are known and wont change. We are only interested in the returning float to modify the axis of our moving view target.
	// the view target moves from point B to point A

	// starting time is the time we pressed 'e'
	// ending time is 0.275 second after that happened
	// when time passes, the alpha needs to pass too but we dont know the FPS so we need to make it independent of that
 	// starting time - current level time = time that has passed
	// now that we know the time passed, we need to to translate the time passed to the alpha value
	// if 0.1 second passed by and the time is 1 second, then the alpha is 0.9

	// starting time = 1
	// starting time + end time = 0
	// current time passed = 0.02346

	// 0.275 second   |    100 %
	// 0.000024	  |	   X %

	// X % of 1 = deduction value
	// alhpa - deduction value

	lockedViewRotation = Rotator(Normal(newTargetLocation - (Location + EyePosition()))); // the newTargetLocation is the moving Location. Its the point where we look at.
*/

	CameraRotation = lockedViewRotation;
	return true;
}

simulated function rotator GetViewRotation()
{
	if(bLockedView)
		return lockedViewRotation;
	else
		return Super.GetViewRotation();
}

function HandlePickup(Pickup pick)
{
	MakeNoise(0.2);

	// only if no bot
 	if(bAnimatedPickups && IsHumanControlled())
 	{
		StartPickupAnimation(pick);
	}

	if ( Controller != None && BallisticWeaponPickup(pick) != none)
		Controller.HandlePickup(pick);
}

simulated function EquipPickUp(class<Inventory> InvType)
{
	local Inventory Inv;
	local Weapon newWeapon;

	newWeapon = Weapon;

	for( Inv=Inventory; Inv!=None; Inv=Inv.Inventory )
	{
		if(BallisticWeapon(Inv) != none && Inv.Class == InvType)
		{
			newWeapon = BallisticWeapon(Inv);
			break;
		}
	}

	if(newWeapon != none)
	{
		self.PendingWeapon = newWeapon;
		self.ChangedWeapon();
	}
}

/*
(11:18:46 PM) Logan Richert: You'll need to store the original when you first start interpolating.
(11:18:52 PM) Paul "Grum" Haack: ok
(11:19:01 PM) Logan Richert: Then use that as point A
(11:19:08 PM) Logan Richert: Now you just need to work out a good 0-1 value based on time.
(11:19:15 PM) Logan Richert: To use for the Alpha
(11:19:21 PM) Paul "Grum" Haack: a float betwene 0 and 1
(11:19:22 PM) Paul "Grum" Haack: ok
(11:19:27 PM) Paul "Grum" Haack: and then i interpolate between start
(11:19:30 PM) Paul "Grum" Haack: and end of last time
(11:19:49 PM) Paul "Grum" Haack: until i reach alpha 1 yes ?
(11:19:49 PM) Logan Richert: Yep.
(11:20:11 PM) Paul "Grum" Haack: so i devide 1 by the amount of time
(11:20:19 PM) Paul "Grum" Haack: and this is my interval
(11:20:34 PM) Paul "Grum" Haack: sounds reasonable and good
*/


// Then vector B will be original view location + MoveCloserDistancs * normal(view rotation)

defaultproperties
{
     bUpdateCrosshair=True
     bBirthControl=True
     ASniper=Texture'CFMutatorTex.Badges.Sniper'
     AExplosives=Texture'CFMutatorTex.Badges.Explosives'
     AGas=Texture'CFMutatorTex.Badges.Gas'
     AMelee=Texture'CFMutatorTex.Badges.Melee'
     AMG=Texture'CFMutatorTex.Badges.MG'
     APyro=Texture'CFMutatorTex.Badges.Pyro'
     ARevolver=Texture'CFMutatorTex.Badges.Revolver'
     ABlunt=Texture'CFMutatorTex.Badges.Blunt'
     AHead=Texture'CFMutatorTex.Badges.Headshot'
     ASpawn=Texture'CFMutatorTex.Badges.SpawnRaid'
     ASniperG=Texture'CFMutatorTex.Badges.SniperG'
     AExplosivesG=Texture'CFMutatorTex.Badges.ExplosivesG'
     AGasG=Texture'CFMutatorTex.Badges.GasG'
     AMeleeG=Texture'CFMutatorTex.Badges.MeleeG'
     AMGG=Texture'CFMutatorTex.Badges.MGG'
     APyroG=Texture'CFMutatorTex.Badges.PyroG'
     ARevolverG=Texture'CFMutatorTex.Badges.RevolverG'
     ABluntG=Texture'CFMutatorTex.Badges.BluntG'
     AHeadG=Texture'CFMutatorTex.Badges.HeadshotG'
     ASpawnG=Texture'CFMutatorTex.Badges.SpawnRaidG'
     ARevolverS=FinalBlend'CFMutatorTex.Badges.RevActFin'
     AHeadS=FinalBlend'CFMutatorTex.Badges.HeadActFinal'
     AMGS=FinalBlend'CFMutatorTex.Badges.MGActFin'
     ASniperS=FinalBlend'CFMutatorTex.Badges.SnipeActFin'
     AExplosivesS=FinalBlend'CFMutatorTex.Badges.ExplActFinal'
     ASpawnS=FinalBlend'CFMutatorTex.Badges.SpawnActFinal'
     AMeleeS=FinalBlend'CFMutatorTex.Badges.MeleeActFin'
     ABluntS=FinalBlend'CFMutatorTex.Badges.BluntActFinal'
     APyroS=FinalBlend'CFMutatorTex.Badges.PyroActFin'
     AGasS=FinalBlend'CFMutatorTex.Badges.GasActFinal'
     BulletTimeOverlay=FinalBlend'CFMutatorTex.BulletTime.BulletTimeFinal'
     bAnimatedPickups=True
}
