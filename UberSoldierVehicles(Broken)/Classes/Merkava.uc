//---------------//
// Super Merkava //
//---------------//
class Merkava extends DKVehicles;

var Deco_MerkavaKorpus Korpus;

var Skel_Merkava_PanelR1 PanelR1;
var Skel_Merkava_PanelL1 PanelL1;
var Skel_Merkava_PanelR2 PanelR2;
var Skel_Merkava_PanelL2 PanelL2;

var Skel_Merkava_PanelR0 PanelRA;
var Skel_Merkava_PanelR00 PanelRB;
var Skel_Merkava_PanelR0 PanelRC;
var Skel_Merkava_PanelR00 PanelRD;
var Skel_Merkava_PanelR0 PanelRE;
var Skel_Merkava_PanelR00 PanelRF;

var Skel_Merkava_PanelL0 PanelLA;
var Skel_Merkava_PanelL00 PanelLB;
var Skel_Merkava_PanelL0 PanelLC;
var Skel_Merkava_PanelL00 PanelLD;
var Skel_Merkava_PanelL0 PanelLE;
var Skel_Merkava_PanelL00 PanelLF;

var Skel_Merkava_PanelR9 PanelR9;
var Skel_Merkava_PanelL9 PanelL9;

var DKBrakelightCorona BrakeR1;
var DKBrakelightCorona BrakeL1;

simulated function DrawHUD(Canvas Canvas)
{
        local Material BGMaterial;
       
        Super.DrawHUD(Canvas);
       
 
        BGMaterial = Texture'DKVehiclesTex.Ammo.Ammo95';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.85);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());

        BGMaterial = Texture'DKVehiclesTex.Ammo.IconAmmo90';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.80);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());
}

function PostBeginPlay()
{
	super.PostBeginPlay();

         Korpus = Spawn(class'Deco_MerkavaKorpus',self,, Location + (vect(10,0,0) << Rotation)); 
       if( !AttachToBone(Korpus,'TankHull') ) 
       { 
               Korpus.Destroy(); 
                         return; 
       }

         PanelR1 = Spawn(class'Skel_Merkava_PanelR1',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelR1,'PanelR1') ) 
       { 
               PanelR1.Destroy(); 
                         return; 
       }

         PanelL1 = Spawn(class'Skel_Merkava_PanelL1',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelL1,'PanelL1') ) 
       { 
               PanelL1.Destroy(); 
                         return; 
       }

         PanelR2 = Spawn(class'Skel_Merkava_PanelR2',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelR2,'PanelR2') ) 
       { 
               PanelR2.Destroy(); 
                         return; 
       }

         PanelL2 = Spawn(class'Skel_Merkava_PanelL2',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelL2,'PanelL2') ) 
       { 
               PanelL2.Destroy(); 
                         return; 
       }

         PanelRA = Spawn(class'Skel_Merkava_PanelR0',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelRA,'PanelR3') ) 
       { 
               PanelRA.Destroy(); 
                         return; 
       }

         PanelRB = Spawn(class'Skel_Merkava_PanelR00',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelRB,'PanelR4') ) 
       { 
               PanelRB.Destroy(); 
                         return; 
       }

         PanelRC = Spawn(class'Skel_Merkava_PanelR0',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelRC,'PanelR5') ) 
       { 
               PanelRC.Destroy(); 
                         return; 
       }

         PanelRD = Spawn(class'Skel_Merkava_PanelR00',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelRD,'PanelR6') ) 
       { 
               PanelRD.Destroy(); 
                         return; 
       }

         PanelRE = Spawn(class'Skel_Merkava_PanelR0',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelRE,'PanelR7') ) 
       { 
               PanelRE.Destroy(); 
                         return; 
       }

         PanelRF = Spawn(class'Skel_Merkava_PanelR00',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelRF,'PanelR8') ) 
       { 
               PanelRF.Destroy(); 
                         return; 
       }

         PanelLA = Spawn(class'Skel_Merkava_PanelL0',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelLA,'PanelL3') ) 
       { 
               PanelLA.Destroy(); 
                         return; 
       }

         PanelLB = Spawn(class'Skel_Merkava_PanelL00',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelLB,'PanelL4') ) 
       { 
               PanelLB.Destroy(); 
                         return; 
       }

         PanelLC = Spawn(class'Skel_Merkava_PanelL0',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelLC,'PanelL5') ) 
       { 
               PanelLC.Destroy(); 
                         return; 
       }

         PanelLD = Spawn(class'Skel_Merkava_PanelL00',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelLD,'PanelL6') ) 
       { 
               PanelLD.Destroy(); 
                         return; 
       }

         PanelLE = Spawn(class'Skel_Merkava_PanelL0',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelLE,'PanelL7') ) 
       { 
               PanelLE.Destroy(); 
                         return; 
       }
 
         PanelLF = Spawn(class'Skel_Merkava_PanelL00',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelLF,'PanelL8') ) 
       { 
               PanelLF.Destroy(); 
                         return; 
       }

         PanelR9 = Spawn(class'Skel_Merkava_PanelR9',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelR9,'PanelR9') ) 
       { 
               PanelR9.Destroy(); 
                         return; 
       }

         PanelL9 = Spawn(class'Skel_Merkava_PanelL9',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(PanelL9,'PanelL9') ) 
       { 
               PanelL9.Destroy(); 
                         return; 
       }
}

