//=============================================================================
// MGA88Turret.
// 3RD Person Turret Attachment
// Turret pawn for MGA88 deployed machinegun. Gets a turrtet version of the MGA88 weapon
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MGA88TurretPawn extends BallisticTurret;

simulated function vector CalcDrawOffset(inventory Inv)
{
//  if (Inv.DrawScale != DrawScale)
        return vect(0,0,1) * (Inv.CollisionHeight - CollisionHeight);
//  return vect(0,0,0);
}

function UpdateWeaponRotation()
{
    local rotator HeadRot, NeckRot;

    if (Weapon != None)
    {
        NeckRot.Yaw = -GunRotation.Yaw;
        HeadRot.Pitch = -GunRotation.Pitch;

        NeckRot.Yaw -= WeaponPivot.Yaw;
        HeadRot.Pitch -= WeaponPivot.Pitch;

        if (Weapon.Hand < 0)
            NeckRot.Yaw = 0 - NeckRot.Yaw;
        Weapon.SetBoneRotation(PivotBone, NeckRot);
        Weapon.SetBoneRotation('Gun', HeadRot);
    }
}

function InitTurretWeapon(Weapon Weap)
{
    local Ammunition A;
    if (Driver != None)
    {
        A = Ammunition(Driver.FindInventoryType(Weap.GetAmmoClass(0)));
        if (A == None)
        {
            A = Driver.Spawn(Weap.GetAmmoClass(0), Driver);
            Driver.AddInventory(A);
            if (class'BallisticReplicationInfo'.default.bNoReloading)
                A.AmmoAmount = BallisticWeapon(Weap).MagAmmo;
            else
                A.AmmoAmount = 0;
            AmmoAmount[0] = A.AmmoAmount;
        }
        else
            AmmoAmount[0] = A.AmmoAmount;

    }
    super.InitTurretWeapon(Weap);
}

function SaveTurretWeaponInfo()
{
    local Ammunition A;

    super.SaveTurretWeaponInfo();
    if (Driver != None && Weapon != None)
    {
        A = Ammunition(Driver.FindInventoryType(Weapon.GetAmmoClass(0)));
        if (A == None)
        {
            A = Driver.Spawn(Weapon.GetAmmoClass(0), Driver);
            Driver.AddInventory(A);
            A.AmmoAmount = AmmoAmount[0];
        }
        else
            A.AmmoAmount = AmmoAmount[0];

    }
}

function float BotDesireability(Actor S, int TeamIndex, Actor Objective)
{
    if (Health <= 0 || Occupied() /*|| (bTeamLocked && !bSameTeam)*/)
        return 0;

    if (MagAmmoAmount == 0 && BotsNextDesireTime > level.timeseconds)
        return 0;

    if (bKeyVehicle)
        return 100;

    return MaxDesireability * 0.5 + (MaxDesireability * 0.5) * (MagAmmoAmount / 150.0);
}

defaultproperties
{
     UndeployedWeaponName="BWBPArchivePackDE.MGA88Machinegun"
     WeaponClassName="BWBPArchivePackDE.MGA88MachinegunTurret"
     GunYawBounds=(Min=-12000.000000,Max=12000.000000)
     GunPitchBounds=(Min=-10000.000000,Max=8192.000000)
     CamYawBounds=(Min=-12000.000000,Max=12000.000000)
     CamPitchBounds=(Max=12000.000000)
     GunYawSpeed=24000.000000
     GunPitchSpeed=32768.000000
     CamTrackYawSpeed=32768.000000
     CamTrackPitchSpeed=32768.000000
     AbandonedPitch=2600
     CameraOffset=(X=-110.000000,Y=-15.000000,Z=23.000000)
     CameraElevation=5.000000
	 GunBone="MG42"
     PivotBone="BipodAll"
     DriverBackOff=45.000000
	 bDrawDriverInTP=True
     VehicleNameString="MGA88 Machinegun Turret"
     Mesh=SkeletalMesh'BWXWeaponAnims.MGA88-3rdm_Turret'
     DrawScale=1.500000
     CollisionHeight=15.000000
}
