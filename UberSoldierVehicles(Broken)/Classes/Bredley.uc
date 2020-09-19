//---------------//
// Super Bredley //
//---------------//
class Bredley extends DKVehicles;

var Deco_BredleyKorpus Korpus;

var Skel_Bredley_PanelAR PanelAR;
var Skel_Bredley_PanelAL PanelAL;

var Skel_Bredley_PanelBL PanelBL2;
var Skel_Bredley_PanelBL PanelBL3;
var Skel_Bredley_PanelBL PanelBL4;
var Skel_Bredley_PanelBL PanelBL5;
var Skel_Bredley_PanelBL PanelBL6;
var Skel_Bredley_PanelBL PanelBL7;

var Skel_Bredley_PanelBR PanelBR2;
var Skel_Bredley_PanelBR PanelBR3;
var Skel_Bredley_PanelBR PanelBR4;
var Skel_Bredley_PanelBR PanelBR5;
var Skel_Bredley_PanelBR PanelBR6;
var Skel_Bredley_PanelBR PanelBR7;

var Skel_Bredley_ReshotkaR ReshotkaR;
var Skel_Bredley_ReshotkaL ReshotkaL;

var FX_EngineSmoke EngineSmoke1;
var FX_EngineSmoke EngineSmoke2;

var FX_EngineFire EngineFire1;
var FX_EngineFire EngineFire2;

simulated function DrawHUD(Canvas Canvas)
{
        local Material BGMaterial;
       
        Super.DrawHUD(Canvas);
       
 
        BGMaterial = Texture'DKVehiclesTex.Ammo.Ammo50';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.85);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());

        BGMaterial = Texture'DKVehiclesTex.Ammo.IconAmmo50';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.75);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());
}

