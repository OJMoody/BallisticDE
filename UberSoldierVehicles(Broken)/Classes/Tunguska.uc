//----------------//
// Super Tunguska //
//----------------//
class Tunguska extends DKVehicles;

var Deco_DefenderTurret Turret;
var Deco_TunguskaKorpus Korpus;

var DKHeadlightCorona LightL1;
var DKHeadlightCorona LightR1;
var DKHeadlightCorona LightL2;
var DKHeadlightCorona LightR2;

var DKHeadlightProjector ProjectR1;
var DKHeadlightProjector ProjectL1;
var DKHeadlightProjector ProjectR2;
var DKHeadlightProjector ProjectL2;

var DKBrakelightCorona BrakeR1;
var DKBrakelightCorona BrakeR2;
var DKBrakelightCorona BrakeR3;
var DKBrakelightCorona BrakeL1;
var DKBrakelightCorona BrakeL2;
var DKBrakelightCorona BrakeL3;

var FX_DecoTankDamFireL DamageL1;
var FX_DecoTankDamFireR DamageR1;
var FX_DecoTankDamFireL DamageL2;
var FX_DecoTankDamFireR DamageR2;
var FX_DecoTankDamFireL DamageL3;
var FX_DecoTankDamFireR DamageR3;

simulated function DrawHUD(Canvas Canvas)
{
    local Material BGMaterial;
       
        Super.DrawHUD(Canvas);

        BGMaterial = Texture'DKVehiclesTex.Ammo.Ammo90RAD';

        Canvas.SetPos(Canvas.SizeX*0.00, Canvas.SizeY*0.85);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());

        BGMaterial = Texture'DKVehiclesTex.Ammo.IconAmmo90';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.78);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());
}

simulated function PostNetBeginPlay()
{
    Super.PostNetBeginPlay();

    if (Role == ROLE_Authority)
	{

		if (Weapons.Length == 2 && ONSLinkableWeapon(Weapons[0]) != None)
    {
        ONSLinkableWeapon(Weapons[0]).ChildWeapon = Weapons[1];

	    }

    }
}

function PostBeginPlay()
{
	super.PostBeginPlay();

       if (Korpus==none) 
       { 
         Korpus = Spawn(class'Deco_TunguskaKorpus',self,, Location + (vect(20,0,0) << Rotation)); 
       if( !AttachToBone(Korpus,'TankHull') ) 
       { 
               Korpus.Destroy(); 
                         return; 
       }
       }
}

