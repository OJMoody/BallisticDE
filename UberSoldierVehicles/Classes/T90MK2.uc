//--------//
// T90MK2 //
//--------//
class T90MK2 extends DKVehicles;

var Deco_T90MK2Korpus Korpus;

var Skel_T90MK2_FlapL FlapL;
var Skel_T90MK2_FlapR FlapR;

var Skel_T90MK2_Flap1 Flap1;
var Skel_T90MK2_Flap2 Flap2;
var Skel_T90MK2_Flap3 Flap3;
var Skel_T90MK2_Flap4 Flap4;
var Skel_T90MK2_Flap5 Flap5;
var Skel_T90MK2_Flap6 Flap6;
var Skel_T90MK2_Flap7 Flap7;
var Skel_T90MK2_Flap8 Flap8;
var Skel_T90MK2_Flap9 Flap9;
var Skel_T90MK2_Flap10 Flap10;

var FX_EngineSmoke EngineSmoke1;
var FX_EngineSmoke EngineSmoke2;
var FX_EngineSmoke EngineSmoke3;

var FX_EngineFire EngineFire1;
var FX_EngineFire EngineFire2;
var FX_EngineFire EngineFire3;

//-----------------------------------------------------------//
// FUCK HUD V 1.0                                            //
//-----------------------------------------------------------//

simulated function DrawHUD(Canvas Canvas)
{
        local Material BGMaterial;
       
        Super.DrawHUD(Canvas);
       
	if ( Level.NetMode != NM_DedicatedServer)
	{
        BGMaterial = Texture'DKVehiclesTex.Ammo.Ammo76';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.85);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());

        BGMaterial = Texture'DKVehiclesTex.Ammo.IconAmmo76';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.75);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());
	}
}

//-----------------------------------------------------------//
// Add Tank Aktiv Armor V 2.0                                           //
//-----------------------------------------------------------//

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	if ( Level.NetMode != NM_DedicatedServer)
	{
         Korpus = Spawn(class'Deco_T90MK2Korpus',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Korpus,'TankHull');

         FlapR = Spawn(class'Skel_T90MK2_FlapR',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(FlapR,'FlapR');
         FlapL = Spawn(class'Skel_T90MK2_FlapL',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(FlapL,'FlapL');

         Flap1 = Spawn(class'Skel_T90MK2_Flap1',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Flap1,'Flap1');
         Flap2 = Spawn(class'Skel_T90MK2_Flap2',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Flap2,'Flap2');
         Flap3 = Spawn(class'Skel_T90MK2_Flap3',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Flap3,'Flap3');
         Flap4 = Spawn(class'Skel_T90MK2_Flap4',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Flap4,'Flap4');
         Flap5 = Spawn(class'Skel_T90MK2_Flap5',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Flap5,'Flap5');
         Flap6 = Spawn(class'Skel_T90MK2_Flap6',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Flap6,'Flap6');
         Flap7 = Spawn(class'Skel_T90MK2_Flap7',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Flap7,'Flap7');
         Flap8 = Spawn(class'Skel_T90MK2_Flap8',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Flap8,'Flap8');
         Flap9 = Spawn(class'Skel_T90MK2_Flap9',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Flap9,'Flap9');
         Flap10 = Spawn(class'Skel_T90MK2_Flap10',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Flap10,'Flap10');
	}
}

//-----------------------------------------------------------//
// Enter Tank V 1.0                                          //
//-----------------------------------------------------------//

simulated function KDriverEnter(Pawn p)
{
    Super.KDriverEnter(p);

    SVehicleUpdateParams();
}

//-----------------------------------------------------------//
// Exit Tank V 1.0                                           //
//-----------------------------------------------------------//       

simulated function DriverLeft()
{
    Super.DriverLeft();
}

//-----------------------------------------------------------//
// Damaged Tank V 1.0                                        //
//-----------------------------------------------------------//

simulated function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
Vector momentum, class<DamageType> damageType)
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
	if ( (Health <= 0.75*HealthMax) && (EngineSmoke1 == none) )
	{
	EngineSmoke1 = spawn( class'UberSoldierVehicles.FX_EngineSmoke' , self);
	if (EngineSmoke1 != none)
	AttachToBone(EngineSmoke1,'EngineFire1');
	}

	if ( (Health <= 0.55*HealthMax) && (EngineSmoke2 == none) )
	{
	EngineSmoke2 = spawn( class'UberSoldierVehicles.FX_EngineSmoke' , self);
	if (EngineSmoke2 != none)
	AttachToBone(EngineSmoke2,'EngineFire1');
	}

	if ( (Health <= 0.35*HealthMax) && (EngineSmoke3 == none) )
	{
	EngineSmoke3 = spawn( class'UberSoldierVehicles.FX_EngineSmoke' , self);
	if (EngineSmoke3 != none)
	AttachToBone(EngineSmoke3,'EngineFire1');
	}

	if ( (Health <= 0.65*HealthMax) && (EngineFire1 == none) )
	{
	EngineFire1 = spawn( class'UberSoldierVehicles.FX_EngineFire' , self);
	if (EngineFire1 != none)
	AttachToBone(EngineFire1,'EngineFire1');
	}

	if ( (Health <= 0.45*HealthMax) && (EngineFire2 == none) )
	{
	EngineFire2 = spawn( class'UberSoldierVehicles.FX_EngineFire' , self);
	if (EngineFire2 != none)
	AttachToBone(EngineFire2,'EngineFire2');
	}

	if ( (Health <= 0.25*HealthMax) && (EngineFire3 == none) )
	{
	EngineFire3 = spawn( class'UberSoldierVehicles.FX_EngineFire' , self);
	if (EngineFire3 != none)
	AttachToBone(EngineFire3,'EngineFire3');
	}
	}

           super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
}

