//=============================================================================
// JS_fenderPickup.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_sh_fenderpickup extends JunkShieldPickup;

defaultproperties
{
     SpawnPivot=(Roll=30000)
     InventoryType=Class'JWVanDE.JWVan_sh_fender'
     PickupMessage="You picked up a Bumper."
     StaticMesh=StaticMesh'JWVanStatic.sh_fender_LD'
}
