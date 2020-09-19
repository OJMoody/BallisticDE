//---------//
// Leopard //
//---------//
class Leopard extends DKVehicles;

var FX_EngineFire FireEngineL;
var FX_EngineFire FireEngineR;

var Deco_LeopardKorpus Korpus;

var DKHeadlightCorona LightL1;
var DKHeadlightCorona LightR1;

var DKHeadlightProjector ProjectR1;
var DKHeadlightProjector ProjectL1;

simulated function DrawHUD(Canvas Canvas)
{
        local Material BGMaterial;
       
        Super.DrawHUD(Canvas);
       
 
        BGMaterial = Texture'DKVehiclesTex.Ammo.Ammo88';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.85);
        Canvas.SetDrawColor(255, 255, 255, 255);
        Canvas.DrawTile(BGMaterial, 128, 64, 0, 0, BGMaterial.MaterialUSize(), BGMaterial.MaterialVSize());

        BGMaterial = Texture'DKVehiclesTex.Ammo.IconAmmo88';

        Canvas.SetPos(Canvas.SizeX*0.0, Canvas.SizeY*0.75);
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
         Korpus = Spawn(class'Deco_LeopardKorpus',self,, Location + (vect(0,0,-1) << Rotation)); 
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

    SVehicleUpdateParams();

       if (LightR1==none) 
       { 
                           LightR1 = Spawn(class'DKHeadlightCorona',self,,Location); 
                           if( !AttachToBone(LightR1,'LightR') ) 
       { 
                                                                LightR1.Destroy(); 
                                                                                             return; 
       }
    }

       if (LightL1==none) 
       { 
                           LightL1 = Spawn(class'DKHeadlightCorona',self,,Location); 
                           if( !AttachToBone(LightL1,'LightL') ) 
       { 
                                                                LightL1.Destroy(); 
                                                                                             return; 
       }
    }

       if (ProjectR1==none) 
       { 
                           ProjectR1 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectR1,'LightR') ) 
       { 
                                                                ProjectR1.Destroy(); 
                                                                                             return; 
       }
    }

       if (ProjectL1==none) 
       { 
                           ProjectL1 = Spawn(class'DKHeadlightProjector ',self,,Location); 
                           if( !AttachToBone(ProjectL1,'LightL') ) 
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

	                 ProjectR1.Destroy();
	                 ProjectL1.Destroy();

    Super.DriverLeft();
}

simulated event DrivingStatusChanged()
{
	Super.DrivingStatusChanged();
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
Vector momentum, class<DamageType> damageType)
{
	if ( (Health <= 0.50*HealthMax) && (FireEngineL == none) )
	{
	FireEngineL = spawn( class'UberSoldierVehicles.FX_EngineFire' , self);
	if (FireEngineL != none)
	AttachToBone(FireEngineL,'EngineL');
	}

	if ( (Health <= 0.50*HealthMax) && (FireEngineR == none) )
	{
	FireEngineR = spawn( class'UberSoldierVehicles.FX_EngineFire' , self);
	if (FireEngineR != none)
	AttachToBone(FireEngineR,'EngineR');
	}

           super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
}

simulated function DestroyAppearance()
{
         Spawn( class'PROJ_TankExp',self,,Location + (vect(0,0,-20) << Rotation));

	Super.DestroyAppearance();
}

