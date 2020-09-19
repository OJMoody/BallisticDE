//---------//
// IFV //
//---------//
class IFV extends DKVehicles;

var DKHeadlightCorona LightR1;
var DKHeadlightCorona LightR2;
var DKHeadlightCorona LightR3;
var DKHeadlightCorona LightR4;

var DKHeadlightCorona LightL1;
var DKHeadlightCorona LightL2;
var DKHeadlightCorona LightL3;
var DKHeadlightCorona LightL4;

var DKHeadlightProjector ProjectR1;
var DKHeadlightProjector ProjectR2;
var DKHeadlightProjector ProjectR3;
var DKHeadlightProjector ProjectR4;

var DKHeadlightProjector ProjectL1;
var DKHeadlightProjector ProjectL2;
var DKHeadlightProjector ProjectL3;
var DKHeadlightProjector ProjectL4;

var DKBrakelightCorona BrakeR1;
var DKBrakelightCorona BrakeR2;
var DKBrakelightCorona BrakeL1;
var DKBrakelightCorona BrakeL2;

simulated function DrawHUD(Canvas Canvas)
{
        local Material BGMaterial;
       
        Super.DrawHUD(Canvas);
       
 
        BGMaterial = Texture'DKVehiclesTex.Ammo.Ammo12';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.85);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());

        BGMaterial = Texture'DKVehiclesTex.Ammo.IconAmmo12';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.75);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());
}

function KDriverEnter(Pawn p)
{
    Super.KDriverEnter(p);

    SVehicleUpdateParams();

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
                                                                LightR1.Destroy(); 
                                                                                             return; 
       }
    }

       if (LightR3==none) 
       { 
                           LightR3 = Spawn(class'DKHeadlightCorona',self,,Location); 
                           if( !AttachToBone(LightR3,'LightR3') ) 
       { 
                                                                LightR3.Destroy(); 
                                                                                             return; 
       }
    }

       if (LightR4==none) 
       { 
                           LightR4 = Spawn(class'DKHeadlightCorona',self,,Location); 
                           if( !AttachToBone(LightR4,'LightR4') ) 
       { 
                                                                LightR4.Destroy(); 
                                                                                             return; 
       }
    }

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

       if (LightL3==none) 
       { 
                           LightL3 = Spawn(class'DKHeadlightCorona',self,,Location); 
                           if( !AttachToBone(LightL3,'LightL3') ) 
       { 
                                                                LightL3.Destroy(); 
                                                                                             return; 
       }
    }

       if (LightL4==none) 
       { 
                           LightL4 = Spawn(class'DKHeadlightCorona',self,,Location); 
                           if( !AttachToBone(LightL4,'LightL4') ) 
       { 
                                                                LightL4.Destroy(); 
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

       if (ProjectR1==none) 
       { 
                           ProjectR1 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectR1,'LightR1') ) 
       { 
                                                                ProjectR1.Destroy(); 
                                                                                             return; 
       }
    }

       if (ProjectR2==none) 
       { 
                           ProjectR2 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectR2,'LightR2') ) 
       { 
                                                                ProjectR2.Destroy(); 
                                                                                             return; 
       }
    }

       if (ProjectR3==none) 
       { 
                           ProjectR1 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectR3,'LightR3') ) 
       { 
                                                                ProjectR3.Destroy(); 
                                                                                             return; 
       }
    }

       if (ProjectR4==none) 
       { 
                           ProjectR4 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectR4,'LightR4') ) 
       { 
                                                                ProjectR4.Destroy(); 
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

       if (ProjectL2==none) 
       { 
                           ProjectL2 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectL2,'LightL2') ) 
       { 
                                                                ProjectL2.Destroy(); 
                                                                                             return; 
       }
    }

       if (ProjectL3==none) 
       { 
                           ProjectL3 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectL3,'LightL3') ) 
       { 
                                                                ProjectL3.Destroy(); 
                                                                                             return; 
       }
    }

       if (ProjectL4==none) 
       { 
                           ProjectL4 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectL4,'LightL4') ) 
       { 
                                                                ProjectL4.Destroy(); 
                                                                                             return; 
       }
    }

	SetTimer(0.1, True);
}

function DriverLeft()
{
	                 LightR1.Destroy();
	                 LightR2.Destroy();
	                 LightR3.Destroy();
	                 LightR4.Destroy();
	                 LightL1.Destroy();
	                 LightL2.Destroy();
	                 LightL3.Destroy();
	                 LightL4.Destroy();

	                 BrakeR1.Destroy();
	                 BrakeR2.Destroy();
	                 BrakeL1.Destroy();
	                 BrakeL2.Destroy();

	                 ProjectR1.Destroy();
	                 ProjectR2.Destroy();
	                 ProjectR3.Destroy();
	                 ProjectR4.Destroy();
	                 ProjectL1.Destroy();
	                 ProjectL2.Destroy();
	                 ProjectL3.Destroy();
	                 ProjectL4.Destroy();

    Super.DriverLeft();
}

