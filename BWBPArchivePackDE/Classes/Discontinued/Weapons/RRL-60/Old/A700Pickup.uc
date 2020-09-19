//=============================================================================
// G5Pickup.
//=============================================================================
class A700Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=..\Textures\BWSkrithRecolors2Tex.utx
#exec OBJ LOAD FILE=..\StaticMeshes\BWSkrithRecolors2Static.usx

replication
{
	reliable if (Role==ROLE_Authority)
		ChangePickupMesh;
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors2Tex.SkrithRL.SkrithRLScreenBase');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors2Tex.SkrithRL.SkrithRocketBack');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors2Tex.SkrithRL.SkrithRocketBaseSkin');
	Level.AddPrecacheMaterial(Texture'BWSkrithRecolors2Tex.SkrithRL.SkrithRocketLauncher_Main');

}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolors2Static.SkrithRL.SkrithRLPick');
	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolors2Static.SkrithRL.SkrithRLPickEmpty');
	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolors2Static.SkrithRL.SkrithRocket');
	Level.AddPrecacheStaticMesh(StaticMesh'BWSkrithRecolors2Static.SkrithRL.SkrithRocketAmmo');

}

function InitDroppedPickupFor(Inventory Inv)
{
    Super.InitDroppedPickupFor(None);

    if (A700SkrithRocketLauncher(Inv) != None)
    {
	MagAmmo = A700SkrithRocketLauncher(Inv).MagAmmo;
	ChangePickupMesh();
    }
}

simulated event Tick(float DT)
{
	local PlayerController PC;

	if (ChangeTime > 0 && level.TimeSeconds > ChangeTime && (IsInState('Sleeping') || /*!level.Game.bWeaponStay || */!PlayerCanSeeMe()))
		OnItemChange(self);

	super(UTWeaponPickup).Tick(DT);


	if (level.NetMode == NM_DedicatedServer)
		return;

	PC = Level.GetLocalPlayerController();
	if (PC==None)
		return;
	if (PC.ViewTarget != None && VSize(Location - PC.ViewTarget.Location) > LowPolyDist * (90 / PC.FOVAngle))
	{
		if (StaticMesh != LowPolyStaticMesh)
			SetStaticMesh(LowPolyStaticMesh);
	}
	//Prevents mesh from changing from the correct mesh if the gun has no ammo
	else if (StaticMesh != default.StaticMesh && StaticMesh != StaticMesh'BWSkrithRecolors2Static.SkrithRL.SkrithRLPickEmpty')
	{
		//log("MagAmmo: "$MagAmmo);
		SetStaticMesh(default.StaticMesh);
	}
}

simulated function ChangePickupMesh()
{
	if (MagAmmo == 0)
	{
		SetStaticMesh(StaticMesh'BWSkrithRecolors2Static.SkrithRL.SkrithRLPickEmpty');
		LowPolyStaticMesh = StaticMesh'BWSkrithRecolors2Static.SkrithRL.SkrithRLPickEmpty';
	}		
		
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWSkrithRecolors2Static.SkrithRL.SkrithRLPick'
     PickupDrawScale=0.250000
     InventoryType=Class'BWBPArchivePackDE.A700SkrithRocketLauncher'
     RespawnTime=20.000000
     PickupMessage="You picked up the A700 Skrith rocket launcher"
     PickupSound=Sound'BallisticSounds2.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWSkrithRecolors2Static.SkrithRL.SkrithRLPick'
     Physics=PHYS_None
     DrawScale=0.250000
     CollisionHeight=4.500000
}
