//----------------------------------//
//  Have no experience in C++ =D    //
//  UberSoldier 2014-2019 RUSSIAN   //
//----------------------------------//

class DKVehiclesArty extends ONSArtillery;

#exec OBJ LOAD FILE=DKVehiclesTex.utx
#exec OBJ LOAD FILE=DA2_WeaponSounds.uax
#exec OBJ LOAD FILE=DKVehiclesMesh.usx
#exec OBJ LOAD FILE=RO_vehicles.uax
#exec OBJ LOAD FILE=A.uax
#exec OBJ LOAD FILE=A2.uax
#exec OBJ LOAD FILE=A3.uax
#exec OBJ LOAD FILE=DKoppIISound.uax
#exec OBJ LOAD FILE=BallisticSounds2.uax

var float TreadVelocityScale;
var float MaxGroundSpeed, MaxAirSpeed;

var()   float   MaxPitchSpeed;
var() class<Emitter>	ExhaustClass;
var() array<Name>		ExhaustBones;
var VariableTexPanner LeftTreadPanner, RightTreadPanner;
var array<Emitter>		ExhaustPuffs;

var FX_EngineFire TankDamage;

//-----------------------------------------------------------
//  ImportantVehicle
//-----------------------------------------------------------

simulated function bool ImportantVehicle()
{
	return true;
}

//-----------------------------------------------------------
//  RecommendLongRangedAttack
//-----------------------------------------------------------

simulated function bool RecommendLongRangedAttack()
{
	return true;
}

//-----------------------------------------------------------
//  RecommendLongRangedAttack
//-----------------------------------------------------------

simulated function ShouldTargetMissile(Projectile P)
{
	if ( (WeaponPawns.Length > 0) && (WeaponPawns[0].Controller == None) )
		Super.ShouldTargetMissile(P);
}

//-----------------------------------------------------------
//  PostBeginPlay
//-----------------------------------------------------------

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	if ( Level.NetMode != NM_DedicatedServer )
		SetupTreads();
}

//-----------------------------------------------------------
//  Tick
//-----------------------------------------------------------

simulated function Tick(float DeltaTime)
{
    local float EnginePitch;
    local float LinTurnSpeed;
    local KRigidBodyState BodyState;
    local KarmaParams KP;
    local bool bOnGround;
    local int i;

    KGetRigidBodyState(BodyState);

	KP = KarmaParams(KParams);

	bOnGround = false;
	for(i=0; i<KP.Repulsors.Length; i++)
	{
		if( KP.Repulsors[i] != None && KP.Repulsors[i].bRepulsorInContact )
			bOnGround = true;
	}

	if (bOnGround)
	   KP.kMaxSpeed = MaxGroundSpeed;
	else
	   KP.kMaxSpeed = MaxAirSpeed;

	if ( Level.NetMode != NM_DedicatedServer )
	{
		LinTurnSpeed = 0.5 * BodyState.AngVel.Z;
		EnginePitch = 64.0 + VSize(Velocity)/MaxPitchSpeed * 64.0;
		SoundPitch = FClamp(EnginePitch, 64, 128);

		if ( LeftTreadPanner != None )
		{
			LeftTreadPanner.PanRate = VSize(Velocity) / TreadVelocityScale;
			if (Velocity Dot Vector(Rotation) > 0)
				LeftTreadPanner.PanRate = -1 * LeftTreadPanner.PanRate;
			LeftTreadPanner.PanRate += LinTurnSpeed;
		}

		if ( RightTreadPanner != None )
		{
			RightTreadPanner.PanRate = VSize(Velocity) / TreadVelocityScale;
			if (Velocity Dot Vector(Rotation) > 0)
				RightTreadPanner.PanRate = -1 * RightTreadPanner.PanRate;
			RightTreadPanner.PanRate -= LinTurnSpeed;
		}
	}
    Super.Tick( DeltaTime );
}

//-----------------------------------------------------------
//  SetupTreads
//-----------------------------------------------------------

simulated function SetupTreads()
{
	LeftTreadPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	if ( LeftTreadPanner != None )
	{
		LeftTreadPanner.Material = Skins[2];
		LeftTreadPanner.PanDirection = rot(0, 16384, 0);
		LeftTreadPanner.PanRate = 0.0;
		Skins[2] = LeftTreadPanner;
	}
	RightTreadPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	if ( RightTreadPanner != None )
	{
		RightTreadPanner.Material = Skins[2];
		RightTreadPanner.PanDirection = rot(0, 16384, 0);
		RightTreadPanner.PanRate = 0.0;
		Skins[2] = RightTreadPanner;
	}
}