function KDriverEnter(Pawn p)
{
    Super.KDriverEnter( P );

    Weapons[1].bActive = True;

    SVehicleUpdateParams();

       if (LightL1==none) 
       { 
         LightL1 = Spawn(class'DKHeadlightCorona',self,,Location); 
       if( !AttachToBone(LightL1,'LightL1') ) 
       { 
               LightL1.Destroy(); 
                         return; 
       }
       }

       if (LightL2==none) 
       { 
         LightL2 = Spawn(class'DKHeadlightCorona',self,,Location); 
       if( !AttachToBone(LightL2,'LightL2') ) 
       { 
               LightL2.Destroy(); 
                         return; 
       }
       }

       if (LightR1==none) 
       { 
         LightR1 = Spawn(class'DKHeadlightCorona',self,,Location); 
       if( !AttachToBone(LightR1,'LightR1') ) 
       { 
               LightR1.Destroy(); 
                         return; 
       }
       }

       if (LightR2==none) 
       { 
         LightR2 = Spawn(class'DKHeadlightCorona',self,,Location); 
       if( !AttachToBone(LightR2,'LightR2') ) 
       { 
               LightR2.Destroy(); 
                         return; 
       }
       }

       if (ProjectR1==none) 
       { 
                           ProjectR1 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectR1,'LightR1') ) 
       { 
                                                                ProjectR1.Destroy(); 
                                                                                             return; 
       }
    }

       if (ProjectL1==none) 
       { 
                           ProjectL1 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectL1,'LightL1') ) 
       { 
                                                                ProjectL1.Destroy(); 
                                                                                             return; 
       }
    }

       if (ProjectR2==none) 
       { 
                           ProjectR2 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectR2,'LightR2') ) 
       { 
                                                                ProjectR1.Destroy(); 
                                                                                             return; 
       }
    }

       if (ProjectL2==none) 
       { 
                           ProjectL2 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectL2,'LightL2') ) 
       { 
                                                                ProjectL1.Destroy(); 
                                                                                             return; 
       }
    }

       if (BrakeR1==none) 
       { 
                           BrakeR1 = Spawn(class'DKBrakelightCorona',self,,Location); 
                           if( !AttachToBone(BrakeR1,'BrakeR1') ) 
       { 
                                                                BrakeR1.Destroy(); 
                                                                                             return; 
       }
    }

       if (BrakeR2==none) 
       { 
                           BrakeR2 = Spawn(class'DKBrakelightCorona',self,,Location); 
                           if( !AttachToBone(BrakeR2,'BrakeR2') ) 
       { 
                                                                BrakeR2.Destroy(); 
                                                                                             return; 
       }
    }

       if (BrakeR3==none) 
       { 
                           BrakeR3 = Spawn(class'DKBrakelightCorona',self,,Location); 
                           if( !AttachToBone(BrakeR3,'BrakeR3') ) 
       { 
                                                                BrakeR3.Destroy(); 
                                                                                             return; 
       }
    }

       if (BrakeL1==none) 
       { 
                           BrakeL1 = Spawn(class'DKBrakelightCorona',self,,Location); 
                           if( !AttachToBone(BrakeL1,'BrakeL1') ) 
       { 
                                                                BrakeL1.Destroy(); 
                                                                                             return; 
       }
    }

       if (BrakeL2==none) 
       { 
                           BrakeL2 = Spawn(class'DKBrakelightCorona',self,,Location); 
                           if( !AttachToBone(BrakeL2,'BrakeL2') ) 
       { 
                                                                BrakeL2.Destroy(); 
                                                                                             return; 
       }
    }

       if (BrakeL3==none) 
       { 
                           BrakeL3 = Spawn(class'DKBrakelightCorona',self,,Location); 
                           if( !AttachToBone(BrakeL3,'BrakeL3') ) 
       { 
                                                                BrakeL3.Destroy(); 
                                                                                             return; 
       }
    }
	SetTimer(0.1, True);
}

function DriverLeft()
{
    Weapons[1].bActive = False;

	                 ProjectL1.Destroy();
	                 ProjectL2.Destroy();
	                 ProjectR1.Destroy();
	                 ProjectR2.Destroy();

	                 LightL1.Destroy();
	                 LightR1.Destroy();
	                 LightL2.Destroy();
	                 LightR2.Destroy();

	                 BrakeR1.Destroy();
	                 BrakeL1.Destroy();
	                 BrakeR2.Destroy();
	                 BrakeL2.Destroy();
	                 BrakeR3.Destroy();
	                 BrakeL3.Destroy();

    Super.DriverLeft();
}

simulated event DrivingStatusChanged()
{
	Super.DrivingStatusChanged();
}

simulated function Destroyed()
{
	                 Korpus.Destroy();

	                 LightL1.Destroy();
	                 LightR1.Destroy();
	                 LightL2.Destroy();
	                 LightR2.Destroy();

	                 ProjectL1.Destroy();
	                 ProjectL2.Destroy();
	                 ProjectR1.Destroy();
	                 ProjectR2.Destroy();

	                 BrakeR1.Destroy();
	                 BrakeL1.Destroy();
	                 BrakeR2.Destroy();
	                 BrakeL2.Destroy();
	                 BrakeR3.Destroy();
	                 BrakeL3.Destroy();

	Super.Destroyed();
}

