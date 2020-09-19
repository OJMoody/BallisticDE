//-------------------------------------------//
// Super BattleMaster MK2                    //
//-------------------------------------------//
class BattleMaster extends DKVehicles;

var Deco_BattleMasterKorpus Korpus;

var DKHeadlightCorona LightR1;
var DKHeadlightCorona LightL1;
var DKHeadlightCorona LightR2;
var DKHeadlightCorona LightL2;

var DKHeadlightProjector ProjectR1;
var DKHeadlightProjector ProjectL1;
var DKHeadlightProjector ProjectR2;
var DKHeadlightProjector ProjectL2;

var DKBrakelightCorona BrakeR1;
var DKBrakelightCorona BrakeL1;

var FX_EngineSmoke EngineSmoke1;
var FX_EngineSmoke EngineSmoke2;

var FX_EngineFireL DamageL1;
var FX_EngineFireR DamageR1;
var FX_EngineFireL DamageL2;
var FX_EngineFireR DamageR2;

var FX_EngineFire EngineFire1;
var FX_EngineFire EngineFire2;

simulated function DrawHUD(Canvas Canvas)
{
        local Material BGMaterial;
       
        Super.DrawHUD(Canvas);
       
 
        BGMaterial = Texture'DKVehiclesTex.Ammo.Ammo122';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.85);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());

        BGMaterial = Texture'DKVehiclesTex.Ammo.IconAmmo122';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.75);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());
}

function PostBeginPlay()
{
	super.PostBeginPlay();
 
         Korpus = Spawn(class'Deco_BattleMasterKorpus',self,, Location + (vect(0,0,0) << Rotation)); 
         AttachToBone(Korpus,'TankHull');
}

function KDriverEnter(Pawn p)
{
    Super.KDriverEnter(p);

    SVehicleUpdateParams();

                           LightR1 = Spawn(class'DKHeadlightCorona',self,,Location); 
                           AttachToBone(LightR1,'LightR1');

                           LightL1 = Spawn(class'DKHeadlightCorona',self,,Location); 
                           AttachToBone(LightL1,'LightL1');

                           LightR2 = Spawn(class'DKHeadlightCorona',self,,Location); 
                           AttachToBone(LightR2,'LightR2');

                           LightL2 = Spawn(class'DKHeadlightCorona',self,,Location); 
                           AttachToBone(LightL2,'LightL2');

                           BrakeR1 = Spawn(class'DKBrakelightCorona',self,,Location); 
                           AttachToBone(BrakeR1,'BrakeR1');

                           BrakeL1 = Spawn(class'DKBrakelightCorona',self,,Location); 
                           AttachToBone(BrakeL1,'BrakeL1');

                           ProjectR1 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           AttachToBone(ProjectR1,'LightR1');

                           ProjectL1 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           AttachToBone(ProjectL1,'LightL1');

                           ProjectR2 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           AttachToBone(ProjectR2,'LightR2');

                           ProjectL2 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           AttachToBone(ProjectL2,'LightL2'); 
}