simulated function Destroyed()
{
	                 LightR1.Destroy();
	                 LightR2.Destroy();
	                 LightR3.Destroy();
	                 LightR4.Destroy();
	                 LightL1.Destroy();
	                 LightL2.Destroy();
	                 LightL3.Destroy();
	                 LightL4.Destroy();

	                 BrakeR1.Destroy();
	                 BrakeR2.Destroy();
	                 BrakeL1.Destroy();
	                 BrakeL2.Destroy();

	                 ProjectR1.Destroy();
	                 ProjectR2.Destroy();
	                 ProjectR3.Destroy();
	                 ProjectR4.Destroy();
	                 ProjectL1.Destroy();
	                 ProjectL2.Destroy();
	                 ProjectL3.Destroy();
	                 ProjectL4.Destroy();

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
     DriverWeapons(0)=(WeaponClass=Class'UberSoldierVehicles.IFVT',WeaponBone="TurretCoords")
     RedSkin=Shader'DKVehiclesTex.IFV.IFV'
     BlueSkin=Shader'DKVehiclesTex.IFV.IFV'
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
     Wheels(0)=SVehicleWheel'UberSoldierVehicles.IFV.RWheel1'

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
     Wheels(1)=SVehicleWheel'UberSoldierVehicles.IFV.RWheel2'

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
     Wheels(2)=SVehicleWheel'UberSoldierVehicles.IFV.RWheel3'

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
     Wheels(3)=SVehicleWheel'UberSoldierVehicles.IFV.RWheel4'

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
     Wheels(4)=SVehicleWheel'UberSoldierVehicles.IFV.RWheel5'

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
     Wheels(5)=SVehicleWheel'UberSoldierVehicles.IFV.RWheel6'

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
     Wheels(6)=SVehicleWheel'UberSoldierVehicles.IFV.RWheel7'

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
     Wheels(7)=SVehicleWheel'UberSoldierVehicles.IFV.Rwheel8'

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
     Wheels(8)=SVehicleWheel'UberSoldierVehicles.IFV.LWheel1'

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
     Wheels(9)=SVehicleWheel'UberSoldierVehicles.IFV.LWheel2'

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
     Wheels(10)=SVehicleWheel'UberSoldierVehicles.IFV.LWheel3'

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
     Wheels(11)=SVehicleWheel'UberSoldierVehicles.IFV.LWheel4'

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
     Wheels(12)=SVehicleWheel'UberSoldierVehicles.IFV.LWheel5'

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
     Wheels(13)=SVehicleWheel'UberSoldierVehicles.IFV.LWheel6'

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
     Wheels(14)=SVehicleWheel'UberSoldierVehicles.IFV.LWheel7'

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
     Wheels(15)=SVehicleWheel'UberSoldierVehicles.IFV.Lwheel8'

     VehicleMass=10.000000
     ExitPositions(0)=(Y=-200.000000,Z=100.000000)
     ExitPositions(1)=(Y=200.000000,Z=100.000000)
     EntryRadius=300.000000
     FPCamPos=(X=25.000000,Z=250.000000)
     FPCamViewOffset=(X=-100.000000)
     TPCamDistance=750.000000
     TPCamLookat=(X=0.000000,Y=-200.000000,Z=0.000000)
     TPCamWorldOffset=(Z=280.000000)
     VehiclePositionString="IFV"
     VehicleNameString="IFV"
     HealthMax=800.000000
     Health=800
     Mesh=SkeletalMesh'DKVehiclesAnim.IFV'
     DrawScale=1.100000
     Skins(0)=Shader'DKVehiclesTex.IFV.IFV'
     Skins(1)=Texture'DKVehiclesTex.ZTZ.ZTZ_Def'
     Skins(2)=Shader'DKVehiclesTex.Detail.T-62_trackS'
     Skins(3)=Texture'DKVehiclesTex.Detail.invis'
     Skins(4)=Shader'DKVehiclesTex.IFV.IFVA'
     Skins(5)=Shader'DKVehiclesTex.Detail.Window2'
     Begin Object Class=KarmaParamsRBFull Name=KParams0
         KInertiaTensor(0)=1.000000
         KInertiaTensor(3)=3.000000
         KInertiaTensor(5)=3.000000
         KCOMOffset=(X=-0.300000,Z=-0.500000)
         KMass=15.000000
         KLinearDamping=0.000000
         KAngularDamping=0.000000
         KStartEnabled=True
         bKNonSphericalInertia=True
         KActorGravScale=1.500000
         KMaxSpeed=10000.000000
         KMaxAngularSpeed=10000.000000
         bHighDetailOnly=False
         bClientOnly=False
         bKStayUpright=True
         bDestroyOnWorldPenetrate=True
         bDoSafetime=True
         KFriction=0.500000
         KImpactThreshold=500.000000
     End Object
     KParams=KarmaParamsRBFull'UberSoldierVehicles.IFV.KParams0'

}
