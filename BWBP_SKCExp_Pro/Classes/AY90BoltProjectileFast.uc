//=============================================================================
// HVPCBoltPlasmaRedMk5HVPCBlueGreen
//
// Massive damage red plasma bolt. Explodes terrorists like it's Wednesday.
//
// Added healing of vehicles and Powercores to replace linkgun in Onslaught
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90BoltProjectileFast extends BallisticProjectile;

var vector					StartLocation;
var bool					bScaleDone;


simulated function PreBeginPlay()
{
    local BallisticWeapon BW;
    Super(Projectile).PreBeginPlay();

    if (Instigator == None)
        return;

    BW = BallisticWeapon(Instigator.Weapon);

    if (BW == None)
        return;

    BW.default.ParamsClasses[BW.GameStyleIndex].static.OverrideProjectileParams(BW, self, 1);
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	StartLocation = Location;
}

// A73 heals vehicles and PowerCores
simulated function DoDamage(Actor Other, vector HitLocation)
{
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local int AdjustedDamage;

	if (Instigator != None)
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
	}

	HealObjective = DestroyableObjective(Other);
	if ( HealObjective == None )
		HealObjective = DestroyableObjective(Other.Owner);
	if ( HealObjective != None && HealObjective.TeamLink(Instigator.GetTeamNum()) )
	{
		HealObjective.HealDamage(AdjustedDamage, InstigatorController, myDamageType);
		return;
	}
	HealVehicle = Vehicle(Other);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		HealVehicle.HealDamage(AdjustedDamage, InstigatorController, myDamageType);
		return;
	}
	super.DoDamage(Other, HitLocation);
}

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)) || RSDarkProjectile(Other)!=None || RSDarkFastProjectile(Other)!=None)
		return;

	if (Role == ROLE_Authority && Other != HitActor)		// Do damage for direct hits
		DoDamage(Other, HitLocation);
	if (Pawn(Other) != None && Pawn(Other).Health <= 0)
		PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, 2, Level.GetLocalPlayerController(), 4/*HF_NoDecals*/);
	else
		PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, 1, Level.GetLocalPlayerController(), 4/*HF_NoDecals*/);
	ImpactManager = None;
	HitActor = Other;
	Explode(HitLocation, vect(0,0,1));
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local byte Flags;

	if (bExploded)
		return;
	if ( HitActor != None && (Vehicle(HitActor)!=None || DestroyableObjective(HitActor)!=None || DestroyableObjective(HitActor.Owner)!=None) && Instigator!= None && HitActor.TeamLink(Instigator.GetTeamNum()) )
	{
	}
	else if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (HitActor != None && (Vehicle(HitActor)!=None || DestroyableObjective(HitActor)!=None || DestroyableObjective(HitActor.Owner)!=None))
			Flags=4;//No Decals
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/, Flags);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator, Flags);
	}
	BlowUp(HitLocation);
	bExploded=true;

	Destroy();
}

simulated function HitWall(vector HitNormal, actor Wall)
{
	local Vehicle HealVehicle;
	local int AdjustedDamage;

	HealVehicle = Vehicle(Wall);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		AdjustedDamage = Damage * Instigator.DamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
		HealVehicle.HealDamage(AdjustedDamage, Instigator.Controller, myDamageType);
		BlowUp(Location + ExploWallOut * HitNormal);

		Destroy();
	}
	else
		Super.HitWall(HitNormal, Wall);
}

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	bDynamicLight=default.bDynamicLight;
	if (level.DetailMode > DM_Low && level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(Rotation,X,Y,Z);
		Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		if (Emitter(Trail) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
		if (Trail != None)
			Trail.SetBase (self);
	}
}

simulated function DestroyEffects()
{
	if (Trail != None)
	{
		if (Emitter(Trail) != None)
		{
			Emitter(Trail).Emitters[0].Disabled=true;
			Emitter(Trail).Kill();
		}
		else
			Trail.Destroy();
	}
}

defaultproperties
{
     MyDamageType=Class'BWBP_SKCExp_Pro.DTAY90Skrith'
	 DamageTypeHead=Class'BWBP_SKCExp_Pro.DTAY90SkrithHead'
     MyRadiusDamageType=Class'BWBP_SKCExp_Pro.DTAY90SkrithRadius'
	 ImpactManager=Class'BallisticProV55.IM_A73Lob'
     PenetrateManager=Class'BallisticProV55.IM_A73Lob'
     bPenetrate=True
     bRandomStartRotation=False
     AccelSpeed=90000.000000
     TrailClass=Class'BallisticProV55.A73TrailEmitter'
     bUsePositionalDamage=True
     Damage=75
     HeadMult=1.5
     LimbMult=0.5
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=50.000000
     MaxSpeed=8000.000000
     DamageRadius=265.000000
     MomentumTransfer=65000.000000
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=150
     LightSaturation=0
     LightBrightness=192.000000
	 LightRadius=9.000000
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.A73.A73Projectile'
     bDynamicLight=True
     AmbientSound=Sound'BW_Core_WeaponSound.A73.A73ProjFly'
     LifeSpan=6.000000
     DrawScale3D=(X=0.500000,Y=3.000000,Z=3.000000)
     Skins(1)=FinalBlend'BWBP_SKC_Tex.SkrithBow.AY90ProjectileFast1-Final'
     Skins(0)=FinalBlend'BWBP_SKC_Tex.A73b.AY90Projectile2-Final'
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     bFixedRotationDir=True
     RotationRate=(Roll=12384)
}
