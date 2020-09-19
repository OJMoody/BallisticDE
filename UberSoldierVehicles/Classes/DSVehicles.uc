//-------------------------------------//
//  Have no experience in C++ =D       //
//  UberSoldier 2014-2019 RUSSIAN      //
//-------------------------------------//

class DSVehicles extends ONSWheeledCraft;

#exec OBJ LOAD FILE=DKVehiclesTex.utx
#exec OBJ LOAD FILE=DA2_WeaponSounds.uax
#exec OBJ LOAD FILE=DKVehiclesMesh.usx
#exec OBJ LOAD FILE=RO_vehicles.uax
#exec OBJ LOAD FILE=A.uax
#exec OBJ LOAD FILE=A2.uax
#exec OBJ LOAD FILE=A3.uax
#exec OBJ LOAD FILE=DKoppIISound.uax
#exec OBJ LOAD FILE=BallisticSounds2.uax

var float   YawAccel, PitchAccel;
var float   ClientUpdateTime;
var float	StartDrivingTime;	// AI Hint
var Rotator LastAim;
var()   float   MaxPitchSpeed;
var float MaxGroundSpeed, MaxAirSpeed;

var() class<Emitter>	ExhaustClass;
var() array<Name>		ExhaustBones;
var array<Emitter>		ExhaustPuffs;

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
//  PostNetBeginPlay
//-----------------------------------------------------------

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

	SetTimer(1.0, True);

    bOwnerNoSee = False;
}

//-----------------------------------------------------------
//  DriverLeft
//-----------------------------------------------------------

simulated function DriverLeft()
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

simulated event CheckReset()
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
           super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
}

//-----------------------------------------------------------
//  BotDesireability
//-----------------------------------------------------------

simulated function float BotDesireability(Actor S, int TeamIndex, Actor Objective)
{
	local Bot B;
	local SquadAI Squad;
	local int Num;

	if ( Level.Game.JustStarted(20) && !Level.Game.IsA('ASGameInfo') )
		return Super.BotDesireability(S, TeamIndex, Objective);

	Squad = SquadAI(S);

	if (Squad.Size == 1)
	{
		if ( (Squad.Team != None) && (Squad.Team.Size == 1) && Level.Game.IsA('ASGameInfo') )
			return Super.BotDesireability(S, TeamIndex, Objective);
		return 0;
	}

	for (B = Squad.SquadMembers; B != None; B = B.NextSquadMember)
		if (Vehicle(B.Pawn) == None && (B.RouteGoal == self || B.Pawn == None || VSize(B.Pawn.Location - Location) < Squad.MaxVehicleDist(B.Pawn)))
			Num++;

	if ( Num < 2 )
		return 0;

	return Super.BotDesireability(S, TeamIndex, Objective);
}

//-----------------------------------------------------------
//  Vehicle FindEntryVehicle
//-----------------------------------------------------------

simulated function Vehicle FindEntryVehicle(Pawn P)
{
	local Bot B;
	local int i;

	if ( Level.Game.JustStarted(20) )
		return Super.FindEntryVehicle(P);

	B = Bot(P.Controller);
	if (B == None || WeaponPawns.length == 0 || !IsVehicleEmpty() || ((B.PlayerReplicationInfo.Team != None) && (B.PlayerReplicationInfo.Team.Size == 1) && Level.Game.IsA('ASGameInfo')) )
		return Super.FindEntryVehicle(P);

	for (i = WeaponPawns.length - 1; i >= 0; i--)
		if (WeaponPawns[i].Driver == None)
			return WeaponPawns[i];

	return Super.FindEntryVehicle(P);
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
     StartUpForce="TankStartUp"
     ShutDownForce="TankShutDown"
     DisintegrationEffectClass=Class'UberSoldierVehicles.FX_TankDestroy_Light'
     DisintegrationHealth=0.000000
     DestructionLinearMomentum=(Min=350000.000000,Max=400000.000000)
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
     bHasFireImpulse=True
     ShakeRotMag=(Z=10.000000)
     ShakeRotRate=(Z=100.000000)
     ShakeRotTime=2.000000
     ShakeOffsetRate=(Z=100.000000)
     ShakeOffsetTime=2.000000
     ImpactDamageThreshold=1000.000000
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
     bDrawVehicleShadow=False
     bDrawDriverInTP=True
     bCanDoTrickJumps=True
     bDrawMeshInFP=True
     bPCRelativeFPRotation=False
     bTeamLocked=False
     bHasHandbrake=True
     bSeparateTurretFocus=True
     bHighScoreKill=True
     bDriverHoldsFlag=False
     bFPNoZFromCameraPitch=True
     DrivePos=(Z=60.000000)
     CenterSpringForce="SpringONSSRV"
     TPCamDistRange=(Max=2000.000000)
     ShadowMaxTraceDist=3000.000000
     ShadowCullDistance=12000.000000
     MomentumMult=0.500000
     DriverDamageMult=0.030000
     RanOverDamageType=Class'Onslaught.DamTypePRVRoadkill'
     CrushedDamageType=Class'Onslaught.DamTypePRVPancake'
     LinkHealMult=0.000000
     MaxDesireability=0.600000
     ObjectiveGetOutDist=1500.000000
     FlagBone="Turret"
     FlagRotation=(Yaw=32768)
     HornSounds(0)=Sound'ONSVehicleSounds-S.Horns.Horn06'
     HornSounds(1)=Sound'ONSVehicleSounds-S.Horns.Dixie_Horn'
     SpawnOverlay(0)=None
     SpawnOverlay(1)=None
     bCanStrafe=True
     GroundSpeed=1000.000000
     bAlwaysRelevant=True
     NetUpdateFrequency=1.000000
     MaxLights=24
     bFullVolume=True
     CollisionRadius=100.000000
     CollisionHeight=100.000000
     bPathColliding=True
}
