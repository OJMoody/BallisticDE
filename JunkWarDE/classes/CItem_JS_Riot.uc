//=============================================================================
// CItem_JS_Riot.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class CItem_JS_Riot extends ConflictItem;

// Add some health
static function bool Applyitem(Pawn Other)
{
	local Inventory Inv;
	local class<Inventory>	InvClass;

	InvClass = class<Inventory>(DynamicLoadObject("JunkWarDE.JS_RiotShield",class'class'));
	if (InvClass != None)
	{
	    Inv = Other.FindInventoryType(InvClass);
    	if (Inv == None)
	    {
			Inv = Other.Spawn(InvClass, Other);
			if (Inv != None)
			{
				Inv.GiveTo(Other);
				return true;
			}
		}
	}
	return false;
}

defaultproperties
{
     ItemName="Riot Shield"
     Description="Junk Riot Shield.|Gives you a JunkWar Riot Shield."
     Icon=Texture'JunkWarUI2.Icons.Icon_JWRiot'
}