simulated function Destroyed()
{
	                 Korpus.Destroy();

	                 LightR1.Destroy();
	                 LightL1.Destroy();

	                 ProjectR1.Destroy();
	                 ProjectL1.Destroy();

	                 FireEngineR.Destroy();
	                 FireEngineL.Destroy();

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
     DriverWeapons(0)=(WeaponClass=Class'UberSoldierVehicles.LeopardT',WeaponBone="TurretCoords")
     RedSkin=Shader'DKVehiclesTex.Leopard.Leopard'
     BlueSkin=Shader'DKVehiclesTex.Leopard.Leopard'
     IdleSound=Sound'DKoppIISound.Engine.TankEngine5'
     StartUpSound=Sound'DKoppIISound.Engine.TankEngine5_up'
     ShutDownSound=Sound'DKoppIISound.Engine.TankEngine5_end'
     Begin Object Class=SVehicleWheel Name=RWheel1
         SteerType=VST_Steered
         BoneName="RWheel1"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.001000
         SupportBoneName="RSus1"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(0)=SVehicleWheel'UberSoldierVehicles.Leopard.RWheel1'

     Begin Object Class=SVehicleWheel Name=RWheel2
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="RWheel2"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         SupportBoneName="RSus2"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(1)=SVehicleWheel'UberSoldierVehicles.Leopard.RWheel2'

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
     Wheels(2)=SVehicleWheel'UberSoldierVehicles.Leopard.RWheel3'

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
     Wheels(3)=SVehicleWheel'UberSoldierVehicles.Leopard.RWheel4'

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
     Wheels(4)=SVehicleWheel'UberSoldierVehicles.Leopard.RWheel5'

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
     Wheels(5)=SVehicleWheel'UberSoldierVehicles.Leopard.RWheel6'

     Begin Object Class=SVehicleWheel Name=RWheel7
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="RWheel7"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         PenScale=0.500000
         SupportBoneName="RSus7"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(6)=SVehicleWheel'UberSoldierVehicles.Leopard.RWheel7'

     Begin Object Class=SVehicleWheel Name=Rwheel8
         SteerType=VST_Steered
         BoneName="Rwheel8"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.040000
         SupportBoneName="RSus8"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(7)=SVehicleWheel'UberSoldierVehicles.Leopard.Rwheel8'

     Begin Object Class=SVehicleWheel Name=LWheel1
         SteerType=VST_Steered
         BoneName="LWheel1"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.001000
         SupportBoneName="LSus1"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(8)=SVehicleWheel'UberSoldierVehicles.Leopard.LWheel1'

     Begin Object Class=SVehicleWheel Name=LWheel2
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="LWheel2"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         SupportBoneName="LSus2"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(9)=SVehicleWheel'UberSoldierVehicles.Leopard.LWheel2'

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
     Wheels(10)=SVehicleWheel'UberSoldierVehicles.Leopard.LWheel3'

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
     Wheels(11)=SVehicleWheel'UberSoldierVehicles.Leopard.LWheel4'

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
     Wheels(12)=SVehicleWheel'UberSoldierVehicles.Leopard.LWheel5'

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
     Wheels(13)=SVehicleWheel'UberSoldierVehicles.Leopard.LWheel6'

     Begin Object Class=SVehicleWheel Name=LWheel7
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="LWheel7"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         PenScale=0.500000
         SupportBoneName="LSus7"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(14)=SVehicleWheel'UberSoldierVehicles.Leopard.LWheel7'

     Begin Object Class=SVehicleWheel Name=Lwheel8
         SteerType=VST_Steered
         BoneName="Lwheel8"
         BoneRollAxis=AXIS_Y
         BoneSteerAxis=AXIS_Y
         WheelRadius=30.000000
         Softness=0.040000
         SupportBoneName="LSus8"
         SupportBoneAxis=AXIS_Z
     End Object
     Wheels(15)=SVehicleWheel'UberSoldierVehicles.Leopard.Lwheel8'

     VehicleMass=10.000000
     ExitPositions(0)=(Z=250.000000)
     ExitPositions(1)=(Z=250.000000)
     EntryRadius=400.000000
     FPCamPos=(X=25.000000,Z=250.000000)
     FPCamViewOffset=(X=-100.000000)
     TPCamDistance=750.000000
     TPCamLookat=(X=0.000000,Y=-200.000000,Z=0.000000)
     TPCamWorldOffset=(Z=280.000000)
     VehiclePositionString="Leopard"
     VehicleNameString="Leopard"
     HealthMax=1800.000000
     Health=1800
     Mesh=SkeletalMesh'DKVehiclesAnim.Leopard'
     Skins(0)=Shader'DKVehiclesTex.Leopard.Leopard'
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
     KParams=KarmaParamsRBFull'UberSoldierVehicles.Leopard.KParams0'

}