//-----------------------------------------------------------
//  DestroyTreads
//-----------------------------------------------------------

simulated function DestroyTreads()
{
	if ( LeftTreadPanner != None )
	{
		Level.ObjectPool.FreeObject(LeftTreadPanner);
		LeftTreadPanner = None;
	}
	if ( RightTreadPanner != None )
	{
		Level.ObjectPool.FreeObject(RightTreadPanner);
		RightTreadPanner = None;
	}
}

//-----------------------------------------------------------
//  DrivingStatusChanged
//-----------------------------------------------------------

simulated event DrivingStatusChanged()
{
    Super.DrivingStatusChanged();

    if (!bDriving)
    {
        if ( LeftTreadPanner != None )
            LeftTreadPanner.PanRate = 0.0;

        if ( RightTreadPanner != None )
            RightTreadPanner.PanRate = 0.0;
    }
}

//-----------------------------------------------------------
//  KDriverEnter
//-----------------------------------------------------------

simulated function KDriverEnter(Pawn p)
{
    local int i;
	local Coords BoneCoords;

    Super.KDriverEnter(p);

    SVehicleUpdateParams();

	if (Level.NetMode != NM_DedicatedServer)
	{
		for (i = 0; i < ExhaustBones.Length; i++)
		{
       		BoneCoords = GetBoneCoords(ExhaustBones[i]);
			ExhaustPuffs[i] = spawn(ExhaustClass, self,, BoneCoords.Origin);
			ExhaustPuffs[i].SetBase(self);
		}
	}
    bOwnerNoSee = False;
}

//-----------------------------------------------------------
//  DriverLeft
//-----------------------------------------------------------

function DriverLeft()
{
	local int i;

	if (Level.NetMode != NM_DedicatedServer)
	{
		for(i=0; i < ExhaustPuffs.Length; i++)
		    if (ExhaustPuffs[i] != None)
				ExhaustPuffs[i].Destroy();
	}

    Super.DriverLeft();
}

//-----------------------------------------------------------
//  CheckReset
//-----------------------------------------------------------

event CheckReset()
{
	local Pawn P;

	if ( bKeyVehicle && IsVehicleEmpty() )
	{
		Died(None, class'DamageType', Location);
		return;
	}

	if ( !IsVehicleEmpty() )
	{
    	ResetTime = Level.TimeSeconds + 60;
    	return;
	}

	foreach CollidingActors(class 'Pawn', P, 2500.0)
	{
		if (P.Controller != none && P != self && P.GetTeamNum() == GetTeamNum() && FastTrace(P.Location + P.CollisionHeight * vect(0,0,1), Location + CollisionHeight * vect(0,0,1)))
		{
			ResetTime = Level.TimeSeconds + 60;
			return;
		}
	}

	//if factory is active, we want it to spawn new vehicle NOW
	if ( ParentFactory != None )
	{
		ParentFactory.VehicleDestroyed(self);
		ParentFactory.Timer();
		ParentFactory = None; //so doesn't call ParentFactory.VehicleDestroyed() again in Destroyed()
	}

	Destroy();
}

//-----------------------------------------------------------
//  HealDamage
//-----------------------------------------------------------

simulated function bool HealDamage(int Amount, Controller Healer, class<DamageType> DamageType)
{
	if (ResetTime-Level.TimeSeconds<0.0)
		ResetTime = Level.TimeSeconds+0.0;

    return super.HealDamage(Amount, Healer, DamageType);
}

//-----------------------------------------------------------
//  TakeDamage
//-----------------------------------------------------------

simulated function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
Vector momentum, class<DamageType> damageType)
{
    local int ActualDamage;
    local Controller Killer;
    local Vector VNorm, TraceStart, TraceEnd, NewHitLocation, HitNormal;
    local Rotator NewRotation;

if ( (Health <= 0.30*HealthMax) && (Driver != none) )
Driver.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType) ;

           super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
}

//-----------------------------------------------------------
//  Destroyed
//-----------------------------------------------------------

simulated function Destroyed()
{
	local int i;

	if (Level.NetMode != NM_DedicatedServer)
	{
		for(i=0; i < ExhaustPuffs.Length; i++)
		    if (ExhaustPuffs[i] != None)
				ExhaustPuffs[i].Destroy();
	}

	  DestroyTreads();

	Super.Destroyed();
}

//-----------------------------------------------------------
//  Precache
//-----------------------------------------------------------

