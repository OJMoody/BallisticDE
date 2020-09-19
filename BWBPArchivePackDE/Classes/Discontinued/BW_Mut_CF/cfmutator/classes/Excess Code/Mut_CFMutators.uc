//=============================================================================
// Mut_CFMutators.
//
// Adds several options to modify Ballistic Weapons.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class Mut_CFMutators extends Mutator DependsOn(Mut_Ballistic) config(CrazyFroggers);

#exec OBJ LOAD File=CFMutatorSnd.uax
#exec OBJ LOAD File=CFMutatorTex.utx

var   Array<CFClientMenuInterface>		MIPond;
var   PlayerController					PCPendingMI;
var   Array<CFBCSprintControl> 			Sprinters;

var globalconfig bool bRemoveAmmoPacks; // ammo packs
var globalconfig bool bRemoveUDamage; // damage amplifier
var globalconfig bool bRemoveShieldPack; // small armor
var globalconfig bool bRemoveSuperShieldPack; // big armor
var globalconfig bool bRemoveBandages; // bandages
var globalconfig bool bRemoveHealthPack; // health pack
var globalconfig bool bRemoveSuperHealthPack; // super health pack
var globalconfig bool bRemoveAdrenaline; // adrenaline
var globalconfig bool bDisableCrosshairs; // disable crosshairs on clients
var globalconfig bool bDisableTurretCrosshairs; // disable turret crosshairs on clients
var globalconfig bool bSetGrenadeLongThrowDefault; // set "long throw" as default mode rather then "Atuo throw"
var globalconfig bool bUsePickupAnimations; // Use the pickup animations to pickup items
var globalconfig bool bSetBortFlareDefault;
var globalconfig bool bDisableBortGrenade;
var globalconfig bool bFixBort;
var globalconfig float soulAmountAmplifier;
var globalconfig bool improvedFP9;
var globalconfig int flamePackHealth;

var globalconfig int playerHealth;
var globalconfig int playerHealthCap;
var globalconfig int playerSuperHealthCap;
var globalconfig int killRewardHealthpoints;
var globalconfig int killRewardHealthcap;
var globalconfig int iAdrenaline;
var globalconfig int iAdrenalineCap;
var globalconfig int iArmor;
var globalconfig int iArmorCap;
var globalconfig int killrewardArmor;
var globalconfig int killrewardArmorCap;

var globalconfig int ADRKill;
var globalconfig int ADRMajorKill;
var globalconfig int ADRMinorBonus;
var globalconfig int ADRKillTeamMate;
var globalconfig int ADRMinorError;

var globalconfig float serverWelcomeMessageDelay;
var globalconfig bool bStrongerA73Melee;
var globalconfig bool bXMK5DartFix;
var globalconfig float dieSoundAmplifier;
var globalconfig float dieSoundRangeAmplifier;
var globalconfig float hitSoundAmplifier;
var globalconfig float hitSoundRangeAmplifier;
var globalconfig float jumpDamageAmplifier;
var globalconfig bool bNeckBreak;
var globalconfig bool bTeamMineMark;
var globalconfig bool bHAMRScopeFix;
var globalconfig bool bOwnMineMarker;
var globalconfig bool bA500Fix;
var globalconfig bool bAchievements;
var globalconfig bool deadlyMover;
var globalconfig float spawnraidTimer;

var globalconfig bool bUseSprint;
var globalconfig float		InitStamina;			// Stamina level of player. Players can't sprint when this is out
var globalconfig float		InitMaxStamina;			// Max level of stamina
var globalconfig float		InitStaminaDrainRate;	// Amount of stamina lost each second when sprinting
var globalconfig float		InitStaminaChargeRate;	// Amount  of stamina gained each second when not sprinting
var globalconfig float		InitSpeedFactor;		// Player speed multiplied by this when sprinting
var globalconfig float 		JumpDrainFactor;


var globalconfig bool 		CFPickUps;
var globalconfig bool		bAnimatedPickups;

var CFLocalClientServiceActor lsa;

struct PickupAnimationMapping
{
	var() config string PickupClass;
	var() config string AnimationClass;
};

var() array<PickupAnimationMapping> pickupAnimationMappings;

