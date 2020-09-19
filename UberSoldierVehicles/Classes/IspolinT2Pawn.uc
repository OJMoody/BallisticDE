class IspolinT2Pawn extends DKWeapons2;

simulated function DrawHUD(Canvas Canvas)
{
    local Material BGMaterial;
       
        Super.DrawHUD(Canvas);

        BGMaterial = Texture'DKVehiclesTex.Ammo.Ammo12';

        Canvas.SetPos(Canvas.SizeX*0.00, Canvas.SizeY*0.85);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());

        BGMaterial = Texture'DKVehiclesTex.Ammo.IconAmmo12';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.78);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());
}

function AttachToVehicle(ONSVehicle VehiclePawn, name WeaponBone)
{
    if (Level.NetMode != NM_Client)
    {
        VehicleBase = VehiclePawn;
    	if (VehiclePawn.Weapons.length > 0 && VehiclePawn.Weapons[0] != None)
    		VehiclePawn.Weapons[0].AttachToBone(Gun, 'Turret2');
    	else
        	VehicleBase.AttachToBone(Gun, WeaponBone);
    }
}

simulated function vector GetCameraLocationStart()
{
	if (Gun != None)
		return Gun.GetBoneCoords(CameraBone).Origin;
	else
		return Super.GetCameraLocationStart();
}

defaultproperties
{
     GunClass=Class'UberSoldierVehicles.IspolinT2'
     bDesiredBehindView=False
     TPCamDistance=124.151611
}