function DriverLeft()
{
	                 LightR1.Destroy();
	                 LightL1.Destroy();
	                 LightR2.Destroy();
	                 LightL2.Destroy();

	                 BrakeR1.Destroy();
	                 BrakeL1.Destroy();

	                 ProjectR1.Destroy();
	                 ProjectL1.Destroy();
	                 ProjectR2.Destroy();
	                 ProjectL2.Destroy();

    Super.DriverLeft();
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
Vector momentum, class<DamageType> damageType)
{
	if ( (Health <= 0.75*HealthMax) && (EngineSmoke1 == none) )
	{
	EngineSmoke1 = spawn( class'UberSoldierVehicles.FX_EngineSmoke' , self);
	if (EngineSmoke1 != none)
	AttachToBone(EngineSmoke1,'Engine1');
	}

	if ( (Health <= 0.65*HealthMax) && (EngineSmoke2 == none) )
	{
	EngineSmoke2 = spawn( class'UberSoldierVehicles.FX_EngineSmoke' , self);
	if (EngineSmoke2 != none)
	AttachToBone(EngineSmoke2,'Engine2');
	}

	if ( (Health <= 0.45*HealthMax) && (EngineFire1 == none) )
	{
	EngineFire1 = spawn( class'UberSoldierVehicles.FX_EngineFire' , self);
	if (EngineFire1 != none)
	AttachToBone(EngineFire1,'Engine1');
	}

	if ( (Health <= 0.35*HealthMax) && (EngineFire2 == none) )
	{
	EngineFire2 = spawn( class'UberSoldierVehicles.FX_EngineFire' , self);
	if (EngineFire2 != none)
	AttachToBone(EngineFire2,'Engine2');
	}

	if ( (Health <= 0.30*HealthMax) && (DamageL1 == none) )
	{
	DamageL1 = spawn( class'UberSoldierVehicles.FX_EngineFireL' , self);
	if (DamageL1 != none)
	AttachToBone(DamageL1,'EngineL1');
	}

	if ( (Health <= 0.30*HealthMax) && (DamageR1 == none) )
	{
	DamageR1 = spawn( class'UberSoldierVehicles.FX_EngineFireR' , self);
	if (DamageR1 != none)
	AttachToBone(DamageR1,'EngineR1');
	}

	if ( (Health <= 0.25*HealthMax) && (DamageL2 == none) )
	{
	DamageL2 = spawn( class'UberSoldierVehicles.FX_EngineFireL' , self);
	if (DamageL2 != none)
	AttachToBone(DamageL2,'EngineL2');
	}

	if ( (Health <= 0.25*HealthMax) && (DamageR2 == none) )
	{
	DamageR2 = spawn( class'UberSoldierVehicles.FX_EngineFireR' , self);
	if (DamageR2 != none)
	AttachToBone(DamageR2,'EngineR2');
	}

           super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
}

//-----------------------------------------------------------//
// Pre Destroyed V 1.0                                       //
//-----------------------------------------------------------//

simulated function DestroyAppearance()
{
         Spawn( class'FX_TankDestroy_CrunkA',,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'FX_TankDestroy_CrunkB',,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'FX_TankDestroy_CrunkA',,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'FX_TankDestroy_CrunkB',,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'FX_TankDestroy_Medium',,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'PROJ_TankExp',,,Location + (vect(0,0,0) << Rotation));

	Super.DestroyAppearance();
}

//-----------------------------------------------------------//
// Destroyed V 1.0                                           //
//-----------------------------------------------------------//

simulated function Destroyed()
{
	                 Korpus.Destroy();

	                 LightR1.Destroy();
	                 LightL1.Destroy();
	                 LightR2.Destroy();
	                 LightL2.Destroy();

	                 BrakeR1.Destroy();
	                 BrakeL1.Destroy();

	                 ProjectR1.Destroy();
	                 ProjectL1.Destroy();
	                 ProjectR2.Destroy();
	                 ProjectL2.Destroy();

	                 DamageL1.Destroy();
	                 DamageR1.Destroy();
	                 DamageL2.Destroy();
	                 DamageR2.Destroy();

	                 EngineSmoke1.Destroy();
	                 EngineSmoke2.Destroy();
	                 EngineFire1.Destroy();
	                 EngineFire2.Destroy();

	Super.Destroyed();
}

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Material'DKVehiclesTex.BattleMaster.BattleMaster_Def');
	L.AddPrecacheMaterial(Material'DKVehiclesTex.BattleMaster.BattleMaster_DefX');
	L.AddPrecacheMaterial(Material'DKVehiclesTex.BattleMaster.BattleMasterT_Def');
	L.AddPrecacheMaterial(Material'DKVehiclesTex.BattleMaster.BattleMasterT_DefX');

	L.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.BattleMaster.BattleMaster_X');
	L.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.BattleMaster.BattleMasterT_X');
	L.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.BattleMaster.BattleMaster_Coll');
	L.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.BattleMaster.BattleMasterT_Coll');

	L.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.Defender.TireL');
	L.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.Defender.TireR');
	L.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.TankShel');

    Super.StaticPrecache(L);
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Material'DKVehiclesTex.BattleMaster.BattleMaster_Def');
	Level.AddPrecacheMaterial(Material'DKVehiclesTex.BattleMaster.BattleMaster_DefX');
	Level.AddPrecacheMaterial(Material'DKVehiclesTex.BattleMaster.BattleMasterT_DefX');

	Super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.BattleMaster.BattleMaster_X');
	Level.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.BattleMaster.BattleMasterT_X');
	Level.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.BattleMaster.BattleMaster_Coll');
	Level.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.BattleMaster.BattleMasterT_Coll');

	Level.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.Defender.TireL');
	Level.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.Defender.TireR');
	Level.AddPrecacheStaticMesh(StaticMesh'DKVehiclesMesh.TankShel');

                Super.UpdatePrecacheStaticMeshes();
}