// bShowSplash
// SplashStartTime

function Mutate(string MutateString, PlayerController Sender)
{
	local int i;
	local CFBCSprintControl SC;

	if (bUseSprint && MutateString ~= "BStartSprint" && Sender != None)
	{
		SC = GetSprintControl(Sender);
		if (SC != None)
			SC.ServerStartSprint();
	}
	else if (bUseSprint && MutateString ~= "BStopSprint" && Sender != None)
	{
		SC = GetSprintControl(Sender);
		if (SC != None)
			SC.ServerStopSprint();
	}else if (MutateString ~= "CFServerDialog" && Sender != None)
	{
		for (i=0;i<MIPond.length;i++)
		{
			if (MIPond[i].PC == Sender)
			{
			    if (Sender.Player.GUIController != None && CFClientMenu(GUIController(Sender.Player.GUIController).ActivePage) != None)
				{
					CFClientMenu(GUIController(Sender.Player.GUIController).ActivePage).CloseMenu();
					return;
				}

				MIPond[i].ClientReOpenMenu("CFMutator.CFWelcomeMenu");
				return;

			}
		}
		MIPond[i] = Spawn(class'CFClientMenuInterface',Sender);
		MIPond[i].InitInterface(PCPendingMI, self);
	}else if(MutateString ~= "CFScoreboardMenu" && Sender != none)
	{
		// CFScoreboardMenu
		for (i=0;i<MIPond.length;i++)
		{
			if (MIPond[i].PC == Sender)
			{
			    if (Sender.Player.GUIController != None && CFClientMenu(GUIController(Sender.Player.GUIController).ActivePage) != None)
				{
					CFClientMenu(GUIController(Sender.Player.GUIController).ActivePage).CloseMenu();
					return;
				}

				MIPond[i].ClientReOpenMenu("CFMutator.CFScoreboardMenu");
				return;

			}
		}
		MIPond[i] = Spawn(class'CFClientMenuInterface',Sender);
		MIPond[i].InitInterface(PCPendingMI, self);
	}

	super.Mutate(MutateString, Sender);
}

