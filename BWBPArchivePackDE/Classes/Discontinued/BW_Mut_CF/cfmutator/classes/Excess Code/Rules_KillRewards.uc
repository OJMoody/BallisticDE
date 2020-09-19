//=============================================================================
// Rules_KillRewards.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class Rules_KillRewards extends GameRules;

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

function ScoreKill(Controller Killer, Controller Killed)
{
	local int healthCap, shieldCap, armorStrength;
	local CFClientServiceActor sa;
	super.ScoreKill(Killer,Killed);

	// Kill counter for achievements
	if(Killer != none && Killer != Killed)
	{
		sa = ServerGetClientServiceActor(Killer);
		sa.iKills += 1;
	}

	if(Killed != None && Killer != None && Killer.Pawn != None)
	{
		if(Killer.Pawn.Health > 0 && Killer.Pawn.Health < class'CFMutator.Mut_CFMutators'.Default.killRewardHealthcap || class'CFMutator.Mut_CFMutators'.Default.killRewardHealthcap == 0)
		{
			healthCap = class'CFMutator.Mut_CFMutators'.Default.killRewardHealthcap;
			if(Vehicle(Killer.Pawn) == None)
			{
				if(healthCap == 0)
					healthCap = Killer.Pawn.SuperHealthMax;
				Killer.Pawn.Health = Clamp(Killer.Pawn.Health+class'CFMutator.Mut_CFMutators'.Default.killRewardHealthpoints,0,healthCap);
			}else
			{
				if(healthCap == 0)
					healthCap = Vehicle(Killer.Pawn).Driver.SuperHealthMax;
				Vehicle(Killer.Pawn).Driver.Health = Clamp(Vehicle(Killer.Pawn).Driver.Health+class'CFMutator.Mut_CFMutators'.Default.killRewardHealthpoints,0,healthCap);
			}
		}

		if(Killer.Pawn.Health > 0 && Killer.Pawn.ShieldStrength < class'CFMutator.Mut_CFMutators'.Default.killrewardArmorCap || class'CFMutator.Mut_CFMutators'.Default.killrewardArmorCap == 0)
		{
			shieldCap = class'CFMutator.Mut_CFMutators'.Default.killrewardArmorCap;
			if(Vehicle(Killer.Pawn) == None && xPawn(Killer.Pawn) != none)
			{
				if(shieldCap == 0)
					shieldCap = xPawn(Killer.Pawn).ShieldStrengthMax;
				armorStrength = Clamp(class'CFMutator.Mut_CFMutators'.Default.killrewardArmor,0,shieldCap);

				xPawn(Killer.Pawn).AddShieldStrength(armorStrength);
			}else if(xPawn(Vehicle(Killer.Pawn).Driver) != none)
			{
				if(shieldCap == 0)
					shieldCap = xPawn(Vehicle(Killer.Pawn).Driver).ShieldStrengthMax;

				armorStrength = Clamp(class'CFMutator.Mut_CFMutators'.Default.killrewardArmor,0,shieldCap);
				xPawn(Vehicle(Killer.Pawn).Driver).AddShieldStrength(armorStrength);
			}
		}
	}
}

defaultproperties
{
}
