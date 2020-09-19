//=============================================================================
// Mut_CFMutators.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFBCSprintControl extends BCSprintControl;

var float		InitStamina;			// Stamina level of player. Players can't sprint when this is out
var float		InitMaxStamina;			// Max level of stamina
var float		InitStaminaDrainRate;	// Amount of stamina lost each second when sprinting
var float		InitStaminaChargeRate;	// Amount  of stamina gained each second when not sprinting
var float		InitSpeedFactor;		// Player speed multiplied by this when sprinting
var float 		InitJumpDrainFactor;

var() float		RealStamina;			// Stamina level of player. Players can't sprint when this is out

replication
{
	reliable if(Role == ROLE_Authority && bNetInitial)
		InitStamina, InitMaxStamina, InitStaminaDrainRate, InitStaminaChargeRate, InitSpeedFactor, InitJumpDrainFactor;
}

simulated function PostBeginPlay()
{
	RealStamina = class'Mut_CFMutators'.default.InitStamina;
	Stamina = 0;
	MaxStamina = class'Mut_CFMutators'.default.InitMaxStamina;
	StaminaDrainRate = class'Mut_CFMutators'.default.InitStaminaDrainRate;
	StaminaChargeRate = class'Mut_CFMutators'.default.InitStaminaChargeRate;
	SpeedFactor = class'Mut_CFMutators'.default.InitSpeedFactor;
	InitJumpDrainFactor = class'Mut_CFMutators'.default.JumpDrainFactor;

	Super.PostBeginPlay();
}

simulated function OwnerEvent(name EventName)
{
	super(Inventory).OwnerEvent(EventName);
	if (EventName == 'Jumped' || EventName == 'Dodged')
	{
		ClientJumped();
		RealStamina = FMax(0, RealStamina - StaminaDrainRate * InitJumpDrainFactor);
	}
}

simulated function ClientJumped()
{
	if (level.NetMode != NM_Client)
		return;
	RealStamina = FMax(0, RealStamina - StaminaDrainRate * InitJumpDrainFactor);
}


simulated event Tick(float DT)
{
	// Drain stamin while sprinting
	if (bSprintHeld && Instigator.Physics != PHYS_Falling && VSize(Instigator.Acceleration) > 100 && VSize(Instigator.Velocity) > 50 && (xPawn(Instigator) == None || xPawn(Instigator).CurrentCombo==None || ComboSpeed(xPawn(Instigator).CurrentCombo) == None))
	{
		if (!bSprinting)
		{
			bSprinting=true;
			if (BallisticWeapon(Instigator.Weapon) != None)
				BallisticWeapon(Instigator.Weapon).PlayerSprint(true);
//			if (Role == ROLE_Authority)
			if (Instigator != None && Instigator.Inventory != None)
				Instigator.Inventory.OwnerEvent('StartSprint');
		}
		RealStamina -= StaminaDrainRate * DT;
		if (RealStamina <= 0)
			StopSprint();
	}
	// Stamina charges when not sprinting
	else// if (VSize(RV) < Instigator.default.GroundSpeed * 0.8)
	{
		if (bSprinting)
		{
			bSprinting=False;
			if (BallisticWeapon(Instigator.Weapon) != None)
				BallisticWeapon(Instigator.Weapon).PlayerSprint(false);
//			if (Role == ROLE_Authority)
			if (Instigator != None && Instigator.Inventory != None)
				Instigator.Inventory.OwnerEvent('StopSprint');
		}
		if (RealStamina < MaxStamina)
			RealStamina += StaminaChargeRate * DT;
	}
	RealStamina = FClamp(RealStamina, 0, MaxStamina);
}

defaultproperties
{
     RealStamina=100.000000
}
