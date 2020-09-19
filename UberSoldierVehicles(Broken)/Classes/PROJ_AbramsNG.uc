class PROJ_AbramsNG extends DKProjectile;

var bool bSafeNormal;
var FX_FireEffect_AbramsMK2 Fire;
var FX_Tracer_IspolinAP Tracer;

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
          Fire = Spawn(class'FX_FireEffect_AbramsMK2',self,,Location); 
          Tracer = Spawn(class'FX_Tracer_IspolinAP',self,,Location);
	}

	Super.PostBeginPlay();
}

function BlowUp(vector HitLocation)
{
	HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	MakeNoise(1.0);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	Explode(Location, HitNormal);
}

simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, None);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    local int i;
    local rotator Rot;
    local PROJ_AbramsNapalm SmallShell;
    local int Surf;
	
	if (bExploded)
		return;
		
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
		
    if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (bCheckHitSurface)
			CheckSurface(HitLocation, HitNormal, Surf);
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
	}
	
	BlowUp(HitLocation);
	bExploded = True;
	
	if (!bNetTemporary && bTearOnExplode && (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer))
	{
		Velocity = vect(0,0,0);
		SetCollision(false,false,false);
		TearOffHitNormal = HitNormal;
		bTearOff = true;
		GoToState('NetTrapped');
	}
	
	if(Role==ROLE_Authority)
	{
            for (i=0; i<30; i++)
            {
			if(!bSafeNormal&&HitNormal==vect(0,0,1))
			{
				Rot=rotator(Velocity);
			}
		else
			rot=Rotator(HitNormal);
			Rot.Yaw+=FRand()*40000-30000;
			Rot.Pitch+=FRand()*40000-30000;
			Rot.Roll+=FRand()*40000-30000;
                        SmallShell = spawn(class'PROJ_AbramsNapalm',,,HitLocation+20*HitNormal,Rot);
            }
        }

	Destroy();
}

simulated function Destroyed()
{
        Tracer.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     FireSound=SoundGroup'DKoppIISound.88mm'
     FireSoundVolume=255.000000
     FireSoundRadius=1500.000000
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo105NG'
     SplashManager=Class'UberSoldierVehicles.IM_DK_ProjWater'
     ShakeRadius=1050.000000
     MotionBlurRadius=1050.000000
     MotionBlurFactor=10.000000
     Speed=15000.000000
     MaxSpeed=15000.000000
     Damage=1005.000000
     DamageRadius=1050.000000
     MomentumTransfer=2000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FG'
}
