//=============================================================================
// CFClientMenuInterface.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFClientMenuInterface extends Actor;

//Replicated suck stuff
var bool bRemoveAmmoPacks; // ammo packs
var bool bRemoveUDamage; // damage amplifier
var bool bRemoveShieldPack; // small armor
var bool bRemoveSuperShieldPack; // big armor
var bool bRemoveBandages; // bandages
var bool bRemoveHealthPack; // health pack
var bool bRemoveSuperHealthPack; // super health pack
var bool bRemoveAdrenaline; // adrenaline
var bool bDisableCrosshairs; // disable crosshairs on clients
var bool bDisableTurretCrosshairs; // disable turret crosshairs on clients
var bool bSetGrenadeLongThrowDefault; // set "long throw" as default mode rather then "Atuo throw"
var bool bUsePickupAnimations; // Use the pickup animations to pickup items
var bool bSetBortFlareDefault;
var bool bDisableBortGrenade;
var bool bFixBort;
var int playerHealth;
var int playerHealthCap;
var int playerSuperHealthCap;
var int killRewardHealthpoints;
var int killRewardHealthcap;
var int iAdrenaline;
var int iAdrenalineCap;
var int killrewardArmor;
var int killrewardArmorCap;
var int ADRKill;
var int ADRMajorKill;
var int ADRMinorBonus;
var int ADRKillTeamMate;
var int ADRMinorError;
var bool bStrongerA73Melee;
var float dieSoundAmplifier;
var float dieSoundRangeAmplifier;
var float hitSoundAmplifier;
var float hitSoundRangeAmplifier;
var float jumpDamageAmplifier;
var bool bNeckBreak;
var float soulAmountAmplifier;
var int iArmor;
var int iArmorCap;
var bool bXMK5DartFix;
var bool bHAMRScopeFix;
var bool bOwnMineMarker;
var bool bA500Fix;
var bool improvedFP9;
var int flamePackHealth;

var bool bUseSprint;
var float InitStamina;				// Stamina level of player. Players can't sprint when this is out
var float InitMaxStamina;			// Max level of stamina
var float InitStaminaDrainRate;	// Amount of stamina lost each second when sprinting
var float InitStaminaChargeRate;	// Amount  of stamina gained each second when not sprinting
var float InitSpeedFactor;		// Player speed multiplied by this when sprinting
var float JumpDrainFactor;
var bool bAchievements;

var PlayerController PC;
var string currentMenu;
var bool bGRIAccessible;
var bool destroyTimer;
var bool deadlyMover;
var float spawnraidTimer;

var bool CFPickUps;
var bool bAnimatedPickups;

var Mut_CFMutators Mut;

replication
{
	reliable if (Role == ROLE_Authority)
	   PC, ClientOpenMenu, ClientReOpenMenu;
	reliable if (Role == ROLE_Authority)
		bRemoveAmmoPacks,bRemoveUDamage, bRemoveShieldPack, bRemoveSuperShieldPack, bRemoveBandages, bRemoveHealthPack,
	   bRemoveSuperHealthPack, bRemoveAdrenaline, bDisableCrosshairs, bDisableTurretCrosshairs, bSetGrenadeLongThrowDefault,
	   bUsePickupAnimations, bSetBortFlareDefault, bDisableBortGrenade, playerHealth, playerHealthCap, playerSuperHealthCap,
	   killRewardHealthpoints, killRewardHealthcap, iAdrenaline, iAdrenalineCap, ADRKill, ADRMajorKill, ADRMinorBonus, ADRKillTeamMate, ADRMinorError,
	   bStrongerA73Melee, dieSoundAmplifier, dieSoundRangeAmplifier, hitSoundAmplifier, hitSoundRangeAmplifier, jumpDamageAmplifier, bNeckBreak,
	   soulAmountAmplifier, iArmor, iArmorCap, killrewardArmor, killrewardArmorCap, bXMK5DartFix, bHAMRScopeFix, bOwnMineMarker, bA500Fix, bFixBort,
	   InitStamina, InitMaxStamina, InitStaminaDrainRate, InitStaminaChargeRate, InitSpeedFactor, JumpDrainFactor, bUseSprint,
	   bAchievements, deadlyMover, spawnraidTimer, CFPickUps, improvedFP9, flamePackHealth, bAnimatedPickups;
}

function InitInterface(PlayerController P, Mut_CFMutators cfMut)
{
	PC = P;
	Mut = cfMut;
}

simulated function Tick(float dT)
{
	if(PC != none && PC.GameReplicationInfo != none && !bGRIAccessible && PC.Player.GUIController != None && CFClientMenu(GUIController(PC.Player.GUIController).ActivePage) != None)
	{
		bGRIAccessible = true;
		CFClientMenu(GUIController(PC.Player.GUIController).ActivePage).GRIAccessible();
	}
}

simulated function ClientReOpenMenu(string menu)
{
	if (PC ==None || PC.Player == None)
	return;

	currentMenu = menu;

	OpenMenu();
	destroyTimer = true;
	SetTimer(1.0,true);
	if(PC != none && PC.GameReplicationInfo != none && PC.Player.GUIController != None && CFClientMenu(GUIController(PC.Player.GUIController).ActivePage) != None)
	{
		CFClientMenu(GUIController(PC.Player.GUIController).ActivePage).GRIAccessible();
	}
}

simulated function ClientOpenMenu(string menu, float delay)
{
	if (PC ==None || PC.Player == None)
	return;

	currentMenu = menu;
	if(delay == 0)
		OpenMenu();
	SetTimer(delay, false);
}

simulated event Timer()
{
	if(destroyTimer)
	{
		if (PC == None)
		  Destroy();

		return;
	}
	OpenMenu();
	destroyTimer = true;
	SetTimer(1.0,true);
}

simulated function OpenMenu()
{
	local UT2K4GUIPage dlg;

	if(PC != none)
		PC.PlaySound(Sound'BallisticSounds3.R78.R78-Fire',SLOT_MISC, 1.0,,,,);

	if (PC.Player.GUIController != None && UT2K4GUIPage(GUIController(PC.Player.GUIController).ActivePage) != None)
	{
		UT2K4GUIPage(GUIController(PC.Player.GUIController).ActivePage).Hide();
		dlg = UT2K4GUIPage(GUIController(PC.Player.GUIController).ActivePage);
	}

	PC.ClientOpenMenu(currentMenu);
	SetTimer(0, false);
	if (PC.Player.GUIController != None && CFClientMenu(GUIController(PC.Player.GUIController).ActivePage) != None)
	{
		CFClientMenu(GUIController(PC.Player.GUIController).ActivePage).MI = self;
		CFClientMenu(GUIController(PC.Player.GUIController).ActivePage).previPage = dlg;
		CFClientMenu(GUIController(PC.Player.GUIController).ActivePage).PC = PC;
	}
}

event Destroyed()
{
	local int i;

	for (i=0;i<Mut.MIPond.length;i++)
	{
		if (Mut.MIPond[i] == self)
		{
			Mut.MIPond.Remove(i, 1);
			break;
		}
	}

	super.Destroyed();
}

defaultproperties
{
     bHidden=True
     bOnlyRelevantToOwner=True
     bAlwaysRelevant=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
}