simulated event Timer()
{
	super.Timer();
	if (PCPendingMI == None)
		return;
	MIPond[MIPond.length] = Spawn(class'CFClientMenuInterface',PCPendingMI);
	MIPond[MIPond.length-1].InitInterface(PCPendingMI, self);
	MIPond[MIPond.length-1].ClientOpenMenu("CFMutator.CFWelcomeMenu", serverWelcomeMessageDelay);

	MIPond[MIPond.length-1].bRemoveAmmoPacks = bRemoveAmmoPacks;
	MIPond[MIPond.length-1].bRemoveUDamage = bRemoveUDamage;
	MIPond[MIPond.length-1].bRemoveShieldPack = bRemoveShieldPack;
	MIPond[MIPond.length-1].bRemoveSuperShieldPack = bRemoveSuperShieldPack;
	MIPond[MIPond.length-1].bRemoveBandages = bRemoveBandages;
	MIPond[MIPond.length-1].bRemoveHealthPack = bRemoveHealthPack;
	MIPond[MIPond.length-1].bRemoveSuperHealthPack = bRemoveSuperHealthPack;
	MIPond[MIPond.length-1].bRemoveAdrenaline = bRemoveAdrenaline;
	MIPond[MIPond.length-1].bDisableCrosshairs = bDisableCrosshairs;
	MIPond[MIPond.length-1].bDisableTurretCrosshairs = bDisableTurretCrosshairs;
	MIPond[MIPond.length-1].bSetGrenadeLongThrowDefault = bSetGrenadeLongThrowDefault;
	MIPond[MIPond.length-1].bUsePickupAnimations = bUsePickupAnimations;
	MIPond[MIPond.length-1].bSetBortFlareDefault = bSetBortFlareDefault;
	MIPond[MIPond.length-1].bDisableBortGrenade = bDisableBortGrenade;
	MIPond[MIPond.Length-1].bFixBort = bFixBort;
	MIPond[MIPond.length-1].playerHealth = playerHealth;
	MIPond[MIPond.length-1].playerHealthCap = playerHealthCap;
	MIPond[MIPond.length-1].playerSuperHealthCap = playerSuperHealthCap;
	MIPond[MIPond.length-1].killRewardHealthpoints = killRewardHealthpoints;
	MIPond[MIPond.length-1].killRewardHealthcap = killRewardHealthcap;
	MIPond[MIPond.length-1].iAdrenaline = iAdrenaline;
	MIPond[MIPond.length-1].iAdrenalineCap = iAdrenalineCap;
	MIPond[MIPond.length-1].ADRKill = ADRKill;
	MIPond[MIPond.length-1].ADRMajorKill = ADRMajorKill;
	MIPond[MIPond.length-1].ADRMinorBonus = ADRMinorBonus;
	MIPond[MIPond.length-1].ADRKillTeamMate = ADRKillTeamMate;
	MIPond[MIPond.length-1].ADRMinorError = ADRMinorError;
	MIPond[MIPond.length-1].bStrongerA73Melee = bStrongerA73Melee;
	MIPond[MIPond.length-1].dieSoundAmplifier = dieSoundAmplifier;
	MIPond[MIPond.length-1].dieSoundRangeAmplifier = dieSoundRangeAmplifier;
	MIPond[MIPond.length-1].hitSoundAmplifier = hitSoundAmplifier;
	MIPond[MIPond.length-1].hitSoundRangeAmplifier = hitSoundRangeAmplifier;
	MIPond[MIPond.length-1].jumpDamageAmplifier = jumpDamageAmplifier;
	MIPond[MIPond.length-1].bNeckBreak = bNeckBreak;
	MIPond[MIPond.length-1].soulAmountAmplifier = soulAmountAmplifier;
	MIPond[MIPond.length-1].iArmor = iArmor;
	MIPond[MIPond.length-1].iArmorCap = iArmorCap;
	MIPond[MIPond.length-1].killrewardArmor = killrewardArmor;
	MIPond[MIPond.length-1].killrewardArmorCap = killrewardArmorCap;
	MIPond[MIPond.length-1].bXMK5DartFix = bXMK5DartFix;
	MIPond[MIPond.length-1].bHAMRScopeFix = bHAMRScopeFix;
	MIPond[MIPond.length-1].bOwnMineMarker = bOwnMineMarker;
	MIPond[MIPond.length-1].bA500Fix = bA500Fix;
	MIPond[MIPond.length-1].InitStamina = InitStamina;			// Stamina level of player. Players can't sprint when this is out
	MIPond[MIPond.length-1].InitMaxStamina = InitMaxStamina;			// Max level of stamina
	MIPond[MIPond.length-1].InitStaminaDrainRate = InitStaminaDrainRate;	// Amount of stamina lost each second when sprinting
	MIPond[MIPond.length-1].InitStaminaChargeRate = InitStaminaChargeRate;	// Amount  of stamina gained each second when not sprinting
	MIPond[MIPond.length-1].InitSpeedFactor = InitSpeedFactor;		// Player speed multiplied by this when sprinting
	MIPond[MIPond.length-1].JumpDrainFactor = JumpDrainFactor;
	MIPond[MIPond.Length-1].bUseSprint = bUseSprint;
	MIPond[MIPond.Length-1].bAchievements = bAchievements;
	MIPond[MIPond.Length-1].spawnraidTimer = spawnraidTimer;
	MIPond[MIPond.Length-1].improvedFP9 = improvedFP9;
	MIPond[MIPond.Length-1].flamePackHealth = flamePackHealth;
	MIPond[MIPond.Length-1].deadlyMover = deadlyMover;
	MIPond[MIPond.Length-1].CFPickUps = CFPickUps;

	PCPendingMI = None;
}

function PlayerChangedClass(Controller C)
{
	super.PlayerChangedClass (C);
	if (Bot(C) != None && (C.PawnClass	== None || C.PawnClass == class'xPawn' || C.PawnClass == class'BallisticV25.BallisticPawn'))
		Bot(C).PawnClass = class'CFMutator.CFBallisticPawn';
}

function CFClientServiceActor ServerGetClientServiceActor(Controller C)
{
	local int i;

	if(C != none)
	{
		for(i = 0; i < C.Attached.Length; ++i)
		{
			if(C.Attached[i].IsA('CFClientServiceActor'))
				return CFClientServiceActor(C.Attached[i]);
		}
	}

	return none;
}

