//----------------------------------//
//  Have no experience in C++ =D    //
//  UberSoldier 2014-2016 RUSSIAN   //
//----------------------------------//

class DAVehicles extends ONSChopperCraft;

#exec OBJ LOAD FILE=DKVehiclesTex.utx
#exec OBJ LOAD FILE=DA2_WeaponSounds.uax
#exec OBJ LOAD FILE=DKVehiclesMesh.usx
#exec OBJ LOAD FILE=RO_vehicles.uax
#exec OBJ LOAD FILE=A.uax
#exec OBJ LOAD FILE=A2.uax
#exec OBJ LOAD FILE=A3.uax
#exec OBJ LOAD FILE=DKoppIISound.uax
#exec OBJ LOAD FILE=BallisticSounds2.uax

//-----------------------------------------------------------
//  ImportantVehicle
//-----------------------------------------------------------

function bool ImportantVehicle()
{
	return true;
}

//-----------------------------------------------------------
//  RecommendLongRangedAttack
//-----------------------------------------------------------

function bool RecommendLongRangedAttack()
{
	return true;
}

//-----------------------------------------------------------
//  RecommendLongRangedAttack
//-----------------------------------------------------------

function ShouldTargetMissile(Projectile P)
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
}

//-----------------------------------------------------------
//  Tick
//-----------------------------------------------------------

simulated function Tick(float DeltaTime)
{
    Super.Tick( DeltaTime );
}

//-----------------------------------------------------------
//  DrivingStatusChanged
//-----------------------------------------------------------

simulated event DrivingStatusChanged()
{
    Super.DrivingStatusChanged();
}

//-----------------------------------------------------------
//  KDriverEnter
//-----------------------------------------------------------

function KDriverEnter(Pawn p)
{
    Super.KDriverEnter(p);
}

//-----------------------------------------------------------
//  DriverLeft
//-----------------------------------------------------------

function DriverLeft()
{
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
    	ResetTime = Level.TimeSeconds + 120;
    	return;
	}

	foreach CollidingActors(class 'Pawn', P, 2500.0)
	{
		if (P.Controller != none && P != self && P.GetTeamNum() == GetTeamNum() && FastTrace(P.Location + P.CollisionHeight * vect(0,0,1), Location + CollisionHeight * vect(0,0,1)))
		{
			ResetTime = Level.TimeSeconds + 120;
			return;
		}
	}

	if ( ParentFactory != None )
	{
		ParentFactory.VehicleDestroyed(self);
		ParentFactory.Timer();
		ParentFactory = None;
	}

	Destroy();
}

//-----------------------------------------------------------
//  HealDamage
//-----------------------------------------------------------

function bool HealDamage(int Amount, Controller Healer, class<DamageType> DamageType)
{
	if (ResetTime-Level.TimeSeconds<0.0)
		ResetTime = Level.TimeSeconds+0.0;

    return super.HealDamage(Amount, Healer, DamageType);
}

//-----------------------------------------------------------
//  TakeDamage
//-----------------------------------------------------------

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
Vector momentum, class<DamageType> damageType)
{
           super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
}

//-----------------------------------------------------------
//  Destroyed
//-----------------------------------------------------------

simulated function Destroyed()
{
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
     DestructionEffectClass=Class'UberSoldierVehicles.FX_MG_BulletMetal'
     DisintegrationEffectClass=Class'UberSoldierVehicles.FX_TankDestroy_Medium'
     DisintegrationHealth=0.000000
     DestructionLinearMomentum=(Min=250000.000000,Max=300000.000000)
     DestructionAngularMomentum=(Min=500.000000,Max=800.000000)
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
     FireImpulse=(X=-1000.000000)
     AltFireImpulse=(X=-1000.000000)
     bHasFireImpulse=True
     ShakeRotMag=(Z=10.000000)
     ShakeRotRate=(Z=100.000000)
     ShakeRotTime=2.000000
     ShakeOffsetRate=(Z=100.000000)
     ShakeOffsetTime=2.000000
     ImpactDamageTicks=1.000000
     ImpactDamageThreshold=1000.000000
     ImpactDamageMult=0.010000
     ImpactDamageSounds(0)=None
     ImpactDamageSounds(1)=None
     ImpactDamageSounds(2)=None
     ImpactDamageSounds(3)=None
     ImpactDamageSounds(4)=None
     ImpactDamageSounds(5)=None
     ImpactDamageSounds(6)=None
     CrossHairColor=(B=255,G=0)
     CrosshairX=60.000000
     CrosshairY=60.000000
     CrosshairTexture=Texture'DKVehiclesTex.Detail.TankTarget'
     bDrawDriverInTP=True
     bCanDoTrickJumps=True
     bDrawMeshInFP=True
     bTeamLocked=False
     bHasHandbrake=True
     bSeparateTurretFocus=True
     bHighScoreKill=True
     bDriverHoldsFlag=False
     bFPNoZFromCameraPitch=True
     DrivePos=(Z=60.000000)
     CenterSpringForce="SpringONSSRV"
     TPCamDistRange=(Max=2000.000000)
     ShadowMaxTraceDist=6000.000000
     ShadowCullDistance=6000.000000
     MomentumMult=0.500000
     DriverDamageMult=0.040000
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
     GroundSpeed=1000.000000
     bDramaticLighting=False
     bAlwaysRelevant=True
     NetUpdateFrequency=1.000000
     MaxLights=24
     bFullVolume=True
     CollisionRadius=100.000000
     CollisionHeight=100.000000
}
