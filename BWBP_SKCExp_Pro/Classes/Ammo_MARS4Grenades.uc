//=============================================================================
// Ammo_MARS4Grenades.
//
// Ammo for the MARS4 Shockwave GL
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_MARS4Grenades extends BallisticAmmo;

var MARS4AssaultRifle		DaF2K;
var Ammo_545mmSTANAG Bullets;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_MARS4Clip') )
	{
		if (Bullets==None)
		{
			Bullets = Ammo_545mmSTANAG(Pawn(Owner).FindInventoryType(class'Ammo_545mmSTANAG'));
			if (Bullets == None)
			{
				Bullets = spawn(class'Ammo_545mmSTANAG',Owner,,,rot(0,0,0));
				Bullets.GiveTo( Pawn(Owner), Item );
			}
		}
		if (Bullets!=None)
		{
			if (Bullets.AmmoAmount < Bullets.MaxAmmo)
			{
				Bullets.AddAmmo(Ammo(item).AmmoAmount);
				if (AmmoAmount<MaxAmmo)
				{
					item.AnnouncePickup(Pawn(Owner));
			        item.SetRespawn();
			    }
			}
		}
		if (AmmoAmount>=MaxAmmo)
			return true;
		item.AnnouncePickup(Pawn(Owner));
		AddAmmo(2);
        item.SetRespawn();
		return true;
	}
	else if (Super.HandlePickupQuery(Item))
	{
		if (DaF2K != None)
			DaF2k.GrenadePickedUp();
		return true;
	}
	return false;
}

defaultproperties
{
     MaxAmmo=3
     InitialAmount=1
     IconFlashMaterial=Shader'BW_Core_WeaponTex.OA-AR.AmmoIcon_OAARFlash'
     PickupClass=Class'BWBPRecolorsPro.AP_STANAGShockwave'
     IconMaterial=Texture'BW_Core_WeaponTex.OA-AR.AmmoIcon_OAAR'
     IconCoords=(X2=64,Y2=64)
     ItemName="MARS-4 Shockwave Grenades"
}