function NotifyLogout(Controller C)
{
	local CFClientServiceActor sa;

	sa = ServerGetClientServiceActor(C);
	sa.Destroy();

	Super.NotifyLogout(C);
}

simulated function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local CFClientServiceActor sa;
	local BallisticWeapon bw;
	local BallisticWeapon.WeaponModeType BOGPChangeIndicator;
	local array<BallisticWeapon.WeaponModeType> BOGPWeaponModes;

	if (PlayerController(Other) != None && (Controller(Other).PawnClass == None || Controller(Other).PawnClass == class'xPawn' || Controller(Other).PawnClass == class'BallisticV25.BallisticPawn'))
	{
		PlayerController(Other).PawnClass = class'CFMutator.CFBallisticPawn';
	}
	else if (Bot(Other) != None && (Controller(Other).PawnClass == None || Controller(Other).PawnClass == class'xPawn' || Controller(Other).PawnClass == class'BallisticV25.BallisticPawn'))
		Bot(Other).PreviousPawnClass = class'CFMutator.CFBallisticPawn';

	if(Controller(Other) != none && ServerGetClientServiceActor(Controller(Other)) == none)
	{
  		sa = Controller(Other).spawn(class'CFClientServiceActor', Controller(Other));
  		sa.SetBase(Controller(Other));
	}

	if (PlayerController(Other) != None)
	{
		if (PCPendingMI != None)
			Timer();
		SetTimer(0.1, false);
		PCPendingMI = PlayerController(Other);
	}

	if (bRemoveAmmoPacks && Other.IsA('IP_AmmoPack')) // ammo packs
		return false;

	else if (bRemoveBandages && (Other.IsA('IP_Bandage') || Other.IsA('MiniHealthPack'))) // bandages
		return false;

	else if (bRemoveSuperShieldPack && (Other.IsA('IP_BigArmor') || Other.IsA('SuperShieldPack'))) // big armor
		return false;

	else if (bRemoveShieldPack && (Other.IsA('IP_SmallArmor') || Other.IsA('ShieldPack'))) // small armor
		return false;

	else if (bRemoveUDamage && (Other.IsA('IP_UDamage') || Other.IsA('UDamagePack'))) // damage amplifier
		return false;

	else if (bRemoveAdrenaline && (Other.IsA('AdrenalinePickup') || Other.IsA('IP_Adrenaline'))) // adrenaline
		return false;

	else if (bRemoveHealthPack && (Other.IsA('HealthPack') || Other.IsA('IP_HealthKit'))) // Health kit
		return false;

	else if (bRemoveSuperHealthPack && (Other.IsA('SuperHealthPack') || Other.IsA('IP_SuperHealthKit'))) // Super health kit
		return false;

	if(Other.IsA('BallisticArmorPickup'))
	{
		BallisticArmorPickup(Other).InventoryType = Class'CFMutator.CFBallisticArmor';
		return true;
	}

	if(Other != none && BallisticWeapon(Other) != none)
	{
		bw = BallisticWeapon(Other);

		if((bDisableBortGrenade || bSetBortFlareDefault) && BallisticHandgun(bw) != none)
		{
			if(BOGPPistol(bw) != none && bw.WeaponModes[bw.WeaponModes.length -1].ModeName != "C")
			{
				BOGPPistol(bw).bUseFlare = true;
				bw.CurrentWeaponMode = byte(BOGPPistol(bw).bUseFlare);

				BOGPWeaponModes = bw.WeaponModes;

				BOGPChangeIndicator.bUnavailable = true;
				BOGPChangeIndicator.ModeName = "C";

				BOGPWeaponModes.Insert(BOGPWeaponModes.length,1);
				BOGPWeaponModes[BOGPWeaponModes.length -1] = BOGPChangeIndicator;

				bw.WeaponModes = BOGPWeaponModes;

				if(bDisableBortGrenade && CFBOGPPistol(bw) != none)
					CFBOGPPistol(bw).bFlareOnly = true;
			}
		}
		else if (improvedFP9 && FP9Explosive(bw) != none)
		{
			FP9Explosive(bw).FireModeClass[0] = class'CFMutator.CFFP9PrimaryFire';
		}
	}else if(Other != none && RX22ATank(Other) != none)
	{
		RX22ATank(Other).Health = flamePackHealth;
	}

	return Super.CheckReplacement(Other, bSuperRelevant);
}

