//=============================================================================
// M50Grenade.
//
// Grenade fired by M900 Attached grenade launcher.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RGPXFlakGrenade extends BallisticGrenade;

var bool bArmed;
var float ArmingDelay;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	SetTimer(ArmingDelay, False);
}

simulated function Timer()
{
	if(StartDelay > 0)
	{
		Super.Timer();
		return;
	}
	
	if (!bHasImpacted)
		DetonateOn=DT_Impact;
		
	else Explode(Location, vect(0,0,1));
}

simulated event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;
	
	if (DetonateOn == DT_Impact)
	{
		Explode(Location, HitNormal);
		return;
	}
	else if (DetonateOn == DT_ImpactTimed && !bHasImpacted)
	{
		SetTimer(DetonateDelay, false);
	}
	if (Pawn(Wall) != None)
	{
		DampenFactor *= 0.2;
		DampenFactorParallel *= 0.2;
	}

	bCanHitOwner=true;
	bHasImpacted=true;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

	if (RandomSpin != 0)
		RandSpin(100000);
	
	Speed = VSize(Velocity/2);

	if (Speed < 20)
	{
		bBounce = False;
		SetPhysics(PHYS_None);
		if (Trail != None && !TrailWhenStill)
		{
			DestroyEffects();
		}
	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc, 1.5);
			if (Instigator == None)
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Instigator);
    }
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local vector Start;
    local rotator Dir;
    local int i;

	Start = Location + 30 * HitNormal;
	if (FlakCount > 0 && FlakClass != None)
	{
		for (i=0;i<FlakCount;i++)
		{
			Dir = Rotator(HitNormal);
			Dir.Yaw += FRand()*2048-1024;
			Dir.Pitch += FRand()*2048-1024;
			Spawn( FlakClass,, '', Start, Dir);
		}
	}
	super.Explode(HitLocation, HitNormal);
}

simulated function BlowUp(vector HitLocation)
{
	TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	if ( Role == ROLE_Authority )
		MakeNoise(1.0);
}

defaultproperties
{
	ArmingDelay=0.025
    DetonateOn=DT_ImpactTimed
    PlayerImpactType=PIT_Detonate
    bNoInitialSpin=True
    bAlignToVelocity=True
    DetonateDelay=1.000000
    ImpactDamage=40
    ImpactDamageType=Class'BallisticProV55.DTM50Grenade'
    ImpactManager=Class'BallisticProV55.IM_M50Grenade'
    ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
    TrailClass=Class'BallisticProV55.M50GrenadeTrail'
    TrailOffset=(X=-8.000000)
    MyRadiusDamageType=Class'BallisticProV55.DTM50GrenadeRadius'
    SplashManager=Class'BallisticProV55.IM_ProjWater'
	FlakCount=6
	FlakClass=Class'BWBP_JCF_Pro.RGPXFlakRocket'
    ShakeRadius=512.000000
    MotionBlurRadius=384.000000
    MotionBlurFactor=3.000000
    MotionBlurTime=4.000000
    Speed=1800.000000
    Damage=110.000000
    DamageRadius=512.000000
    WallPenetrationForce=128
    MyDamageType=Class'BallisticProV55.DTM50GrenadeRadius'
    ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
    StaticMesh=StaticMesh'BWBP_JCF_Static.RGP-X350.RGP-X350_ProjMain'
    bIgnoreTerminalVelocity=True
	ModeIndex=1
	DrawScale=0.180000
}
