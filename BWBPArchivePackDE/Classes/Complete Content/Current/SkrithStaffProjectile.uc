//=============================================================================
// A73Projectile.
//
// Simple projectile for the elite A762.2.
// Added healing of vehicles and Powercores to replace linkgun in Onslaught
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SkrithStaffProjectile extends BallisticProjectile;

var vector					StartLocation;
var bool					bScaleDone;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	StartLocation = Location;
}

// Projectile grows as it comes out the gun...
simulated function Tick(float DT)
{
	local vector DS;

	if (bScaleDone)
		return;

	DS.X = VSize(Location-StartLocation)/(384*DrawScale);
	DS.Y = 0.5;
	DS.Z = 0.5;
	if (DS.X >= 1)
	{
		DS.X = 1;
		bScaleDone=true;
	}
	SetDrawScale3D(DS);
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
			AdjustedDamage *= 4;
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
			AdjustedDamage *= 4;
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
     ImpactManager=Class'BWBPArchivePackDE.IM_SkrithStaffProjectile'
     PenetrateManager=Class'BWBPArchivePackDE.IM_SkrithStaffProjectile'
     bPenetrate=True
     bRandomStartRotaion=False
     AccelSpeed=100000.000000
     TrailClass=Class'BWBPArchivePackDE.SkrithStaffTrailEmitter'
     MyRadiusDamageType=Class'BWBPArchivePackDE.DT_SkrithStaff'
     bTearOnExplode=False
     bUsePositionalDamage=True
     DamageHead=60
     DamageLimb=45
     DamageTypeHead=Class'BWBPArchivePackDE.DT_SkrithStaffHead'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     Speed=11000.000000
     MaxSpeed=11000.000000
     Damage=45.000000
     DamageRadius=96.000000
     MomentumTransfer=150.000000
     MyDamageType=Class'BWBPArchivePackDE.DT_SkrithStaff'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=10
     LightSaturation=50
     LightBrightness=192.000000
     LightRadius=0.000000
     StaticMesh=StaticMesh'BallisticHardware2.A73.A73Projectile'
     bDynamicLight=True
     AmbientSound=Sound'BallisticSounds2.A73.A73ProjFly'
     LifeSpan=4.000000
     Skins(0)=FinalBlend'BallisticRecolorsArchive5.A73b.A73BProjFinal'
     Skins(1)=FinalBlend'BallisticRecolorsArchive5.A73b.A73BProj2Final'
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     bFixedRotationDir=True
     RotationRate=(Roll=16384)
}