//-----------------------------------------------------------//
// Enter Tank V 1.0                                          //
//-----------------------------------------------------------//

function KDriverEnter(Pawn p)
{
    Super.KDriverEnter(p);

    SVehicleUpdateParams();


                           BrakeR1 = Spawn(class'DKBrakelightCorona',self,,Location); 
                           if( !AttachToBone(BrakeR1,'BrakeR1') ) 
       { 
                                                                BrakeR1.Destroy(); 
       }

                           BrakeL1 = Spawn(class'DKBrakelightCorona',self,,Location); 
                           if( !AttachToBone(BrakeL1,'BrakeL1') ) 
       { 
                                                                BrakeL1.Destroy(); 
       }
}

//-----------------------------------------------------------//
// Exit Tank V 1.0                                           //
//-----------------------------------------------------------//       

function DriverLeft()
{
	    BrakeR1.Destroy();
	    BrakeL1.Destroy();

    Super.DriverLeft();
}

//-----------------------------------------------------------//
// Pre Destroyed V 2.0                                       //
//-----------------------------------------------------------//

simulated function DestroyAppearance()
{
         Spawn( class'FX_TankDestroy_CrunkA',self,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'FX_TankDestroy_CrunkB',self,,Location + (vect(0,0,0) << Rotation));

	Super.DestroyAppearance();
}

simulated function Destroyed()
{
	    Korpus.Destroy();

	    PanelR1.Destroy();
	    PanelR2.Destroy();

	    PanelL1.Destroy();
	    PanelL2.Destroy();

	    PanelRA.Destroy();
	    PanelRB.Destroy();
	    PanelRC.Destroy();
	    PanelRD.Destroy();
	    PanelRE.Destroy();
	    PanelRF.Destroy();

	    PanelLA.Destroy();
	    PanelLB.Destroy();
	    PanelLC.Destroy();
	    PanelLD.Destroy();
	    PanelLE.Destroy();
	    PanelLF.Destroy();

	    PanelR9.Destroy();
	    PanelL9.Destroy();


	    BrakeR1.Destroy();	
	    BrakeL1.Destroy();

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
     DriverWeapons(0)=(WeaponClass=Class'UberSoldierVehicles.MerkavaT',WeaponBone="TurretCoords")
     RedSkin=Shader'DKVehiclesTex.Merkava.Merkava'
     BlueSkin=Shader'DKVehiclesTex.Merkava.Merkava'
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
     Wheels(0)=SVehicleWheel'UberSoldierVehicles.Merkava.RWheel1'

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
     Wheels(1)=SVehicleWheel'UberSoldierVehicles.Merkava.RWheel2'

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
     Wheels(2)=SVehicleWheel'UberSoldierVehicles.Merkava.RWheel3'

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
     Wheels(3)=SVehicleWheel'UberSoldierVehicles.Merkava.RWheel4'

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
     Wheels(4)=SVehicleWheel'UberSoldierVehicles.Merkava.RWheel5'

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
     Wheels(5)=SVehicleWheel'UberSoldierVehicles.Merkava.RWheel6'

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
     Wheels(6)=SVehicleWheel'UberSoldierVehicles.Merkava.RWheel7'

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
     Wheels(7)=SVehicleWheel'UberSoldierVehicles.Merkava.Rwheel8'

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
     Wheels(8)=SVehicleWheel'UberSoldierVehicles.Merkava.LWheel1'

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
     Wheels(9)=SVehicleWheel'UberSoldierVehicles.Merkava.LWheel2'

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
     Wheels(10)=SVehicleWheel'UberSoldierVehicles.Merkava.LWheel3'

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
     Wheels(11)=SVehicleWheel'UberSoldierVehicles.Merkava.LWheel4'

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
     Wheels(12)=SVehicleWheel'UberSoldierVehicles.Merkava.LWheel5'

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
     Wheels(13)=SVehicleWheel'UberSoldierVehicles.Merkava.LWheel6'

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
     Wheels(14)=SVehicleWheel'UberSoldierVehicles.Merkava.LWheel7'

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
     Wheels(15)=SVehicleWheel'UberSoldierVehicles.Merkava.Lwheel8'

     VehicleMass=10.000000
     ExitPositions(0)=(Y=-200.000000,Z=100.000000)
     ExitPositions(1)=(Y=200.000000,Z=100.000000)
     EntryRadius=300.000000
     FPCamPos=(X=25.000000,Z=250.000000)
     FPCamViewOffset=(X=20.000000)
     TPCamDistance=1150.000000
     TPCamLookat=(X=0.000000,Y=-200.000000,Z=0.000000)
     TPCamWorldOffset=(Z=280.000000)
     VehiclePositionString="Merkava"
     VehicleNameString="Merkava"
     HealthMax=2200.000000
     Health=2200
     Mesh=SkeletalMesh'DKVehiclesAnim.Merkava'
     Skins(0)=Shader'DKVehiclesTex.Merkava.Merkava'
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
     KParams=KarmaParamsRBFull'UberSoldierVehicles.Merkava.KParams0'

}
