//=============================================================================
// AP_Frag12Box
//
// some boom booms for the boom boom gun
//
// by George W. Bush
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_Frag12Box extends BallisticAmmoPickup;

simulated event PreBeginplay()
{
}

defaultproperties
{
     AmmoAmount=2
     InventoryType=Class'BWBPAnotherPackDE.Ammo_20mmGrenade'
     PickupMessage="You picked up 2 Toxic Explosives"
     PickupSound=Sound'BallisticSounds2.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.Bulldog.Frag12Ammo'
     DrawScale=0.300000
     PrePivot=(Z=-2.000000)
     CollisionRadius=8.000000
     CollisionHeight=10.000000
}
