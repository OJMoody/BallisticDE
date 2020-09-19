//=============================================================================
// Ballistic No Pack.
//
// Removes Ballistic Ammo-Packs.
//=============================================================================
class MutBWNoPack extends Mutator;

simulated function BeginPlay()
{
	local xPickupBase P;
	local Pickup L;

	foreach AllActors(class'xPickupBase', P)
	{
		P.bHidden = true;
		if (P.myEmitter != None)
			P.myEmitter.Destroy();
	}
	foreach AllActors(class'Pickup', L)
		if ( L.IsA('WeaponLocker') )
			L.GotoState('Disabled');

	Super.BeginPlay();
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
  if ( Other.IsA('IP_AmmoPack') )
    return false;

  return Super.CheckReplacement(Other, bSuperRelevant);

}


//=============================================================================
// Default properties
//=============================================================================

defaultproperties
{
     bAddToServerPackages=True
     FriendlyName="BallisticPro: No Ammo Packs"
     Description="BW Ammo-Packs are removed from the map."
     bNetTemporary=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