function PreBeginPlay()
{
	local Mutator mut;
	local Mover mover;

	for(mut = Level.Game.BaseMutator; mut != none; mut = mut.NextMutator)
	{
		if(mut != none)
		{
			if(Mut_Ballistic(mut) != none)
			{
				if(Mut_BallisticArena(mut) != none)
				{
				}else if(Mut_Outfitting(mut) != none)
				{
					if(bFixBort || bDisableBortGrenade)
						replaceLoadOutGroupItem(mut ,"BallisticV25.BOGPPistol", "CFMutator.CFBOGPPistol");

					if(bStrongerA73Melee)
					    replaceLoadOutGroupItem(mut,"BallisticV25.A73SkrithRifle", "CFMutator.CFA73SkrithRifle");

					if(bXMK5DartFix)
					    replaceLoadOutGroupItem(mut,"BallisticV25.XMK5SubMachinegun", "CFMutator.CFXMK5SubMachinegun");

					if(soulAmountAmplifier != 1)
					{
						replaceLoadOutGroupItem(mut,"BallisticV25.RSDarkStar", "CFMutator.CFRSDarkStar");
						replaceLoadOutGroupItem(mut,"BallisticV25.RSNovaStaff", "CFMutator.CFRSNovaStaff");
					}

					if(bHAMRScopeFix)
						replaceLoadOutGroupItem(mut, "BallisticV25.MACWeapon", "CFMutator.CFMACWeapon");

					if(bOwnMineMarker)
					{
						replaceLoadOutGroupItem(mut, "BallisticV25.BX5Mine", "CFMutator.CFBX5Mine");
						replaceLoadOutGroupItem(mut, "BallisticV25.M46AssaultRifle", "CFMutator.CFM46AssaultRifle");
					}

					if(bA500Fix)
						replaceLoadOutGroupItem(mut, "BallisticV25.A500Reptile", "CFMutator.CFA500Reptile");
				}else // We assume its just Mut_Ballistic
				{
					if(bFixBort || bDisableBortGrenade)
					{
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.BOGPPistol", "CFMutator.CFBOGPPistol");
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.BOGPPickup", "CFMutator.CFBOGPPickup");
					}
					if(bStrongerA73Melee)
					{
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.A73SkrithRifle", "CFMutator.CFA73SkrithRifle");
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.A73pickup", "CFMutator.CFA73pickup");
					}
					if(bXMK5DartFix)
					{
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.XMK5SubMachinegun", "CFMutator.CFXMK5SubMachinegun");
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.XMK5Pickup", "CFMutator.CFXMK5Pickup");
					}
					if(soulAmountAmplifier != 1)
					{
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.RSDarkStar", "CFMutator.CFRSDarkStar");
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.RSDarkPickup", "CFMutator.CFRSDarkPickup");
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.RSNovaStaff", "CFMutator.CFRSNovaStaff");
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.RSNovaPickup", "CFMutator.CFRSNovaPickup");
					}
					if(bHAMRScopeFix)
					{
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.MACWeapon", "CFMutator.CFMACWeapon");
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.MACPickup", "CFMutator.CFMACPickup");
					}
					if(bOwnMineMarker)
					{
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.BX5Mine", "CFMutator.CFBX5Mine");
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.MACPickup", "CFMutator.CFMACPickup");
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.M46AssaultRifle", "CFMutator.CFM46AssaultRifle");
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.M46Pickup", "CFMutator.CFM46Pickup");
					}
					if(bA500Fix)
					{
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.A500Reptile", "CFMutator.CFA500Reptile");
						Mut_Ballistic(mut).Replacements = ReplaceClassNameOnReplcamentList(Mut_Ballistic(mut).Replacements, "BallisticV25.A500Pickup", "CFMutator.CFA500Pickup");
					}
				}
			}
		}
	}

	if(deadlyMover)
	{
		foreach Level.AllActors(class'Mover', mover)
		{
			mover.MoverEncroachType = ME_CrushWhenEncroach;
		}
	}

	lsa = spawn(class'CFLocalClientServiceActor');

	Super.PreBeginPlay();
	if (level.Game != None)
	{
		Level.Game.DefaultPlayerClassName = "CFMutator.CFBallisticPawn"; // our own Pawn for various stuff
		Level.Game.PlayerControllerClassName = "CFMutator.CFBallisticPlayer";

	 	Level.Game.AddGameModifier(Spawn(class'CFMutator.Rules_KillRewards'));

	   if(DeathMatch(Level.Game) != none)
	   {
	       DeathMatch(Level.Game).ADR_Kill = ADRKill;
	       DeathMatch(Level.Game).ADR_MajorKill = ADRMajorKill;
	       DeathMatch(Level.Game).ADR_MinorBonus = ADRMinorBonus;
	       DeathMatch(Level.Game).ADR_KillTeamMate = ADRKillTeamMate;
	       DeathMatch(Level.Game).ADR_MinorError = ADRMinorError;
		}

		level.Game.AddMutator("CFMutator.Mut_CFCombos");

		if(CFPickUps)
			level.Game.AddMutator("CFMutator.Mut_CFPickups");
	}
}

