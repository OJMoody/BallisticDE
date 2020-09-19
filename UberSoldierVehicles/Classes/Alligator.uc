//---------------------------------//
// Alligator Attack Helicopter     //
//---------------------------------//
class Alligator extends ONSDualAttackCraft;

var AlligatorVert BladesStill;
var AlligatorBlades blades;

var float               mCurrentRoll;
var float               mRollInc;
var float               mRollUpdateTime;

simulated function PostNetBeginPlay()
{
    Super.PostNetBeginPlay();

    if (Role == ROLE_Authority)
	{
		if (WeaponPawns[0]!=None)
		    WeaponPawns[0].Gun.SetOwner(self);

		if (Weapons.Length == 2 && ONSLinkableWeapon(Weapons[0]) != None)
    {
        ONSLinkableWeapon(Weapons[0]).ChildWeapon = Weapons[1];
        if (ONSDualACSideGun(Weapons[1]) != None)
            ONSDualACSideGun(Weapons[1]).bSkipFire = True;

	        if (ONSDualACSideGun(Weapons[0]) != None)
	            ONSDualACSideGun(Weapons[0]).bFiresRight = true;
	    }

    }

       if (BladesStill==none)
          {
           BladesStill=spawn(Class'AlligatorVert',Self,,Location);
           if( !AttachToBone(BladesStill,'Vert') )
             {
			   BladesStill.Destroy();
			   return;
             }
           }
}

function KDriverEnter(Pawn p)
{
    Super.KDriverEnter( P );

   Driver.CreateInventory("APVerIV.edo_ChuteInv");

    Weapons[1].bActive = True;
}

simulated event DrivingStatusChanged()
{
	Super.DrivingStatusChanged();
}

function DriverLeft()
{
    Weapons[1].bActive = False;
}

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
    if (blades!=none)
	    blades.Destroy();

    if (BladesStill!=none)
        BladesStill.Destroy();
	Super.Died(Killer, damageType, HitLocation);
}

simulated event GearStatusChanged()
{
     if (blades!=none)
	    blades.Destroy();

     if (BladesStill==none)
          {
           BladesStill=spawn(Class'AlligatorVert',Self,,Location);
           if( !AttachToBone(BladesStill,'Vert') )
             {
			   BladesStill.Destroy();
			   return;
		     }
           }
}

simulated function ClientKDriverLeave(PlayerController PC)
{
    GearStatusChanged();
    Super.ClientKDriverLeave(PC);
}

simulated function UpdateRoll(float dt)
{
    local rotator r;

     mRollInc = 65536.f*2.f;
    if (mRollInc <= 0.f)
        return;

    mCurrentRoll += dt*mRollInc;
    mCurrentRoll = mCurrentRoll % 65536.f;
    r.Yaw = int(mCurrentRoll);

    SetBoneRotation('Vert', r, 0, 1.f);
}

simulated function Tick(float DeltaTime)
{
	local PlayerController PC;

     if (blades==none)
         {
          blades=spawn(Class'AlligatorBlades',Self,,Location);
          if( !AttachToBone(blades,'Vert') )
            {
			blades.Destroy();
			return;
		   }
         }

    if (bDriving==true)
       {
           UpdateRoll(DeltaTime);
           if (BladesStill!=none)
               BladesStill.Destroy();
         }

    Super.Tick(DeltaTime);
    if ( !IsVehicleEmpty() )
		Enable('tick');
}

simulated function Destroyed()
{
	if (blades!=none)
	    blades.Destroy();
     if (BladesStill!=none)
         BladesStill.Destroy();

    Super.Destroyed();
}

defaultproperties
{
     MaxThrustForce=180.000000
     LongDamping=0.050000
     MaxStrafeForce=120.000000
     MaxRiseForce=75.000000
     TurnTorqueFactor=650.000000
     TurnTorqueMax=250.000000
     MaxYawRate=2.500000
     RollTorqueTurnFactor=550.000000
     RollTorqueStrafeFactor=90.000000
     RollTorqueMax=90.000000
     RollDamping=40.000000
     RedSkin=Shader'DKVehiclesTex.Alligator.AlligatorA'
     BlueSkin=Shader'DKVehiclesTex.Alligator.AlligatorA'
     IdleSound=Sound'APVerIV_Snd.PredatorSnd'
     StartUpSound=Sound'ONSVehicleSounds-S.AttackCraft.AttackCraftStartUp'
     ShutDownSound=Sound'ONSVehicleSounds-S.AttackCraft.AttackCraftShutDown'
     DisintegrationEffectClass=Class'UberSoldierVehicles.FX_HelecopterDestroy'
     DisintegrationHealth=0.000000
     VehicleMass=8.000000
     ExitPositions(0)=(Y=-324.000000)
     ExitPositions(1)=(Y=324.000000)
     EntryPosition=(X=-40.000000)
     EntryRadius=400.000000
     TPCamDistance=1500.000000
     TPCamWorldOffset=(Z=500.000000)
     ShadowMaxTraceDist=10000.000000
     ShadowCullDistance=10000.000000
     DriverDamageMult=0.100000
     VehiclePositionString="Alligator"
     VehicleNameString="Alligator"
     FlagBone="Vert"
     bCanBeBaseForPawns=True
     Mesh=SkeletalMesh'DKVehiclesAnim.Alligator'
     Skins(0)=Shader'DKVehiclesTex.Alligator.AlligatorA'
     Skins(1)=Shader'DKVehiclesTex.Alligator.AlligatorB'
     Skins(2)=TexEnvMap'DKVehiclesTex.Cheetah.CheetahSS'
     Skins(3)=Texture'DKVehiclesTex.Detail.invis'
     SoundRadius=1000.000000
     Begin Object Class=KarmaParamsRBFull Name=KParams0
         KInertiaTensor(0)=1.000000
         KInertiaTensor(3)=3.000000
         KInertiaTensor(5)=3.500000
         KCOMOffset=(X=-0.250000)
         KLinearDamping=0.000000
         KAngularDamping=0.000000
         KStartEnabled=True
         bKNonSphericalInertia=True
         KActorGravScale=0.000000
         bHighDetailOnly=False
         bClientOnly=False
         bKDoubleTickRate=True
         bKStayUpright=True
         bKAllowRotate=True
         bDestroyOnWorldPenetrate=True
         bDoSafetime=True
         KFriction=0.500000
         KImpactThreshold=300.000000
     End Object
     KParams=KarmaParamsRBFull'UberSoldierVehicles.Alligator.KParams0'

}
