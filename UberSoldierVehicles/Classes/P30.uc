//----------------------------//
// P30 Infantry Helicopter    //
//----------------------------//
class P30 extends ONSChopperCraft;

var()   float							MaxPitchSpeed;

var()	array<vector>					ChopperDustOffset;
var()	float							ChopperDustTraceDistance;
var		array<FX_PredatorHoverDust>	ChopperDust;
var		array<vector>					ChopperDustLastNormal;

var MI48Vert BladesStill;
var MI48Blades blades;

var	Vehicle		CurrentTarget;
var	float		MaxTargetingRange;
var	float		LastAutoTargetTime;
var	Vector		CrosshairPos;
var Sound		TargetAcquiredSound;

var texture		WeaponInfoTexture, SpeedInfoTexture;

var float               mCurrentRoll;
var float               mRollInc;
var float               mRollUpdateTime;

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

    if (Role == ROLE_Authority)
	{

		if (Weapons.Length == 2 && ONSLinkableWeapon(Weapons[0]) != None)
              {
                                           ONSLinkableWeapon(Weapons[0]).ChildWeapon = Weapons[1];

	    }

    }

    if(Role == ROLE_Authority)
      {
       if (BladesStill==none)
          {
           BladesStill=spawn(Class'MI48Vert',Self,,Location);
           if( !AttachToBone(BladesStill,'VertCoord') )
             {
			   BladesStill.Destroy();
			   return;
             }
           }
}
}

function bool Dodge(eDoubleClickDir DoubleClickMove)
{
	if ( FRand() < 0.7 )
	{
		VehicleMovingTime = Level.TimeSeconds + 1;
		Rise = 1;
	}
	return (Rise != 0);
}

function KDriverEnter(Pawn p)
{

    super.KDriverEnter( P );

   Driver.CreateInventory("APVerIV.edo_ChuteInv");

   Weapons[1].bActive = True;

	SetTimer(0.1, True);
}

function DriverLeft()
{
	local int i;

    Weapons[1].bActive = False;

    Super.DriverLeft();
}

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
    local int i;

    if (blades!=none)
	    blades.Destroy();

    if (BladesStill!=none)
        BladesStill.Destroy();
	Super.Died(Killer, damageType, HitLocation);
}

simulated function Destroyed()
{
    local int i;

	if (Level.NetMode != NM_DedicatedServer)
	{
		for (i = 0; i < ChopperDust.Length; i++)
			ChopperDust[i].Destroy();

		ChopperDust.Length = 0;
	}
	if (blades!=none)
	    blades.Destroy();
     if (BladesStill!=none)
         BladesStill.Destroy();

    Super.Destroyed();
}

simulated function DestroyAppearance()
{
	local int i;

	if (Level.NetMode != NM_DedicatedServer)
	{
		for (i = 0; i < ChopperDust.Length; i++)
			ChopperDust[i].Destroy();

		ChopperDust.Length = 0;
	}

         Spawn(class'Deco_P30_X',,, Location + (vect(0,0,0) << Rotation)); 

         Spawn(class'Deco_P30_XX',,, Location + (vect(-150,0,0) << Rotation)); 

         Spawn(class'Deco_P30_FL',,, Location + (vect(0,0,0) << Rotation)); 
         Spawn(class'Deco_P30_FR',,, Location + (vect(0,0,0) << Rotation)); 
         Spawn(class'Deco_P30_KB',,, Location + (vect(0,0,0) << Rotation)); 
         Spawn(class'Deco_P30_KL',,, Location + (vect(0,0,0) << Rotation)); 
         Spawn(class'Deco_P30_KR',,, Location + (vect(0,0,0) << Rotation)); 
         Spawn(class'Deco_P30_PPX',,, Location + (vect(0,0,0) << Rotation)); 
         Spawn(class'Deco_P30_PX',,, Location + (vect(0,0,0) << Rotation)); 

         Spawn(class'FX_A10Destroy',,, Location + (vect(0,0,0) << Rotation));

         Spawn(class'PROJ_HellExp',self,,Location + (vect(0,0,0) << Rotation));  

	Super.DestroyAppearance();
}