//-----------------------------------------------------------//
// Pre Destroyed V 1.0                                       //
//-----------------------------------------------------------//

simulated function DestroyAppearance()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
         Spawn( class'FX_TankDestroy_CrunkA',,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'FX_TankDestroy_CrunkB',,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'FX_TankDestroy_Medium',,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'PROJ_TankExp',,,Location + (vect(0,0,0) << Rotation));
	}

	Super.DestroyAppearance();
}

//-----------------------------------------------------------//
// Destroyed V 1.0                                           //
//-----------------------------------------------------------//

simulated function Destroyed()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
	    Korpus.Destroy();

	    FlapR.Destroy();
	    FlapL.Destroy();

	    Flap1.Destroy();
	    Flap2.Destroy();
	    Flap3.Destroy();
	    Flap4.Destroy();
	    Flap5.Destroy();
	    Flap6.Destroy();
	    Flap7.Destroy();
	    Flap8.Destroy();
	    Flap9.Destroy();
	    Flap10.Destroy();

	    EngineSmoke1.Destroy();
	    EngineSmoke2.Destroy();
	    EngineSmoke3.Destroy();

	    EngineFire1.Destroy();
	    EngineFire2.Destroy();
	    EngineFire3.Destroy();
	}

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
     ExhaustBones(0)="EngineSmoke"
     WheelSoftness=0.020000
     WheelPenScale=0.500000
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
     DriverWeapons(0)=(WeaponClass=Class'UberSoldierVehicles.T90MK2T',WeaponBone="TurretCoords")
     RedSkin=Shader'DKVehiclesTex.T90.T90MK2'
     BlueSkin=Shader'DKVehiclesTex.T90.T90MK2'
     IdleSound=Sound'DKoppIISound.Engine.TankEngine10'
     StartUpSound=Sound'DKoppIISound.Engine.TankEngine10_up'
     ShutDownSound=Sound'DKoppIISound.Engine.TankEngine10_end'
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
     Wheels(0)=SVehicleWheel'UberSoldierVehicles.T90MK2.RWheel1'

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
     Wheels(1)=SVehicleWheel'UberSoldierVehicles.T90MK2.RWheel2'

     Begin Object Class=SVehicleWheel Name=RWheel3
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RWheel3"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.040000
         PenScale=0.800000
         SupportBoneName="RSus3"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(2)=SVehicleWheel'UberSoldierVehicles.T90MK2.RWheel3'

     Begin Object Class=SVehicleWheel Name=RWheel4
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RWheel4"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.000000
         SuspensionTravel=20.000000
         SuspensionOffset=-20.000000
         SuspensionMaxRenderTravel=20.000000
         SupportBoneName="RSus4"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(3)=SVehicleWheel'UberSoldierVehicles.T90MK2.RWheel4'

     Begin Object Class=SVehicleWheel Name=RWheel5
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="RWheel5"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.000000
         SuspensionTravel=20.000000
         SuspensionOffset=-15.000000
         SuspensionMaxRenderTravel=20.000000
         SupportBoneName="RSus5"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(4)=SVehicleWheel'UberSoldierVehicles.T90MK2.RWheel5'

     Begin Object Class=SVehicleWheel Name=RWheel6
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="RWheel6"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.040000
         PenScale=0.800000
         SupportBoneName="RSus6"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(5)=SVehicleWheel'UberSoldierVehicles.T90MK2.RWheel6'

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
     Wheels(6)=SVehicleWheel'UberSoldierVehicles.T90MK2.RWheel7'

     Begin Object Class=SVehicleWheel Name=Rwheel8
         SteerType=VST_Steered
         BoneName="Rwheel8"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.000000
         SuspensionTravel=20.000000
         SuspensionOffset=-20.000000
         SuspensionMaxRenderTravel=20.000000
         SupportBoneName="RSus8"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(7)=SVehicleWheel'UberSoldierVehicles.T90MK2.Rwheel8'

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
     Wheels(8)=SVehicleWheel'UberSoldierVehicles.T90MK2.LWheel1'

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
     Wheels(9)=SVehicleWheel'UberSoldierVehicles.T90MK2.LWheel2'

     Begin Object Class=SVehicleWheel Name=LWheel3
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="LWheel3"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         Softness=0.040000
         PenScale=0.800000
         SupportBoneName="LSus3"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(10)=SVehicleWheel'UberSoldierVehicles.T90MK2.LWheel3'

     Begin Object Class=SVehicleWheel Name=LWheel4
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="LWheel4"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.000000
         SuspensionTravel=20.000000
         SuspensionOffset=-20.000000
         SuspensionMaxRenderTravel=20.000000
         SupportBoneName="LSus4"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(11)=SVehicleWheel'UberSoldierVehicles.T90MK2.LWheel4'

     Begin Object Class=SVehicleWheel Name=LWheel5
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="LWheel5"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.000000
         SuspensionTravel=20.000000
         SuspensionOffset=-15.000000
         SuspensionMaxRenderTravel=20.000000
         SupportBoneName="LSus5"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(12)=SVehicleWheel'UberSoldierVehicles.T90MK2.LWheel5'

     Begin Object Class=SVehicleWheel Name=LWheel6
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="LWheel6"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.040000
         PenScale=0.800000
         SupportBoneName="LSus6"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(13)=SVehicleWheel'UberSoldierVehicles.T90MK2.LWheel6'

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
     Wheels(14)=SVehicleWheel'UberSoldierVehicles.T90MK2.LWheel7'

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
     Wheels(15)=SVehicleWheel'UberSoldierVehicles.T90MK2.Lwheel8'

     VehicleMass=10.000000
     ExitPositions(0)=(Z=250.000000)
     ExitPositions(1)=(Z=250.000000)
     EntryRadius=800.000000
     FPCamPos=(X=25.000000,Z=250.000000)
     FPCamViewOffset=(X=-100.000000)
     TPCamDistance=850.000000
     TPCamLookat=(X=0.000000,Y=-200.000000,Z=0.000000)
     TPCamWorldOffset=(Z=280.000000)
     VehiclePositionString="T90MK2"
     VehicleNameString="T90MK2"
     HealthMax=2400.000000
     Health=2400
     Mesh=SkeletalMesh'DKVehiclesAnim.T90'
     Skins(0)=Shader'DKVehiclesTex.T90.T90MK2'
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
     KParams=KarmaParamsRBFull'UberSoldierVehicles.T90MK2.KParams0'

}