function replaceLoadOutGroupItem(Mutator mut, string original, string replacement)
{
	Mut_Outfitting(mut).LoadoutGroup0 = ReplaceClassNameOnStringList(Mut_Outfitting(mut).LoadoutGroup0, original, replacement);
	Mut_Outfitting(mut).LoadoutGroup1 = ReplaceClassNameOnStringList(Mut_Outfitting(mut).LoadoutGroup1, original, replacement);
	Mut_Outfitting(mut).LoadoutGroup2 = ReplaceClassNameOnStringList(Mut_Outfitting(mut).LoadoutGroup2, original, replacement);
	Mut_Outfitting(mut).LoadoutGroup3 = ReplaceClassNameOnStringList(Mut_Outfitting(mut).LoadoutGroup3, original, replacement);
	Mut_Outfitting(mut).LoadoutGroup4 = ReplaceClassNameOnStringList(Mut_Outfitting(mut).LoadoutGroup4, original, replacement);
}

function array<string> ReplaceClassNameOnStringList(array<string> sourceList, string oldName, string newName)
{
	local int i;
	local array<string> rtnList;

	rtnList = sourceList;

	for(i = 0; i < sourceList.length; i++)
	{
		if(rtnList[i] ~= oldName)
		{
			rtnList[i] = newName;
		}
	}
	return rtnList;
}

function array<Mut_Ballistic.ItemSwitch> ReplaceClassNameOnReplcamentList(array<Mut_Ballistic.ItemSwitch> sourceList, string oldName, string newName)
{
	local int i;
	local array<Mut_Ballistic.ItemSwitch> rtnList;

	rtnList = sourceList;

	for(i = 0; i < sourceList.length; i++)
	{
		rtnList[i].NewItemNames = ReplaceClassNameOnStringList(rtnList[i].NewItemNames, oldName, newName);
	}
	return rtnList;
}

