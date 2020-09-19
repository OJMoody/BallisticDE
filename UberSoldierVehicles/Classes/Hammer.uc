class Hammer extends DSVehicles;

var Deco_HammerKorpus Korpus;

var Skel_Hammer_FlapF FlapF;
var Skel_Hammer_FlapB FlapB;

var Skel_Hammer_ColR ColR1;
var Skel_Hammer_ColL ColL1;
var Skel_Hammer_ColR ColR2;
var Skel_Hammer_ColL ColL2;

var DKHeadlightCorona LightR1;
var DKHeadlightCorona LightL1;

var DKHeadlightProjector ProjectR1;
var DKHeadlightProjector ProjectL1;

var DKBrakelightCorona BrakeR1;
var DKBrakelightCorona BrakeL1;

var FX_EngineSmokeSmall EngineSmoke;
var FX_EngineFireSmall EngineFire;

function PostBeginPlay()
{
	super.PostBeginPlay();

       if (Korpus==none) 
       { 
         Korpus = Spawn(class'Deco_HammerKorpus',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(Korpus,'Chassis') ) 
       { 
               Korpus.Destroy(); 
                         return; 
       }
       }

       if (FlapF==none) 
       { 
         FlapF = Spawn(class'Skel_Hammer_FlapF',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(FlapF,'FlapF') ) 
       { 
               FlapF.Destroy(); 
                         return; 
       }
       }

       if (FlapB==none) 
       { 
         FlapB = Spawn(class'Skel_Hammer_FlapB',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(FlapB,'FlapB') ) 
       { 
               FlapB.Destroy(); 
                         return; 
       }
       }

       if (ColR1==none) 
       { 
         ColR1 = Spawn(class'Skel_Hammer_ColR',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(ColR1,'RTire') ) 
       { 
               ColR1.Destroy(); 
                         return; 
       }
       }

       if (ColR2==none) 
       { 
         ColR2 = Spawn(class'Skel_Hammer_ColR',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(ColR2,'RRTire') ) 
       { 
               ColR2.Destroy(); 
                         return; 
       }
       }

       if (ColL1==none) 
       { 
         ColL1 = Spawn(class'Skel_Hammer_ColL',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(ColL1,'LTire') ) 
       { 
               ColL1.Destroy(); 
                         return; 
       }
       }

       if (ColL2==none) 
       { 
         ColL2 = Spawn(class'Skel_Hammer_ColL',self,, Location + (vect(0,0,0) << Rotation)); 
       if( !AttachToBone(ColL2,'LLTire') ) 
       { 
               ColL2.Destroy(); 
                         return; 
       }
       }
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

       if (LightL1==none) 
       { 
                           LightL1 = Spawn(class'DKHeadlightCorona',self,,Location); 
                           if( !AttachToBone(LightL1,'LightL1') ) 
       { 
                                                                LightL1.Destroy(); 
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

       if (BrakeL1==none) 
       { 
                           BrakeL1 = Spawn(class'DKBrakelightCorona',self,,Location); 
                           if( !AttachToBone(BrakeL1,'BrakeL1') ) 
       { 
                                                                BrakeL1.Destroy(); 
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

	SetTimer(0.1, True);
}

function DriverLeft()
{
	                 LightR1.Destroy();
	                 LightL1.Destroy();

	                 BrakeR1.Destroy();
	                 BrakeL1.Destroy();

	                 ProjectR1.Destroy();
	                 ProjectL1.Destroy();

    Super.DriverLeft();
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> DamageType)
{
	if (DamageType == class'DT_AP_PS')
		Damage *= 1200.00;
	if (DamageType == class'DT_FG_PS')
		Damage *= 1200.00;

	if ( (Health <= 0.60*HealthMax) && (EngineSmoke == none) )
	{
	EngineSmoke = spawn( class'UberSoldierVehicles.FX_EngineSmokeSmall' , self);
	if (EngineSmoke != none)
	AttachToBone(EngineSmoke,'Engine');
	}

	if ( (Health <= 0.30*HealthMax) && (EngineFire == none) )
	{
	EngineFire = spawn( class'UberSoldierVehicles.FX_EngineFireSmall' , self);
	if (EngineFire != none)
	AttachToBone(EngineFire,'Engine');
	}

	Super.TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
}

simulated function DestroyAppearance()
{
         Spawn( class'FX_TankDestroy_CrunkB',self,,Location + (vect(0,0,0) << Rotation));
         Spawn( class'PROJ_TankExp',self,,Location + (vect(0,0,0) << Rotation));

	Super.DestroyAppearance();
}

simulated function Destroyed()
{
                         Korpus.Destroy();

                         ColR1.Destroy();
                         ColL1.Destroy();
                         ColR2.Destroy();
                         ColL2.Destroy();

                         FlapF.Destroy(); 
                         FlapB.Destroy(); 

                         EngineSmoke.Destroy();
                         EngineFire.Destroy();

                         LightR1.Destroy();
                         LightL1.Destroy();

                         BrakeR1.Destroy();
                         BrakeL1.Destroy();

                         ProjectR1.Destroy();
                         ProjectL1.Destroy();

	Super.Destroyed();
}

defaultproperties
{
     WheelSoftness=0.060000
     WheelPenScale=3.000000
     WheelRestitution=0.050000
     WheelLongFrictionFunc=(Points=((OutVal=1.000000),(InVal=100.000000,OutVal=1.000000),(InVal=200.000000,OutVal=0.900000),(InVal=10000000000.000000,OutVal=0.900000)))
     WheelLongSlip=0.001000
     WheelLatSlipFunc=(Points=(,(InVal=30.000000,OutVal=0.009000),(InVal=45.000000),(InVal=10000000000.000000)))
     WheelLongFrictionScale=1.100000
     WheelLatFrictionScale=1.500000
     WheelHandbrakeSlip=0.010000
     WheelHandbrakeFriction=0.100000
     WheelSuspensionTravel=50.000000
     WheelSuspensionOffset=-10.000000
     FTScale=0.030000
     ChassisTorqueScale=0.700000
     MinBrakeFriction=4.000000
     MaxSteerAngleCurve=(Points=((OutVal=25.000000),(InVal=1500.000000,OutVal=8.000000),(InVal=1000000000.000000,OutVal=8.000000)))
     TorqueCurve=(Points=((OutVal=9.000000),(InVal=200.000000,OutVal=10.000000),(InVal=1500.000000,OutVal=11.000000),(InVal=2500.000000)))
     GearRatios(0)=-0.500000
     GearRatios(1)=0.400000
     GearRatios(2)=0.650000
     GearRatios(3)=0.850000
     GearRatios(4)=1.300000
     TransRatio=0.110000
     ChangeUpPoint=2000.000000
     ChangeDownPoint=1000.000000
     LSDFactor=1.000000
     EngineBrakeFactor=0.000100
     EngineBrakeRPMScale=0.100000
     MaxBrakeTorque=20.000000
     SteerSpeed=80.000000
     TurnDamping=35.000000
     StopThreshold=100.000000
     HandbrakeThresh=200.000000
     EngineInertia=0.100000
     IdleRPM=800.000000
     EngineRPMSoundRange=10000.000000
     SteerBoneAxis=AXIS_Z
     SteerBoneMaxAngle=180.000000
     RevMeterScale=4000.000000
     DaredevilThreshInAirSpin=90.000000
     DaredevilThreshInAirTime=1.200000
     bDoStuntInfo=True
     AirTurnTorque=35.000000
     AirPitchTorque=55.000000
     AirPitchDamping=35.000000
     AirRollTorque=35.000000
     AirRollDamping=35.000000
     RedSkin=Shader'DKVehiclesTex.Hammer.Hammer'
     BlueSkin=Shader'DKVehiclesTex.Hammer.Hammer'
     StartUpForce="PRVStartUp"
     ShutDownForce="PRVShutDown"
     ImpactDamageMult=0.001000
     Begin Object Class=SVehicleWheel Name=RRWheel
         bPoweredWheel=True
         bHandbrakeWheel=True
         BoneName="RRTire"
         BoneRollAxis=AXIS_Y
         WheelRadius=27.000000
         SupportBoneName="RRStrut"
     End Object
     Wheels(0)=SVehicleWheel'UberSoldierVehicles.Hammer.RRWheel'

     Begin Object Class=SVehicleWheel Name=LRWheel
         bPoweredWheel=True
         bHandbrakeWheel=True
         BoneName="LLTire"
         BoneRollAxis=AXIS_Y
         WheelRadius=27.000000
         SupportBoneName="LLStrut"
     End Object
     Wheels(1)=SVehicleWheel'UberSoldierVehicles.Hammer.LRWheel'

     Begin Object Class=SVehicleWheel Name=RFWheel
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RTire"
         BoneRollAxis=AXIS_Y
         WheelRadius=27.000000
         SupportBoneName="RStrut"
     End Object
     Wheels(2)=SVehicleWheel'UberSoldierVehicles.Hammer.RFWheel'

     Begin Object Class=SVehicleWheel Name=LFWheel
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="LTire"
         BoneRollAxis=AXIS_Y
         WheelRadius=27.000000
         SupportBoneName="LStrut"
     End Object
     Wheels(3)=SVehicleWheel'UberSoldierVehicles.Hammer.LFWheel'

     VehicleMass=8.000000
     DrivePos=(Z=40.000000)
     ExitPositions(0)=(Y=-165.000000,Z=100.000000)
     ExitPositions(1)=(Y=165.000000,Z=100.000000)
     ExitPositions(2)=(Y=-165.000000,Z=-100.000000)
     ExitPositions(3)=(Y=165.000000,Z=-100.000000)
     EntryPosition=(X=20.000000,Y=-60.000000,Z=10.000000)
     EntryRadius=190.000000
     FPCamPos=(X=67.000000,Z=60.000000)
     TPCamLookat=(X=0.000000,Y=-100.000000,Z=0.000000)
     TPCamWorldOffset=(Z=200.000000)
     DriverDamageMult=0.300000
     VehiclePositionString="Hammer"
     VehicleNameString="Hammer"
     GroundSpeed=840.000000
     HealthMax=600.000000
     Health=600
     Mesh=SkeletalMesh'DKVehiclesAnim.Hammer'
     Skins(0)=Shader'DKVehiclesTex.Hammer.Hammer'
     Skins(1)=Shader'DKVehiclesTex.Hammer.HammerC'
     Skins(2)=Shader'DKVehiclesTex.Hammer.HammerB'
     Skins(3)=Shader'DKVehiclesTex.Hammer.HammerA'
     Skins(4)=Texture'DKVehiclesTex.Detail.invis'
     Begin Object Class=KarmaParamsRBFull Name=KParams0
         KInertiaTensor(0)=1.000000
         KInertiaTensor(3)=3.000000
         KInertiaTensor(5)=3.500000
         KCOMOffset=(X=-0.300000,Z=-0.500000)
         KLinearDamping=0.050000
         KAngularDamping=0.050000
         KStartEnabled=True
         bKNonSphericalInertia=True
         bHighDetailOnly=False
         bClientOnly=False
         bKDoubleTickRate=True
         bDestroyOnWorldPenetrate=True
         bDoSafetime=True
         KFriction=0.500000
         KImpactThreshold=500.000000
     End Object
     KParams=KarmaParamsRBFull'UberSoldierVehicles.Hammer.KParams0'

}