function PostBeginPlay()
{
	super.PostBeginPlay();

         Korpus = Spawn(class'Deco_BredleyKorpus',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Korpus,'TankHull');

         PanelAL = Spawn(class'Skel_Bredley_PanelAL',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelAL,'PanelAL');

         PanelAR = Spawn(class'Skel_Bredley_PanelAR',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelAR,'PanelAR');

         PanelBL2 = Spawn(class'Skel_Bredley_PanelBL',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelBL2,'PanelL2');

         PanelBL3 = Spawn(class'Skel_Bredley_PanelBL',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelBL3,'PanelL3');

         PanelBL4 = Spawn(class'Skel_Bredley_PanelBL',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelBL4,'PanelL4');

         PanelBL5 = Spawn(class'Skel_Bredley_PanelBL',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelBL5,'PanelL5');

         PanelBL6 = Spawn(class'Skel_Bredley_PanelBL',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelBL6,'PanelL6');

         PanelBL7 = Spawn(class'Skel_Bredley_PanelBL',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelBL7,'PanelL7');

         PanelBR2 = Spawn(class'Skel_Bredley_PanelBR',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelBR2,'PanelR2');

         PanelBR3 = Spawn(class'Skel_Bredley_PanelBR',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelBR3,'PanelR3');

         PanelBR4 = Spawn(class'Skel_Bredley_PanelBR',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelBR4,'PanelR4');

         PanelBR5 = Spawn(class'Skel_Bredley_PanelBR',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelBR5,'PanelR5');

         PanelBR6 = Spawn(class'Skel_Bredley_PanelBR',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelBR6,'PanelR6');

         PanelBR7 = Spawn(class'Skel_Bredley_PanelBR',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(PanelBR7,'PanelR7');


         ReshotkaL = Spawn(class'Skel_Bredley_ReshotkaL',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(ReshotkaL,'ReshotkaL');

         ReshotkaR = Spawn(class'Skel_Bredley_ReshotkaR',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(ReshotkaR,'ReshotkaR');
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
Vector momentum, class<DamageType> damageType)
{
	if ( (Health <= 0.70*HealthMax) && (EngineSmoke1 == none) )
	{
	EngineSmoke1 = spawn( class'UberSoldierVehicles.FX_EngineSmoke' , self);
	AttachToBone(EngineSmoke1,'Engine1');
	}

	if ( (Health <= 0.50*HealthMax) && (EngineSmoke2 == none) )
	{
	EngineSmoke2 = spawn( class'UberSoldierVehicles.FX_EngineSmoke' , self);
	AttachToBone(EngineSmoke2,'Engine1');
	}

	if ( (Health <= 0.60*HealthMax) && (EngineFire1 == none) )
	{
	EngineFire1 = spawn( class'UberSoldierVehicles.FX_EngineFire' , self);
	AttachToBone(EngineFire1,'Engine1');
	}

	if ( (Health <= 0.40*HealthMax) && (EngineFire2 == none) )
	{
	EngineFire2 = spawn( class'UberSoldierVehicles.FX_EngineFire' , self);
	AttachToBone(EngineFire2,'Engine2');
	}

           super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
}

simulated function DestroyAppearance()
{
         Spawn( class'FX_TankDestroy_CrunkA',,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'FX_TankDestroy_CrunkB',,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'FX_TankDestroy_Light',,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'PROJ_TankExp',,,Location + (vect(0,0,0) << Rotation));

	Super.DestroyAppearance();
}

simulated function Destroyed()
{
	                 Korpus.Destroy();

	                 PanelAR.Destroy();
	                 PanelBL2.Destroy();
	                 PanelBL3.Destroy();
	                 PanelBL4.Destroy();
	                 PanelBL5.Destroy();
	                 PanelBL6.Destroy();
	                 PanelBL7.Destroy();

	                 PanelAL.Destroy();
	                 PanelBR2.Destroy();
	                 PanelBR3.Destroy();
	                 PanelBR4.Destroy();
	                 PanelBR5.Destroy();
	                 PanelBR6.Destroy();
	                 PanelBR7.Destroy();

	                 ReshotkaR.Destroy();
	                 ReshotkaL.Destroy();

	                 EngineSmoke1.Destroy();
	                 EngineSmoke2.Destroy();

	                 EngineFire1.Destroy();
	                 EngineFire2.Destroy();

	Super.Destroyed();
}

//-----------------------------------------------------------//
// Suspension V9.0 Maximum realy                             //
//-----------------------------------------------------------//

defaultproperties
{
     TreadVelocityScale=275.000000
     MaxGroundSpeed=400.000000
     MaxAirSpeed=2000.000000
     WheelSoftness=0.080000
     WheelPenScale=0.800000
     WheelAdhesion=1.000000
     WheelInertia=0.070000
     WheelLongFrictionFunc=(Points=((OutVal=0.999999),(InVal=100.000000,OutVal=2.000000),(InVal=200.000000,OutVal=3.000000),(InVal=10000000000.000000,OutVal=5.000000)))
     WheelLongSlip=0.001000
     WheelLatSlipFunc=(Points=((OutVal=0.005000),(InVal=100.000000),(InVal=200.000000),(InVal=10000000000.000000)))
     WheelLongFrictionScale=0.500000
     WheelLatFrictionScale=1.000000
     WheelHandbrakeSlip=0.750000
     WheelHandbrakeFriction=2.000000
     WheelSuspensionTravel=55.000000
     WheelSuspensionOffset=-20.000000
     WheelSuspensionMaxRenderTravel=55.000000
     FTScale=0.001000
     ChassisTorqueScale=0.500000
     MaxSteerAngleCurve=(Points=((OutVal=80.000000),(InVal=100.000000,OutVal=60.000000),(InVal=200.000000,OutVal=40.000000),(InVal=300.000000,OutVal=25.000000),(InVal=400.000000,OutVal=15.000000),(InVal=2000.000000,OutVal=10.000000)))
     TorqueCurve=(Points=((OutVal=20.000000),(InVal=500.000000,OutVal=10.000000),(InVal=1000.000000,OutVal=5.000000),(InVal=1500.000000,OutVal=2.500000),(InVal=2000.000000,OutVal=1.000000)))
     GearRatios(0)=-0.500000
     GearRatios(1)=0.200000
     GearRatios(2)=0.350000
     GearRatios(3)=0.650000
     GearRatios(4)=1.000000
     TransRatio=0.100000
     ChangeUpPoint=2000.000000
     ChangeDownPoint=1000.000000
     LSDFactor=0.500000
     EngineBrakeFactor=0.000100
     MaxBrakeTorque=10.000000
     SteerSpeed=10000.000000
     TurnDamping=35.000000
     StopThreshold=10.000000
     HandbrakeThresh=200.000000
     EngineInertia=0.100000
     IdleRPM=500.000000
     EngineRPMSoundRange=10000.000000
     SteerBoneName="SteeringWheel"
     SteerBoneAxis=AXIS_Z
     SteerBoneMaxAngle=90.000000
     DustSlipRate=1.000000
     DustSlipThresh=10.000000
     RevMeterScale=4000.000000
     AirPitchDamping=35.000000
     DriverWeapons(0)=(WeaponClass=Class'UberSoldierVehicles.BredleyT',WeaponBone="TurretCoords")
     RedSkin=Shader'DKVehiclesTex.Bredley.Bredley'
     BlueSkin=Shader'DKVehiclesTex.Bredley.Bredley'
     IdleSound=Sound'DKoppIISound.Engine.TankEngine10'
     StartUpSound=Sound'DKoppIISound.Engine.TankEngine10_up'
     ShutDownSound=Sound'DKoppIISound.Engine.TankEngine10_end'
     FireImpulse=(X=-110000.000000)
     AltFireImpulse=(X=-110000.000000)
     Begin Object Class=SVehicleWheel Name=RWheel1
         SteerType=VST_Steered
         BoneName="RWheel1"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.000000
         SuspensionTravel=20.000000
         SuspensionOffset=-15.000000
         SuspensionMaxRenderTravel=20.000000
         SupportBoneName="RSus1"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(0)=SVehicleWheel'UberSoldierVehicles.Bredley.RWheel1'

     Begin Object Class=SVehicleWheel Name=RWheel2
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RWheel2"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.040000
         PenScale=0.800000
         SupportBoneName="RSus2"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(1)=SVehicleWheel'UberSoldierVehicles.Bredley.RWheel2'

     Begin Object Class=SVehicleWheel Name=RWheel3
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RWheel3"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         SupportBoneName="RSus3"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(2)=SVehicleWheel'UberSoldierVehicles.Bredley.RWheel3'

     Begin Object Class=SVehicleWheel Name=RWheel4
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RWheel4"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         SupportBoneName="RSus4"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(3)=SVehicleWheel'UberSoldierVehicles.Bredley.RWheel4'

     Begin Object Class=SVehicleWheel Name=RWheel5
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="RWheel5"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         SupportBoneName="RSus5"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(4)=SVehicleWheel'UberSoldierVehicles.Bredley.RWheel5'

     Begin Object Class=SVehicleWheel Name=RWheel6
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="RWheel6"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         SupportBoneName="RSus6"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(5)=SVehicleWheel'UberSoldierVehicles.Bredley.RWheel6'

     Begin Object Class=SVehicleWheel Name=RWheel7
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="RWheel7"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.040000
         PenScale=0.800000
         SupportBoneName="RSus7"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(6)=SVehicleWheel'UberSoldierVehicles.Bredley.RWheel7'

     Begin Object Class=SVehicleWheel Name=Rwheel8
         SteerType=VST_Steered
         BoneName="Rwheel8"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         Softness=0.000000
         SuspensionTravel=20.000000
         SuspensionOffset=-20.000000
         SuspensionMaxRenderTravel=20.000000
         SupportBoneName="RSus8"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(7)=SVehicleWheel'UberSoldierVehicles.Bredley.Rwheel8'

     Begin Object Class=SVehicleWheel Name=LWheel1
         SteerType=VST_Steered
         BoneName="LWheel1"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.000000
         SuspensionTravel=20.000000
         SuspensionOffset=-15.000000
         SuspensionMaxRenderTravel=20.000000
         SupportBoneName="LSus1"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(8)=SVehicleWheel'UberSoldierVehicles.Bredley.LWheel1'

     Begin Object Class=SVehicleWheel Name=LWheel2
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="LWheel2"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.040000
         PenScale=0.800000
         SupportBoneName="LSus2"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(9)=SVehicleWheel'UberSoldierVehicles.Bredley.LWheel2'

     Begin Object Class=SVehicleWheel Name=LWheel3
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="LWheel3"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         SupportBoneName="LSus3"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(10)=SVehicleWheel'UberSoldierVehicles.Bredley.LWheel3'

     Begin Object Class=SVehicleWheel Name=LWheel4
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="LWheel4"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         SupportBoneName="LSus4"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(11)=SVehicleWheel'UberSoldierVehicles.Bredley.LWheel4'

     Begin Object Class=SVehicleWheel Name=LWheel5
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="LWheel5"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         SupportBoneName="LSus5"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(12)=SVehicleWheel'UberSoldierVehicles.Bredley.LWheel5'

     Begin Object Class=SVehicleWheel Name=LWheel6
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="LWheel6"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         SupportBoneName="LSus6"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(13)=SVehicleWheel'UberSoldierVehicles.Bredley.LWheel6'

     Begin Object Class=SVehicleWheel Name=LWheel7
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="LWheel7"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.040000
         PenScale=0.800000
         SupportBoneName="LSus7"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(14)=SVehicleWheel'UberSoldierVehicles.Bredley.LWheel7'

     Begin Object Class=SVehicleWheel Name=Lwheel8
         SteerType=VST_Steered
         BoneName="Lwheel8"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         Softness=0.000000
         SuspensionTravel=20.000000
         SuspensionOffset=-20.000000
         SuspensionMaxRenderTravel=20.000000
         SupportBoneName="LSus8"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(15)=SVehicleWheel'UberSoldierVehicles.Bredley.Lwheel8'

     VehicleMass=10.000000
     ExitPositions(0)=(Y=-200.000000,Z=100.000000)
     ExitPositions(1)=(Y=200.000000,Z=100.000000)
     EntryRadius=600.000000
     FPCamPos=(X=25.000000,Z=250.000000)
     FPCamViewOffset=(X=-100.000000)
     TPCamDistance=650.000000
     TPCamLookat=(X=0.000000,Y=-200.000000,Z=0.000000)
     TPCamWorldOffset=(Z=280.000000)
     VehiclePositionString="Bredley"
     VehicleNameString="Bredley"
     HealthMax=1200.000000
     Health=1200
     Mesh=SkeletalMesh'DKVehiclesAnim.Bredley'
     Skins(0)=Texture'DKVehiclesTex.Detail.invis'
     Skins(1)=Texture'DKVehiclesTex.ZTZ.ZTZ_Def'
     Skins(2)=Shader'DKVehiclesTex.Detail.T-62_trackS'
     Skins(3)=Texture'DKVehiclesTex.Detail.invis'
     Skins(4)=Texture'DKVehiclesTex.Detail.invis'
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
     KParams=KarmaParamsRBFull'UberSoldierVehicles.Bredley.KParams0'

}