static function StaticPrecache(LevelInfo L)
{
    local int i;

	if (Default.RedSkin != None)
		L.AddPrecacheMaterial(Default.RedSkin);
	if (Default.BlueSkin != None)
		L.AddPrecacheMaterial(Default.BlueSkin);
}

simulated function UpdatePrecacheMaterials()
{
	if (Default.RedSkin != None)
		Level.AddPrecacheMaterial(Default.RedSkin);
	if (Default.BlueSkin != None)
		Level.AddPrecacheMaterial(Default.BlueSkin);

	Super.UpdatePrecacheMaterials();
}

defaultproperties
{
     ExhaustClass=Class'UberSoldierVehicles.FX_EngineExhaust'
     DustSlipThresh=1.000000
     RedSkin=None
     BlueSkin=None
     StartUpForce="TankStartUp"
     ShutDownForce="TankShutDown"
     DestructionEffectClass=Class'UberSoldierVehicles.FX_MG_BulletMetal'
     DisintegrationEffectClass=Class'UberSoldierVehicles.FX_TankDestroy_Medium'
     DisintegrationHealth=0.000000
     DestructionLinearMomentum=(Min=280000.000000,Max=350000.000000)
     DestructionAngularMomentum=(Min=500.000000,Max=1500.000000)
     ExplosionSounds(0)=Sound'DKoppIISound.TankDestroy.TankDestroy1'
     ExplosionSounds(1)=Sound'DKoppIISound.TankDestroy.TankDestroy2'
     ExplosionSounds(2)=Sound'DKoppIISound.TankDestroy.TankDestroy3'
     ExplosionSounds(3)=Sound'DKoppIISound.TankDestroy.TankDestroy4'
     ExplosionSounds(4)=Sound'DKoppIISound.TankDestroy.TankDestroy1'
     ExplosionSoundVolume=255.000000
     ExplosionSoundRadius=1500.000000
     ExplosionDamage=0.000000
     ExplosionRadius=0.000000
     ExplosionMomentum=0.000000
     ExplosionDamageType=None
     DamagedEffectScale=0.000000
     DamagedEffectHealthSmokeFactor=0.400000
     DamagedEffectHealthFireFactor=0.200000
     DamagedEffectAccScale=1.000000
     DamagedEffectFireDamagePerSec=0.000000
     FireImpulse=(X=-250000.000000,Z=-100000.000000)
     AltFireImpulse=(X=-250000.000000,Z=-100000.000000)
     ShakeRotMag=(Z=10.000000)
     ShakeRotRate=(Z=100.000000)
     ShakeRotTime=2.000000
     ShakeOffsetRate=(Z=100.000000)
     ShakeOffsetTime=2.000000
     ImpactDamageTicks=1.000000
     ImpactDamageThreshold=1000.000000
     ImpactDamageMult=0.000300
     ImpactDamageSounds(0)=None
     ImpactDamageSounds(1)=None
     ImpactDamageSounds(2)=None
     ImpactDamageSounds(3)=None
     ImpactDamageSounds(4)=None
     ImpactDamageSounds(5)=None
     ImpactDamageSounds(6)=None
     CrossHairColor=(G=0,R=255)
     CrosshairX=40.000000
     CrosshairY=40.000000
     CrosshairTexture=Texture'DKVehiclesTex.Detail.TankTarget'
     bCanDoTrickJumps=True
     bPCRelativeFPRotation=False
     bTeamLocked=False
     bSeparateTurretFocus=True
     bHighScoreKill=True
     bFPNoZFromCameraPitch=True
     DrivePos=(Z=60.000000)
     CenterSpringForce="SpringONSSRV"
     TPCamDistRange=(Max=2000.000000)
     ShadowMaxTraceDist=6000.000000
     ShadowCullDistance=12000.000000
     MomentumMult=0.500000
     DriverDamageMult=0.030000
     LinkHealMult=0.000000
     FlagBone="Turret"
     HornSounds(0)=Sound'ONSVehicleSounds-S.Horns.Horn06'
     HornSounds(1)=Sound'ONSVehicleSounds-S.Horns.Dixie_Horn'
     SpawnOverlay(0)=None
     SpawnOverlay(1)=None
     bCanStrafe=True
     GroundSpeed=1000.000000
     bDramaticLighting=False
     bAlwaysRelevant=True
     NetUpdateFrequency=1.000000
     MaxLights=24
     bFullVolume=True
     CollisionRadius=100.000000
     CollisionHeight=100.000000
     bPathColliding=True
}
