//=============================================================================
// By Paul "Grum" Haack.
// Copyright(c) 2013 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class ComboDamageAmplifier extends Combo;

function StartEffect(xPawn P)
{
	if (P.Role == ROLE_Authority)
	{
		if(CFBallisticPawn(P) != none)
			CFBallisticPawn(P).EnableUDamageAdrenalined();
	}
}

function StopEffect(xPawn P)
{
	if (P.Role == ROLE_Authority)
	{
		P.DisableUDamage();
	}
}

defaultproperties
{
     ExecMessage="DOUBLE DAMAGE!!"
     ComboAnnouncementName="LockandLoad"
}
