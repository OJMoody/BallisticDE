//=============================================================================
// CFMACWeapon_TW.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFMACWeapon_TW extends MACWeapon_TW;

simulated event RenderOverlays (Canvas C)
{
	DisplayFOV = Instigator.Controller.FovAngle;
 	Super(BallisticWeapon).RenderOverlays( C );
 	if (bScopeView)
 	{
  		DrawHAMRScope( C );
 	}
}


simulated function Destroyed()
{
	local int m;
//	local Ammunition A;

	AmbientSound = None;

	if (SightFX != None)
		SightFX.Destroy();

	if (PlayerSpeedUp && Instigator != None)
	{
		Instigator.GroundSpeed *= (1/PlayerSpeedFactor);
		PlayerSpeedUp=false;
	}

	if (Instigator != None && Instigator.Controller != none && PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).MyHud != None)
		PlayerController(Instigator.Controller).MyHud.bCrosshairShow = PlayerController(Instigator.Controller).MyHud.default.bCrosshairShow;

	for (m = 0; m < NUM_FIRE_MODES; m++)
	{
		if ( FireMode[m] != None )
			FireMode[m].DestroyEffects();
		if (Ammo[m] != None)
		{
/*		    if (Instigator != None && Instigator.Health > 0)
			{
			    A = Spawn(Ammo[m].Class, Instigator);
				A.AmmoAmount = Ammo[m].AmmoAmount;
	            Instigator.AddInventory(A);
			}
*/
		    if (Instigator == None || Instigator.Health < 1)
				Ammo[m].Destroy();
			Ammo[m] = None;
		}
	}
	Super(Inventory).Destroyed();

	if(Instigator.Controller != none)
		Instigator.Controller.bRun = 0;
}

defaultproperties
{
}
