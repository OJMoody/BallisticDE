class PROJ_LeopardAP extends DKProjectile;

var Emitter SmokeTrailEffect;
var bool bHitWater;
var Effects Corona;
var vector Dir;

var() class<Emitter> ExplosionEmitter;
var() sound ExplosionSound, ExplosionSoundFar;

delegate OnDie(Actor Cam);

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
          PlaySound(Sound'A3.Flak_02', SLOT_None,TransientSoundVolume*0.5,,TransientSoundRadius); 
        }
	Super.PostBeginPlay();
}

simulated function Destroyed()
{
	if ( SmokeTrailEffect != None )
		SmokeTrailEffect.Kill();
	if ( Corona != None )
		Corona.Destroy();
	Super.Destroyed();
}

function BlowUp(vector HitLocation)
{
	HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	MakeNoise(1.0);
}

simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, None);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
    PlaySound(Sound'A3.gexparta',SLOT_None,TransientSoundVolume*0.5,,TransientSoundRadius);

	Explode(Location, HitNormal);
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner || ( vehicle(Instigator)!=None&&Other==Vehicle(Instigator).Driver ) )))
		return;

	if (Role == ROLE_Authority)		// Do damage for direct hits
		DoDamage(Other, HitLocation);

	// Spawn projectile death effects and try radius damage
	HitActor = Other;
	Explode(HitLocation, vect(0,0,1));
}

defaultproperties
{
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo85AP'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=188.000000
     MotionBlurRadius=188.000000
     MotionBlurFactor=10.000000
     ShakeRotMag=(X=512.000000,Y=400.000000,Z=350.000000)
     ShakeRotRate=(X=7000.000000,Y=7000.000000,Z=5500.000000)
     ShakeRotTime=8.000000
     ShakeOffsetMag=(X=30.000000,Y=30.000000,Z=30.000000)
     ShakeOffsetRate=(X=600.000000,Y=600.000000,Z=600.000000)
     ShakeOffsetTime=10.000000
     Speed=20000.000000
     MaxSpeed=20000.000000
     Damage=880.000000
     DamageRadius=188.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_AP'
     StaticMesh=StaticMesh'DKVehiclesMesh.TankShel'
     DrawScale=4.000000
     AmbientGlow=96
     FluidSurfaceShootStrengthMod=10.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=10000.000000
}
