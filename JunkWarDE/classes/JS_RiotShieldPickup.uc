//=============================================================================
// JS_RiotShieldPickup.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JS_RiotShieldPickup extends JunkShieldPickup;

defaultproperties
{
     SpawnPivot=(Roll=30000)
     InventoryType=Class'JunkWarDE.JS_RiotShield'
     PickupMessage="You picked up a Riot Shield"
     StaticMesh=StaticMesh'JunkWarHardware.ShieldS.RiotShieldLD'
}
