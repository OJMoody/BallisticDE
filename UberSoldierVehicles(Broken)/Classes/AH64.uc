//----------------------//
// AH64AttackHelicopter //
//----------------------//
class AH64 extends DAVehicles;

var float               mCurrentRoll;
var float               mRollInc;
var float               mRollUpdateTime;

var MI48Blades Blades;
var MI48Vert BladesStill;

var Deco_AH64Korpus Korpus;

var FX_EngineSmoke EngineSmokeL;
var FX_EngineSmoke EngineSmokeR;

simulated function DrawHUD(Canvas Canvas)
{
        local Material BGMaterial;
       
        Super.DrawHUD(Canvas);
       
 
        BGMaterial = Texture'DKVehiclesTex.Ammo.Ammo288';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.85);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());

        BGMaterial = Texture'DKVehiclesTex.Ammo.IconAmmo288';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.80);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());
}

simulated function PostNetBeginPlay()
{
    Super.PostNetBeginPlay();

       if (Korpus==none) 
       { 
         Korpus = Spawn(class'Deco_AH64Korpus',self,, Location + (vect(0,0,1) << Rotation)); 
       if( !AttachToBone(Korpus,'Chassis') ) 
       { 
               Korpus.Destroy(); 
                         return; 
       }
       }

    if (Role == ROLE_Authority)
	{

		if (Weapons.Length == 2 && ONSLinkableWeapon(Weapons[0]) != None)
    {
        ONSLinkableWeapon(Weapons[0]).ChildWeapon = Weapons[1];

	    }

    }

       if (BladesStill==none)
          {
           BladesStill=spawn(Class'MI48Vert',Self,,Location);
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

   Driver.CreateInventory("UberSoldierVehicles.ParachuteInv");

    Weapons[1].bActive = True;
}

simulated event DrivingStatusChanged()
{
	Super.DrivingStatusChanged();
}

function DriverLeft()
{
    Weapons[1].bActive = False;

     if (blades!=none)
	    blades.Destroy();

    Super.DriverLeft();
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
           BladesStill=spawn(Class'MI48Vert',Self,,Location);
           if( !AttachToBone(BladesStill,'Vert') )
             {
			   BladesStill.Destroy();
			   return;
		     }
           }
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
          blades=spawn(Class'MI48Blades',Self,,Location);
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

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
Vector momentum, class<DamageType> damageType)
{
	if (DamageType == class'DT_AP_PS')
		Damage *= 1500.00;
	if (DamageType == class'DT_FG_PS')
		Damage *= 1500.00;

	if ( (Health <= 0.70*HealthMax) && (EngineSmokeL == none) )
	{
	EngineSmokeL = spawn( class'UberSoldierVehicles.FX_EngineSmoke' , self);
	if (EngineSmokeL != none)
	AttachToBone(EngineSmokeL,'SmokeL');
	}

	if ( (Health <= 0.60*HealthMax) && (EngineSmokeR == none) )
	{
	EngineSmokeR = spawn( class'UberSoldierVehicles.FX_EngineSmoke' , self);
	if (EngineSmokeR != none)
	AttachToBone(EngineSmokeR,'SmokeR');
	}

	Super.TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
}

simulated function Destroyed()
{
	Korpus.Destroy();
	EngineSmokeL.Destroy();
	EngineSmokeR.Destroy();

	    blades.Destroy();
         BladesStill.Destroy();

    Super.Destroyed();
}

defaultproperties
{
     UprightStiffness=500.000000
     UprightDamping=200.000000
     MaxThrustForce=180.000000
     LongDamping=0.050000
     MaxStrafeForce=120.000000
     LatDamping=0.050000
     MaxRiseForce=75.000000
     UpDamping=0.050000
     TurnTorqueFactor=650.000000
     TurnTorqueMax=250.000000
     TurnDamping=300.000000
     MaxYawRate=10.000000
     PitchTorqueFactor=200.000000
     PitchTorqueMax=50.000000
     PitchDamping=50.000000
     RollTorqueTurnFactor=550.000000
     RollTorqueStrafeFactor=100.000000
     RollTorqueMax=100.000000
     RollDamping=100.000000
     StopThreshold=100.000000
     MaxRandForce=3.000000
     RandForceInterval=0.750000
     DriverWeapons(0)=(WeaponClass=Class'UberSoldierVehicles.AH64Missile',WeaponBone="Turret")
     DriverWeapons(1)=(WeaponClass=Class'UberSoldierVehicles.AH64SmallMissile',WeaponBone="Turret")
     RedSkin=Shader'DKVehiclesTex.AH64.AH64'
     BlueSkin=Shader'DKVehiclesTex.AH64.AH64'
     IdleSound=Sound'APVerIV_Snd.PredatorSnd'
     StartUpSound=Sound'ONSVehicleSounds-S.AttackCraft.AttackCraftStartUp'
     ShutDownSound=Sound'ONSVehicleSounds-S.AttackCraft.AttackCraftShutDown'
     StartUpForce="AttackCraftStartUp"
     ShutDownForce="AttackCraftShutDown"
     DisintegrationEffectClass=Class'UberSoldierVehicles.FX_HelecopterDestroy'
     VehicleMass=8.000000
     bTurnInPlace=True
     ExitPositions(0)=(Y=-324.000000,Z=100.000000)
     ExitPositions(1)=(Y=324.000000,Z=100.000000)
     EntryPosition=(X=-40.000000)
     EntryRadius=400.000000
     TPCamDistance=2000.000000
     TPCamLookat=(X=0.000000,Z=0.000000)
     TPCamWorldOffset=(Z=1000.000000)
     ShadowMaxTraceDist=10000.000000
     ShadowCullDistance=10000.000000
     DriverDamageMult=0.100000
     VehiclePositionString="AH64"
     VehicleNameString="AH64"
     RanOverDamageType=Class'Onslaught.DamTypeAttackCraftRoadkill'
     CrushedDamageType=Class'Onslaught.DamTypeAttackCraftPancake'
     FlagBone="Vert"
     FlagOffset=(Z=80.000000)
     HornSounds(0)=Sound'ONSVehicleSounds-S.Horns.Horn03'
     HornSounds(1)=Sound'ONSVehicleSounds-S.Horns.Horn07'
     bCanBeBaseForPawns=True
     GroundSpeed=2000.000000
     HealthMax=800.000000
     Health=800
     Mesh=SkeletalMesh'DKVehiclesAnim.AH64'
     Skins(0)=Shader'DKVehiclesTex.AH64.AH64'
     Skins(1)=TexEnvMap'CH_Rocket_tex.REnvmap'
     Skins(2)=Texture'DKVehiclesTex.Detail.invis'
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
         bKStayUpright=True
         bKAllowRotate=True
         bDestroyOnWorldPenetrate=True
         bDoSafetime=True
         KFriction=1.000000
         KImpactThreshold=300.000000
     End Object
     KParams=KarmaParamsRBFull'UberSoldierVehicles.AH64.KParams0'

}