defaultproperties
{
     TreadVelocityScale=275.000000
     MaxGroundSpeed=500.000000
     MaxAirSpeed=2000.000000
     WheelSoftness=0.100000
     WheelPenScale=1.000000
     WheelAdhesion=1.000000
     WheelInertia=0.070000
     WheelLongFrictionFunc=(Points=((OutVal=1.000000),(InVal=100.000000,OutVal=1.000000),(InVal=200.000000,OutVal=0.900000),(InVal=10000000000.000000,OutVal=0.900000)))
     WheelLongSlip=0.001000
     WheelLatSlipFunc=(Points=(,(InVal=30.000000,OutVal=0.010000),(InVal=45.000000),(InVal=10000000000.000000)))
     WheelLongFrictionScale=1.000000
     WheelLatFrictionScale=1.500000
     WheelHandbrakeSlip=0.750000
     WheelHandbrakeFriction=2.000000
     WheelSuspensionTravel=50.000000
     WheelSuspensionOffset=-22.000000
     WheelSuspensionMaxRenderTravel=50.000000
     FTScale=0.010000
     ChassisTorqueScale=0.300000
     MaxSteerAngleCurve=(Points=((OutVal=50.000000),(InVal=500.000000,OutVal=20.000000),(InVal=600.000000,OutVal=10.000000),(InVal=1000000000.000000,OutVal=5.000000)))
     TorqueCurve=(Points=((OutVal=7.000000),(InVal=200.000000,OutVal=8.000000),(InVal=1500.000000,OutVal=8.500000),(InVal=2500.000000)))
     GearRatios(0)=-0.500000
     GearRatios(1)=0.400000
     GearRatios(2)=0.650000
     GearRatios(3)=0.850000
     GearRatios(4)=1.300000
     TransRatio=0.100000
     ChangeUpPoint=2000.000000
     ChangeDownPoint=1000.000000
     LSDFactor=1.000000
     EngineBrakeFactor=0.000100
     MaxBrakeTorque=50.000000
     SteerSpeed=90.000000
     TurnDamping=35.000000
     StopThreshold=200.000000
     HandbrakeThresh=200.000000
     EngineInertia=0.050000
     IdleRPM=500.000000
     EngineRPMSoundRange=10000.000000
     SteerBoneName="SteeringWheel"
     SteerBoneAxis=AXIS_Z
     SteerBoneMaxAngle=90.000000
     DustSlipRate=1.000000
     DustSlipThresh=10.000000
     RevMeterScale=4000.000000
     AirPitchDamping=25.000000
     DriverWeapons(0)=(WeaponClass=Class'UberSoldierVehicles.TunguskaT',WeaponBone="Turret")
     DriverWeapons(1)=(WeaponClass=Class'UberSoldierVehicles.TunguskaT2',WeaponBone="Turret")
     RedSkin=Shader'DKVehiclesTex.Tunguska.Tunguska'
     BlueSkin=Shader'DKVehiclesTex.Tunguska.Tunguska'
     IdleSound=Sound'DKoppIISound.Engine.TankEngine10'
     StartUpSound=Sound'DKoppIISound.Engine.TankEngine10_up'
     ShutDownSound=Sound'DKoppIISound.Engine.TankEngine10_end'
     FireImpulse=(X=0.000000,Z=0.000000)
     AltFireImpulse=(X=0.000000,Z=0.000000)
     Begin Object Class=SVehicleWheel Name=RWheel1
         BoneName="RWheel1"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         Softness=0.000000
         PenScale=5.000000
         SuspensionTravel=0.000000
         SupportBoneName="RSus1"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(0)=SVehicleWheel'UberSoldierVehicles.Tunguska.RWheel1'

     Begin Object Class=SVehicleWheel Name=RWheel2
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RWheel2"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         SupportBoneName="RSus2"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(1)=SVehicleWheel'UberSoldierVehicles.Tunguska.RWheel2'

     Begin Object Class=SVehicleWheel Name=RWheel3
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RWheel3"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         SupportBoneName="RSus3"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(2)=SVehicleWheel'UberSoldierVehicles.Tunguska.RWheel3'

     Begin Object Class=SVehicleWheel Name=RWheel4
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RWheel4"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         SupportBoneName="RSus4"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(3)=SVehicleWheel'UberSoldierVehicles.Tunguska.RWheel4'

     Begin Object Class=SVehicleWheel Name=RWheel5
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="RWheel5"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         SupportBoneName="RSus5"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(4)=SVehicleWheel'UberSoldierVehicles.Tunguska.RWheel5'

     Begin Object Class=SVehicleWheel Name=RWheel6
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="RWheel6"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         SupportBoneName="RSus6"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(5)=SVehicleWheel'UberSoldierVehicles.Tunguska.RWheel6'

     Begin Object Class=SVehicleWheel Name=RWheel7
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="RWheel7"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         SupportBoneName="RSus7"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(6)=SVehicleWheel'UberSoldierVehicles.Tunguska.RWheel7'

     Begin Object Class=SVehicleWheel Name=Rwheel8
         BoneName="Rwheel8"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         Softness=0.000000
         PenScale=5.000000
         SuspensionTravel=0.000000
         SupportBoneName="RSus8"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(7)=SVehicleWheel'UberSoldierVehicles.Tunguska.Rwheel8'

     Begin Object Class=SVehicleWheel Name=LWheel1
         BoneName="LWheel1"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         BoneOffset=(Y=7.000000)
         WheelRadius=32.000000
         Softness=0.000000
         PenScale=5.000000
         SuspensionTravel=0.000000
         SupportBoneName="LSus1"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(8)=SVehicleWheel'UberSoldierVehicles.Tunguska.LWheel1'

     Begin Object Class=SVehicleWheel Name=LWheel2
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="LWheel2"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         SupportBoneName="LSus2"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(9)=SVehicleWheel'UberSoldierVehicles.Tunguska.LWheel2'

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
     Wheels(10)=SVehicleWheel'UberSoldierVehicles.Tunguska.LWheel3'

     Begin Object Class=SVehicleWheel Name=LWheel4
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="LWheel4"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         SupportBoneName="LSus4"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(11)=SVehicleWheel'UberSoldierVehicles.Tunguska.LWheel4'

     Begin Object Class=SVehicleWheel Name=LWheel5
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="LWheel5"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         SupportBoneName="LSus5"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(12)=SVehicleWheel'UberSoldierVehicles.Tunguska.LWheel5'

     Begin Object Class=SVehicleWheel Name=LWheel6
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="LWheel6"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         SupportBoneName="LSus6"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(13)=SVehicleWheel'UberSoldierVehicles.Tunguska.LWheel6'

     Begin Object Class=SVehicleWheel Name=LWheel7
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="LWheel7"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         SupportBoneName="LSus7"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(14)=SVehicleWheel'UberSoldierVehicles.Tunguska.LWheel7'

     Begin Object Class=SVehicleWheel Name=Lwheel8
         BoneName="Lwheel8"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=32.000000
         Softness=0.000000
         PenScale=5.000000
         SuspensionTravel=0.000000
         SupportBoneName="LSus8"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(15)=SVehicleWheel'UberSoldierVehicles.Tunguska.Lwheel8'

     VehicleMass=10.000000
     ExitPositions(0)=(Y=-200.000000,Z=100.000000)
     ExitPositions(1)=(Y=200.000000,Z=100.000000)
     EntryRadius=300.000000
     FPCamPos=(X=25.000000,Z=250.000000)
     FPCamViewOffset=(X=-100.000000)
     TPCamDistance=850.000000
     TPCamLookat=(X=0.000000,Y=-200.000000,Z=0.000000)
     TPCamWorldOffset=(Z=280.000000)
     VehiclePositionString="Tunguska"
     VehicleNameString="Tunguska"
     HealthMax=900.000000
     Health=900
     Mesh=SkeletalMesh'DKVehiclesAnim.Tunguska'
     Skins(0)=Shader'DKVehiclesTex.Tunguska.Tunguska'
     Skins(1)=Texture'DKVehiclesTex.ZTZ.ZTZ_Def'
     Skins(2)=Shader'DKVehiclesTex.Detail.T-62_trackS'
     Skins(3)=Texture'DKVehiclesTex.Detail.invis'
     Skins(4)=Shader'DKVehiclesTex.Tunguska.Tunguska'
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
     KParams=KarmaParamsRBFull'UberSoldierVehicles.Tunguska.KParams0'

}