simulated function ModifyPlayer(Pawn Other)
{
	local CFBCSprintControl SC;
	local CFClientServiceActor sa;

	if(CFBallisticPawn(Other) != none && Other.Controller != none)
	{
		CFBallisticPawn(Other).bDisableCrosshairs = bDisableCrosshairs;
		CFBallisticPawn(Other).bDisableTurretCrosshairs = bDisableTurretCrosshairs;
		CFBallisticPawn(Other).bSetGrenadeLongThrowDefault = bSetGrenadeLongThrowDefault;
		if(Other.Controller.Adrenaline < iAdrenaline)
		{
		    Other.Controller.Adrenaline = iAdrenaline;
		    CFBallisticPawn(Other).iAdrenaline = iAdrenaline;
		}
		CFBallisticPawn(Other).iAdrenalineCap = iAdrenalineCap;
	    Other.Controller.AdrenalineMax = iAdrenalineCap;
	    CFBallisticPawn(Other).dieSoundAmplifier = dieSoundAmplifier;
	    CFBallisticPawn(Other).dieSoundRangeAmplifier = dieSoundRangeAmplifier;
	    CFBallisticPawn(Other).hitSoundAmplifier = hitSoundAmplifier;
	    CFBallisticPawn(Other).hitSoundRangeAmplifier = hitSoundRangeAmplifier;
	    CFBallisticPawn(Other).jumpDamageAmplifier = jumpDamageAmplifier;
		CFBallisticPawn(Other).bNeckBreak = bNeckBreak;
		CFBallisticPawn(Other).bAchievements = bAchievements;
		CFBallisticPawn(Other).ShieldStrengthMax = iArmorCap;
		CFBallisticPawn(Other).bAnimatedPickups = bAnimatedPickups;

		Other.HealthMax = playerHealthCap;
		Other.SuperHealthMax = playerSuperHealthCap;
		Other.Health = playerHealth;
		CFBallisticPawn(Other).AddShieldStrength(iArmor);
		sa = ServerGetClientServiceActor(Other.Controller);
		if(sa != none)
		{
			sa.pri = Other.Controller.PlayerReplicationInfo;
			CFBallisticPawn(Other).ServiceActor = sa;
		}

		if(CFBallisticPlayer(Other.Controller) != none)
		{
			CFBallisticPlayer(Other.Controller).lsa = lsa;
		}

		CFBallisticPawn(Other).lsa = lsa;

		if(bAchievements)
			CFBallisticPawn(Other).startBirthControlTimer(spawnraidTimer);
	}
	Super.ModifyPlayer(Other);

	if (bUseSprint && xPawn(Other) != none && GetSprintControl(PlayerController(Other.Controller)) == None)
	{
		SC = Spawn(class'CFBCSprintControl',Other);
		SC.InitStamina = InitStamina;
		SC.InitMaxStamina = InitMaxStamina;
		SC.InitStaminaDrainRate = InitStaminaDrainRate;
		SC.InitStaminaChargeRate = InitStaminaChargeRate;
		SC.InitSpeedFactor = InitSpeedFactor;
		SC.InitJumpDrainFactor = JumpDrainFactor;
		SC.GiveTo(Other);
		Sprinters[Sprinters.length] = SC;
	}
}

function CFBCSprintControl GetSprintControl(PlayerController Sender)
{
	local int i;

	for (i=0;i<Sprinters.length;i++)
		if (Sprinters[i] != None && Sprinters[i].Instigator != none && Sprinters[i].Instigator.Controller == Sender)
			return Sprinters[i];
	return None;
}

defaultproperties
{
     bFixBort=True
     soulAmountAmplifier=2.000000
     improvedFP9=True
     flamePackHealth=5
     playerHealth=100
     playerHealthCap=100
     playerSuperHealthCap=150
     killRewardHealthpoints=15
     iAdrenaline=50
     iAdrenalineCap=150
     iArmor=50
     iArmorCap=150
     killrewardArmor=5
     ADRKill=10
     ADRMajorKill=15
     ADRMinorBonus=5
     ADRMinorError=-5
     bXMK5DartFix=True
     dieSoundAmplifier=6.500000
     dieSoundRangeAmplifier=1.000000
     hitSoundAmplifier=8.000000
     hitSoundRangeAmplifier=1.000000
     jumpDamageAmplifier=40.000000
     bNeckBreak=True
     bHAMRScopeFix=True
     bA500Fix=True
     bAchievements=True
     deadlyMover=True
     spawnraidTimer=5.000000
     bUseSprint=True
     InitStamina=100.000000
     InitMaxStamina=100.000000
     InitStaminaDrainRate=10.000000
     InitStaminaChargeRate=7.000000
     InitSpeedFactor=1.350000
     JumpDrainFactor=2.000000
     CFPickUps=True
     bAnimatedPickups=True
     bAddToServerPackages=True
     ConfigMenuClassName="CFMutator.CFConfigMenu"
     GroupName="Crazy-Froggers"
     FriendlyName="Crazy-Froggers"
     Description="Adds several options to modify Ballistic Weapons and contains several fixes for Ballistic Weapons.||http://crazy-froggers.com"
     bNetTemporary=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
