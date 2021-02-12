//=============================================================================
// Ballistic No Boost
//
// Removes Ballistic Powerups.
//=============================================================================
class MutBWNoBoost extends Mutator;

simulated function BeginPlay()
{
  local xPickupBase PB;
  
  foreach AllActors(class'xPickupBase', PB)
    if ( PB.PowerUp == class'UDamagePack' ) 
      PB.bHidden = true;
      if ( PB.MyEmitter != None )
        PB.MyEmitter.Destroy();

  foreach AllActors(class'xPickupBase', PB)
    if ( PB.PowerUp == class'ShieldPack')
      PB.bHidden = true;
      if ( PB.MyEmitter != None )
        PB.MyEmitter.Destroy();

  foreach AllActors(class'xPickupBase', PB)
    if ( PB.PowerUp == class'SuperShieldPack')
      PB.bHidden = true;
      if ( PB.MyEmitter != None )
        PB.MyEmitter.Destroy();

  foreach AllActors(class'xPickupBase', PB)
    if ( PB.PowerUp == class'SuperHealthPack')
      PB.bHidden = true;
      if ( PB.MyEmitter != None )
        PB.MyEmitter.Destroy();

}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
  if ( Other.IsA('IP_Adrenaline') )
    return false;

  else if ( Other.IsA('IP_Bandage') )
    return false;

  else if ( Other.IsA('IP_BigArmor') )
    return false;

  else if ( Other.IsA('IP_SmallArmor') )
    return false;

  else if ( Other.IsA('IP_SuperHealthKit') )
    return false;

  else if ( Other.IsA('IP_UDamage') )
    return false;
  
  else if ( Other.IsA('AdrenalinePickup') )
    return false;

  else if ( Other.IsA('MiniHealthPack') )
    return false;

  else if ( Other.IsA('ShieldPack') )
    return false;
  
  else if ( Other.IsA('SuperShieldPack') )
    return false;

  else if ( Other.IsA('SuperHealthPack') )
    return false;

  else if ( Other.IsA('UDamagePack') )
    return false;

  return Super.CheckReplacement(Other, bSuperRelevant);

}


//=============================================================================
// Default properties
//=============================================================================

defaultproperties
{
     bAddToServerPackages=True
     FriendlyName="BallisticPro: No Powerups"
     Description="BW Powerups are removed from the map."
     bNetTemporary=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
