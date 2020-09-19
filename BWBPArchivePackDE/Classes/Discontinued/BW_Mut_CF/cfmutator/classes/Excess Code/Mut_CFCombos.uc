//=============================================================================
// Mut_CFCombos.
//
// by Paul "Grum" Haack.
// Copyright(c) 2013 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class Mut_CFCombos extends Mutator;

var xPlayer NotifyPlayer[32];

function Timer()
{
	 local int i;

	 for(i = 0; i < 32; i++)
	 {
		  if(NotifyPlayer[i] != None)
		  {
			   NotifyPlayer[i].ClientReceiveCombo("CFMutator.ComboDamageAmplifier");
			   NotifyPlayer[i] = None;
		  }
	 }
}

function Mutate(string MutateString, PlayerController Sender)
{

	if (MutateString ~= "CFComboDamageAmplifier" && Sender != None)
	{
		if(xPlayer(Sender) != none)
			xPlayer(Sender).DoCombo(class'CFMutator.ComboDamageAmplifier');
	}else if (MutateString ~= "CFComboBulletTime" && Sender != None)
	{
   		if(Sender.Pawn != none && CFBallisticPawn(Sender.Pawn) != none && !CFBallisticPawn(Sender.Pawn).lsa.bulletTime)
			if(xPlayer(Sender) != none)
				xPlayer(Sender).DoCombo(class'CFMutator.ComboBulletTime');
	}
	super.Mutate(MutateString, Sender);
}

function bool IsRelevant(Actor Other, out byte bSuperRelevant)
{
	 local int i;

	 if(xPlayer(Other) != None)
	 {
	 	for(i=0; i<16; i++)
	    {
	       if (xPlayer(Other).ComboNameList[i] ~= "CFMutator.ComboDamageAmplifier")
					break;

			   else if(xPlayer(Other).ComboNameList[i] == "")
			   {
					xPlayer(Other).ComboNameList[i] = "CFMutator.ComboDamageAmplifier";
		    		break;
			   }
		}
		for ( i=0; i<16; i++ )
		{
			if ( xPlayer(Other).ComboNameList[i] ~= "CFMutator.ComboBulletTime" )
				break;
			else if ( xPlayer(Other).ComboNameList[i] == "" )
			{
				xPlayer(Other).ComboNameList[i] = "CFMutator.ComboBulletTime";
				break;
			}
		}
		for(i = 0; i < 32; i++)
		{
			if(NotifyPlayer[i] == None)
			{
				NotifyPlayer[i] = xPlayer(Other);
				SetTimer(0.5, false);
				break;
			}
		}
	 }
	 if(NextMutator != None)
		  return NextMutator.IsRelevant(Other, bSuperRelevant);
	 else
		  return true;
}

defaultproperties
{
     bAddToServerPackages=True
     FriendlyName="Crazy-Froggers | Combos"
     Description="This Mutator adds combos for the usage with the Crazy-Froggers mutator."
}
