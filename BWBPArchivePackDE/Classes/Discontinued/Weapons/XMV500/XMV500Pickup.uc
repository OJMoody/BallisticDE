//=============================================================================
// The XMB500's pickup.
//=============================================================================
class XMV500Pickup extends XMV850Pickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4.utx


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4.XMV500.XMV500_Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4.XMV500.XMV500_Barrels');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4.XMV500.XMV500_BackPack');
}

defaultproperties
{
     InventoryType=Class'BWBPArchivePackDE.XMV500Minigun'
     PickupMessage="You picked up the handheld VL-500 Vulcan Minigun"
     Skins(0)=Texture'BallisticRecolors4.XMV500.XMV500_Main'
     Skins(1)=Shader'BallisticRecolors4.XMV500.XMV500_Barrels_SD'
     Skins(2)=Texture'BallisticRecolors4.XMV500.XMV500_BackPack'
}
