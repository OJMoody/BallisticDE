//=============================================================================
// JS_radiatorPickup.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_sh_radiatorpickup extends JunkShieldPickup;

defaultproperties
{
     SpawnPivot=(Roll=30000)
     InventoryType=Class'JWVanDE.JWVan_sh_radiator'
     PickupMessage="You picked up a Radiator."
     StaticMesh=StaticMesh'JWVanStatic.sh_radiator_LD'
}