//-----------------------------------------------------------//
// Suspension V9.0                                           //
//-----------------------------------------------------------//

defaultproperties
{
     TreadVelocityScale=275.000000
     MaxGroundSpeed=500.000000
     MaxAirSpeed=2000.000000
     WheelSoftness=0.100000
     WheelPenScale=0.800000
     WheelAdhesion=1.000000
     WheelInertia=0.070000
     WheelLongFrictionFunc=(Points=((OutVal=0.999999),(InVal=100.000000,OutVal=2.000000),(InVal=200.000000,OutVal=3.000000),(InVal=10000000000.000000,OutVal=5.000000)))
     WheelLongSlip=0.001000
     WheelLatSlipFunc=(Points=((OutVal=0.005000),(InVal=100.000000),(InVal=200.000000),(InVal=10000000000.000000)))
     WheelLongFrictionScale=1.000000
     WheelLatFrictionScale=1.000000
     WheelHandbrakeSlip=0.750000
     WheelHandbrakeFriction=2.000000
     WheelSuspensionTravel=70.000000
     WheelSuspensionOffset=-60.000000
     WheelSuspensionMaxRenderTravel=70.000000
     FTScale=0.001000
     ChassisTorqueScale=0.300000
     MaxSteerAngleCurve=(Points=((OutVal=80.000000),(InVal=100.000000,OutVal=60.000000),(InVal=200.000000,OutVal=40.000000),(InVal=300.000000,OutVal=20.000000),(InVal=400.000000,OutVal=15.000000),(InVal=1000000000.000000,OutVal=10.000000)))
     TorqueCurve=(Points=((OutVal=10.000000),(InVal=500.000000,OutVal=5.000000),(InVal=1250.000000,OutVal=2.500000),(InVal=2500.000000,OutVal=1.000000)))
     GearRatios(0)=-0.500000
     GearRatios(1)=0.300000
     GearRatios(2)=0.450000
     GearRatios(3)=0.650000
     GearRatios(4)=0.800000
     TransRatio=0.100000
     ChangeUpPoint=2000.000000
     ChangeDownPoint=1000.000000
     LSDFactor=0.500000
     EngineBrakeFactor=0.000100
     MaxBrakeTorque=10.000000
     SteerSpeed=200.000000
     TurnDamping=35.000000
     StopThreshold=50.000000
     HandbrakeThresh=200.000000
     EngineInertia=0.100000
     IdleRPM=400.000000
     EngineRPMSoundRange=10000.000000
     SteerBoneName="SteeringWheel"
     SteerBoneAxis=AXIS_Z
     SteerBoneMaxAngle=90.000000
     DustSlipRate=1.000000
     DustSlipThresh=10.000000
     RevMeterScale=4000.000000
     AirPitchDamping=35.000000
     DriverWeapons(0)=(WeaponClass=Class'UberSoldierVehicles.BattleMasterT',WeaponBone="TurretCoords")
     RedSkin=Shader'DKVehiclesTex.BattleMaster.BattleMaster'
     BlueSkin=Shader'DKVehiclesTex.BattleMaster.BattleMaster'
     IdleSound=Sound'DKoppIISound.Engine.TankEngine10'
     StartUpSound=Sound'DKoppIISound.Engine.TankEngine10_up'
     ShutDownSound=Sound'DKoppIISound.Engine.TankEngine10_end'
     FireImpulse=(X=-300000.000000)
     AltFireImpulse=(X=-300000.000000)
     Begin Object Class=SVehicleWheel Name=RWheel1
         SteerType=VST_Steered
         BoneName="RWheel1"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         Softness=0.001000
         SupportBoneName="RSus1"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(0)=SVehicleWheel'UberSoldierVehicles.BattleMaster.RWheel1'

     Begin Object Class=SVehicleWheel Name=RWheel2
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RWheel2"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         SupportBoneName="RSus2"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(1)=SVehicleWheel'UberSoldierVehicles.BattleMaster.RWheel2'

     Begin Object Class=SVehicleWheel Name=RWheel3
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RWheel3"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         SupportBoneName="RSus3"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(2)=SVehicleWheel'UberSoldierVehicles.BattleMaster.RWheel3'

     Begin Object Class=SVehicleWheel Name=RWheel4
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RWheel4"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         SupportBoneName="RSus4"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(3)=SVehicleWheel'UberSoldierVehicles.BattleMaster.RWheel4'

     Begin Object Class=SVehicleWheel Name=RWheel5
         SteerType=VST_Steered
         BoneName="RWheel5"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         Softness=0.040000
         SupportBoneName="RSus5"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(4)=SVehicleWheel'UberSoldierVehicles.BattleMaster.RWheel5'

     Begin Object Class=SVehicleWheel Name=RWheel6
         SteerType=VST_Steered
         BoneName="RWheel6"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         Softness=0.001000
         SupportBoneName="RSus6"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(5)=SVehicleWheel'UberSoldierVehicles.BattleMaster.RWheel6'

     Begin Object Class=SVehicleWheel Name=RWheel7
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="RWheel7"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         SupportBoneName="RSus7"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(6)=SVehicleWheel'UberSoldierVehicles.BattleMaster.RWheel7'

     Begin Object Class=SVehicleWheel Name=Rwheel8
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="Rwheel8"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         SupportBoneName="RSus8"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(7)=SVehicleWheel'UberSoldierVehicles.BattleMaster.Rwheel8'

     Begin Object Class=SVehicleWheel Name=RWheel9
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="RWheel9"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         SupportBoneName="RSus9"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(8)=SVehicleWheel'UberSoldierVehicles.BattleMaster.RWheel9'

     Begin Object Class=SVehicleWheel Name=RWheel10
         SteerType=VST_Steered
         BoneName="RWheel10"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         Softness=0.040000
         SupportBoneName="RSus10"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(9)=SVehicleWheel'UberSoldierVehicles.BattleMaster.RWheel10'

     Begin Object Class=SVehicleWheel Name=LWheel1
         SteerType=VST_Steered
         BoneName="LWheel1"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         Softness=0.001000
         SupportBoneName="LSus1"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(10)=SVehicleWheel'UberSoldierVehicles.BattleMaster.LWheel1'

     Begin Object Class=SVehicleWheel Name=LWheel2
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="LWheel2"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         SupportBoneName="LSus2"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(11)=SVehicleWheel'UberSoldierVehicles.BattleMaster.LWheel2'

     Begin Object Class=SVehicleWheel Name=LWheel3
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="LWheel3"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         SupportBoneName="LSus3"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(12)=SVehicleWheel'UberSoldierVehicles.BattleMaster.LWheel3'

     Begin Object Class=SVehicleWheel Name=LWheel4
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="LWheel4"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         SupportBoneName="LSus4"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(13)=SVehicleWheel'UberSoldierVehicles.BattleMaster.LWheel4'

     Begin Object Class=SVehicleWheel Name=LWheel5
         SteerType=VST_Steered
         BoneName="LWheel5"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         Softness=0.040000
         SupportBoneName="LSus5"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(14)=SVehicleWheel'UberSoldierVehicles.BattleMaster.LWheel5'

     Begin Object Class=SVehicleWheel Name=LWheel6
         SteerType=VST_Steered
         BoneName="LWheel6"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         Softness=0.001000
         SupportBoneName="LSus6"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(15)=SVehicleWheel'UberSoldierVehicles.BattleMaster.LWheel6'

     Begin Object Class=SVehicleWheel Name=LWheel7
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="LWheel7"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         SupportBoneName="LSus7"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(16)=SVehicleWheel'UberSoldierVehicles.BattleMaster.LWheel7'

     Begin Object Class=SVehicleWheel Name=Lwheel8
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="Lwheel8"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         SupportBoneName="LSus8"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(17)=SVehicleWheel'UberSoldierVehicles.BattleMaster.Lwheel8'

     Begin Object Class=SVehicleWheel Name=LWheel9
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="LWheel9"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         SupportBoneName="LSus9"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(18)=SVehicleWheel'UberSoldierVehicles.BattleMaster.LWheel9'

     Begin Object Class=SVehicleWheel Name=LWheel10
         SteerType=VST_Steered
         BoneName="LWheel10"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=45.000000
         Softness=0.040000
         SupportBoneName="LSus10"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(19)=SVehicleWheel'UberSoldierVehicles.BattleMaster.LWheel10'

     VehicleMass=15.000000
     ExitPositions(0)=(Z=250.000000)
     ExitPositions(1)=(Z=250.000000)
     EntryRadius=400.000000
     FPCamPos=(X=-100.000000,Z=250.000000)
     FPCamViewOffset=(X=-100.000000)
     TPCamDistance=1050.000000
     TPCamLookat=(X=0.000000,Y=-200.000000,Z=0.000000)
     TPCamWorldOffset=(Z=280.000000)
     DriverDamageMult=0.001000
     VehiclePositionString="BattleMaster MK2"
     VehicleNameString="BattleMaster MK2"
     HealthMax=3000.000000
     Health=3000
     Mesh=SkeletalMesh'DKVehiclesAnim.BattleMaster'
     Skins(0)=Texture'DKVehiclesTex.Detail.invis'
     Skins(1)=Texture'DKVehiclesTex.ZTZ.ZTZ_Def'
     Skins(2)=Shader'DKVehiclesTex.Detail.T-62_trackS'
     Skins(3)=Texture'DKVehiclesTex.Detail.invis'
     Begin Object Class=KarmaParamsRBFull Name=KParams0
         KInertiaTensor(0)=20.000000
         KInertiaTensor(3)=30.000000
         KInertiaTensor(5)=48.000000
         KCOMOffset=(Z=-1.000000)
         KMass=20.000000
         KLinearDamping=0.000000
         KAngularDamping=0.000000
         KStartEnabled=True
         bKNonSphericalInertia=True
         KActorGravScale=1.200000
         KMaxSpeed=800.000000
         KMaxAngularSpeed=10000.000000
         bHighDetailOnly=False
         bClientOnly=False
         bKStayUpright=True
         bKAllowRotate=True
         bDestroyOnWorldPenetrate=True
         bDoSafetime=True
         KFriction=0.800000
         KRestitution=1.000000
         KImpactThreshold=500.000000
     End Object
     KParams=KarmaParamsRBFull'UberSoldierVehicles.BattleMaster.KParams0'

}