simulated event DrivingStatusChanged()
{
	local vector RotX, RotY, RotZ;
	local int i;

	Super.DrivingStatusChanged();

    if (bDriving && Level.NetMode != NM_DedicatedServer && ChopperDust.Length == 0 && !bDropDetail)
	{
		ChopperDust.Length = ChopperDustOffset.Length;
		ChopperDustLastNormal.Length = ChopperDustOffset.Length;

		for(i=0; i<ChopperDustOffset.Length; i++)
    		if (ChopperDust[i] == None)
    		{
    			ChopperDust[i] = spawn( class'FX_PredatorHoverDust', self,, Location + (ChopperDustOffset[i] >> Rotation) );
    			ChopperDust[i].SetDustColor( Level.DustColor );
    			ChopperDustLastNormal[i] = vect(0,0,1);
    		}
	}
    else
    {
        if (Level.NetMode != NM_DedicatedServer)
    	{
    		for(i=0; i<ChopperDust.Length; i++)
                ChopperDust[i].Destroy();

            ChopperDust.Length = 0;
        }
    }
   Weapons[1].bActive = True;
}

simulated event GearStatusChanged()
{
     if (blades!=none)
	    blades.Destroy();

     if (BladesStill==none)
          {
           BladesStill=spawn(Class'MI48Vert',Self,,Location);
           if( !AttachToBone(BladesStill,'VertCoord') )
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
    local float EnginePitch,ThrustAmount,HitDist;
	local int i;
	local vector RelVel,TraceStart, TraceEnd, HitLocation, HitNormal;
	local actor HitActor;
	local bool bIsBehindView;
	local PlayerController PC;

     if (blades==none)
         {
          blades=spawn(Class'MI48Blades',Self,,Location);
          if( !AttachToBone(blades,'VertCoord') )
            {
			blades.Destroy();
			return;
		   }
         }
    if(Level.NetMode != NM_DedicatedServer)
	{
        EnginePitch = 64.0 + VSize(Velocity)/MaxPitchSpeed * 32.0;
        SoundPitch = FClamp(EnginePitch, 64, 96);

        RelVel = Velocity << Rotation;

        PC = Level.GetLocalPlayerController();
		if (PC != None && PC.ViewTarget == self)
			bIsBehindView = PC.bBehindView;
		else
            bIsBehindView = True;
    }

   if(Level.NetMode != NM_DedicatedServer && !bDropDetail)
	{
		for(i=0; i<ChopperDust.Length; i++)
		{
			ChopperDust[i].bDustActive = false;

			TraceStart = Location + (ChopperDustOffset[i] >> Rotation);
			TraceEnd = TraceStart - ( ChopperDustTraceDistance * vect(0,0,1) );

			HitActor = Trace(HitLocation, HitNormal, TraceEnd, TraceStart, True);

			if(HitActor == None)
			{
				ChopperDust[i].UpdateHoverDust(false, 0);
			}
			else
			{
				HitDist = VSize(HitLocation - TraceStart);

				ChopperDust[i].SetLocation( HitLocation + 10*HitNormal);

				ChopperDustLastNormal[i] = Normal( 3*ChopperDustLastNormal[i] + HitNormal );
				ChopperDust[i].SetRotation( Rotator(ChopperDustLastNormal[i]) );

				ChopperDust[i].UpdateHoverDust(true, HitDist/ChopperDustTraceDistance);

				// If dust is just turning on, set OldLocation to current Location to avoid spawn interpolation.
				if(!ChopperDust[i].bDustActive)
					ChopperDust[i].OldLocation = ChopperDust[i].Location;

				ChopperDust[i].bDustActive = true;
			}
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

function TakeDamage(int Damage, Pawn instigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> DamageType)
{
	if (DamageType == class'DT_AP_PS')
		Damage *= 1500.00;
	if (DamageType == class'DT_FG_PS')
		Damage *= 1500.00;

	Super.TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
}

defaultproperties
{
     MaxPitchSpeed=2000.000000
     UprightStiffness=700.000000
     UprightDamping=500.000000
     MaxThrustForce=100.000000
     LongDamping=0.050000
     MaxStrafeForce=80.000000
     LatDamping=0.050000
     MaxRiseForce=70.000000
     UpDamping=0.050000
     TurnTorqueFactor=600.000000
     TurnTorqueMax=200.000000
     TurnDamping=50.000000
     MaxYawRate=1.500000
     PitchTorqueFactor=200.000000
     PitchTorqueMax=100.000000
     PitchDamping=20.000000
     RollTorqueTurnFactor=450.000000
     RollTorqueStrafeFactor=50.000000
     RollTorqueMax=50.000000
     RollDamping=40.000000
     StopThreshold=100.000000
     MaxRandForce=3.000000
     RandForceInterval=0.750000
     DriverWeapons(0)=(WeaponClass=Class'UberSoldierVehicles.P30T',WeaponBone="TurretL")
     DriverWeapons(1)=(WeaponClass=Class'UberSoldierVehicles.P30T',WeaponBone="TurretR")
     IdleSound=Sound'APVerIV_Snd.PredatorSnd'
     StartUpSound=Sound'ONSVehicleSounds-S.AttackCraft.AttackCraftStartUp'
     ShutDownSound=Sound'ONSVehicleSounds-S.AttackCraft.AttackCraftShutDown'
     StartUpForce="AttackCraftStartUp"
     ShutDownForce="AttackCraftShutDown"
     DestructionEffectClass=Class'UberSoldierVehicles.FX_MG_BulletMetal'
     DestructionLinearMomentum=(Min=250000.000000,Max=400000.000000)
     DestructionAngularMomentum=(Max=150.000000)
     ImpactDamageMult=0.001000
     VehicleMass=8.000000
     bTurnInPlace=True
     ExitPositions(0)=(Y=-324.000000,Z=100.000000)
     ExitPositions(1)=(Y=324.000000,Z=100.000000)
     EntryPosition=(X=-40.000000)
     EntryRadius=400.000000
     TPCamDistance=1500.000000
     TPCamLookat=(X=0.000000,Z=0.000000)
     TPCamWorldOffset=(Z=500.000000)
     ShadowMaxTraceDist=10000.000000
     ShadowCullDistance=10000.000000
     DriverDamageMult=0.100000
     VehiclePositionString="P30"
     VehicleNameString="P30"
     RanOverDamageType=Class'Onslaught.DamTypeAttackCraftRoadkill'
     CrushedDamageType=Class'Onslaught.DamTypeAttackCraftPancake'
     FlagBone="Vert"
     FlagOffset=(Z=80.000000)
     FlagRotation=(Yaw=32768)
     HornSounds(0)=Sound'ONSVehicleSounds-S.Horns.Horn03'
     HornSounds(1)=Sound'ONSVehicleSounds-S.Horns.Horn07'
     bCanBeBaseForPawns=True
     GroundSpeed=2000.000000
     HealthMax=500.000000
     Health=500
     Mesh=SkeletalMesh'DKVehiclesAnim.P30'
     Skins(0)=Shader'DKVehiclesTex.P30.P30'
     Skins(1)=TexEnvMap'DKVehiclesTex.Cheetah.CheetahSS'
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
         bKDoubleTickRate=True
         bKStayUpright=True
         bKAllowRotate=True
         bDestroyOnWorldPenetrate=True
         bDoSafetime=True
         KFriction=0.500000
         KImpactThreshold=300.000000
     End Object
     KParams=KarmaParamsRBFull'UberSoldierVehicles.P30.KParams0'

}
