//=============================================================================
// JS_SignPickup.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JS_SignPickup extends JunkShieldPickup;

defaultproperties
{
     SpawnPivot=(Roll=30000)
     InventoryType=Class'JunkWarDE.JS_Sign'
     PickupMessage="You picked up a Junk War Sign"
     StaticMesh=StaticMesh'JunkWarHardware.ShieldS.SignLD'
}
