//-----------------------------------------------------------
//
//-----------------------------------------------------------
class CFBallisticArmor extends BallisticArmor;

var int CFMaxCharge;

replication
{
	reliable if (Role == ROLE_Authority && bNetOwner)
	   CFMaxCharge;
}

simulated function PostBeginPlay()
{
	CFMaxCharge = class'Mut_CFMutators'.default.iArmorCap;
	MaxCharge = CFMaxCharge;

	Super.PostBeginPlay();
}

function GiveTo(pawn Other, optional Pickup Pickup)
{
	Instigator = Other;
	if (Other.AddInventory( Self ))
	{
		GotoState('');
		if (Pickup != None && BallisticArmorPickup(Pickup) != None)
		{
			Charge = clamp(Charge + BallisticArmorPickup(Pickup).ArmorCharge,0, MaxCharge);
		}
		SetShieldDisplay(Charge);
	}
	else
		Destroy();
}

defaultproperties
{
}
