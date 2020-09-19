//=============================================================================
// A42Projectile.
//
// Simple projectile for da A42.
//
// Added healing of vehicles and Powercores to replace linkgun in Onslaught
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BarrierPriProjectile extends BallisticProjectile;

var bool					bScaleDone;
var float				ScaleTime;
var float				HealthDrainAmount;

var   BarrierRifle			KM; //The Kinetic Manipulator	

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	ScaleTime = level.TimeSeconds + 0.8;
}

// Projectile grows as it comes out the gun...
simulated function Tick(float DT)
{
	local Weapon CurWeapon;
	local vector DS;

	DS = default.DrawScale3D;
	DS.X = (ScaleTime - level.TimeSeconds) / 0.6;
	
	if (DS.X >= 1)
	{
		DS.X = 1;
		Disable('Tick');
	}
	SetDrawScale3D(DS);

	if (Instigator != None)
	{
		CurWeapon = Instigator.Weapon;
		if (BarrierRifle(CurWeapon) != None)
			KM = BarrierRifle(CurWeapon);
	}
}

simulated function Actor GetDamageVictim (Actor Other, vector HitLocation, vector Dir, out float Dmg, optional out class<DamageType> DT)
{
	Super.GetDamageVictim(Other, HitLocation, Dir, Dmg, DT);
	
	Dmg *= 1 + 0.5 * (FMin(default.LifeSpan - LifeSpan, 0.6)/0.6);
	
	return Other;
}

simulated function DoDamage(Actor Other, vector HitLocation)
{
	local class<DamageType> DT;
	local float Dmg;
	local actor Victim;
	local bool bWasAlive;
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local int AdjustedDamage;
	local Vector ClosestLocation, temp, BoneTestLocation, NewMomentum, ZKickScale, OldVelocity;

	if (Instigator != None)
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling * MyDamageType.default.VehicleDamageScaling;
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

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	if (xPawn(Other) != None)
	{
		//Find a point on the victim's Z axis at the same height as the HitLocation.
		ClosestLocation = Other.Location;
		ClosestLocation.Z += (HitLocation - Other.Location).Z;
		
		//Extend the hit along the projectile's Velocity to a point where it is closest to the victim's Z axis.
		temp = Normal(Velocity);
		temp *= VSize(ClosestLocation - HitLocation);
		BoneTestLocation = temp;
		BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(temp);
		BoneTestLocation += HitLocation;
		
		Victim = GetDamageVictim(Other, BoneTestLocation, Normal(Velocity), Dmg, DT);;
	}

	else Victim = GetDamageVictim(Other, HitLocation, Normal(Velocity), Dmg, DT);

	if (BallisticPawn(Instigator) != None && RSNovaStaff(Instigator.Weapon) != None && Victim.bProjTarget && (Pawn(Victim).GetTeamNum() != Instigator.GetTeamNum() || Instigator.GetTeamNum() == 255))
		BallisticPawn(Instigator).GiveAttributedHealth(HealthDrainAmount, Instigator.SuperHealthMax, Instigator, True);

	if (xPawn(Victim) != None && Pawn(Victim).Health > 0)
	{
		if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
			bWasAlive = true;
	}
	else if (Vehicle(Victim) != None && Vehicle(Victim).Driver!=None && Vehicle(Victim).Driver.Health > 0)
		bWasAlive = true;
		
	ZKickScale.Z = ((Victim.Location.Z - HitLocation.Z) / Victim.CollisionHeight);
	NewMomentum = MomentumTransfer * Normal(Velocity);
	NewMomentum.Z = MomentumTransfer * ZKickScale.Z;	
	
	if (Pawn(Victim).Physics == PHYS_Falling)
		Dmg *= 2.00;

	OldVelocity.Z = Pawn(Victim).Velocity.Z * -0.5;	
	Pawn(Victim).AddVelocity(OldVelocity);
	
	if (NewMomentum.Z > default.MomentumTransfer)
	NewMomentum.Z = default.MomentumTransfer;

	KM.MomentumAmmo(Pawn(Victim),Dmg);
			
	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, NewMomentum, DT);

}

simulated function DoVehicleDriverRadius(Vehicle Other)
{
	local bool bWasAlive;
	local Pawn D;

	if (Other.Driver != None && Other.Driver.health > 0)
	{
		D = Other.Driver;
		bWasAlive = true;
	}

	Other.DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);

}

simulated singular function HitWall(vector HitNormal, actor Wall)
{

	local Vehicle HealVehicle;
	local int AdjustedDamage;

	HealVehicle = Vehicle(Wall);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling * MyDamageType.default.VehicleDamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
		HealVehicle.HealDamage(AdjustedDamage, Instigator.Controller, myDamageType);
		BlowUp(Location + ExploWallOut * HitNormal);

		if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
			GotoState('NetTrapped');
		else
			Destroy();
	}
	else if ( Role == ROLE_Authority )
	{
		if ( !Wall.bStatic && !Wall.bWorldGeometry && (Pawn(Wall) == None || Vehicle (Wall) != None)) // ignore pawns when using HitWall
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );
			DoDamage(Wall, Location);
			if (DamageRadius > 0 && Vehicle(Wall) != None && Vehicle(Wall).Health > 0)
				DoVehicleDriverRadius(Vehicle(Wall));
			HurtWall = Wall;
		}
		MakeNoise(1.0);
	}
	Explode(Location + ExploWallOut * HitNormal, HitNormal);

	HurtWall = None;
}

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)) || RSNovaProjectile(Other)!=None || RSNovaFastProjectile(Other)!=None)
		return;

	if (Role == ROLE_Authority)		// Do damage for direct hits
		DoDamage(Other, HitLocation);
	if (Pawn(Other) != None && Pawn(Other).Health <= 0)
		PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, 2, Level.GetLocalPlayerController(), 4/*HF_NoDecals*/);
	else
		PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, 1, Level.GetLocalPlayerController(), 4/*HF_NoDecals*/);
	ImpactManager = None;
	if (Role == ROLE_Authority)
	{
		HitActor = Other;
		Explode(HitLocation, vect(0,0,1));
	}
}

simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Excluded )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir, NewMomentum, ZKickScale, OldVelocity, NullVector;
	local bool bWasAlive, bHitOthers, bHitSelf;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && (Excluded == None || Victims != Excluded) && Victims != HurtWall)
		{
			if (xPawn(Victims) != None && Pawn(Victims).Health > 0)
				bWasAlive = true;
			else if (Vehicle(Victims) != None && Vehicle(Victims).Driver!=None && Vehicle(Victims).Driver.Health > 0)
				bWasAlive = true;
			else
				bWasAlive = false;
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
				
			NewMomentum = (damageScale * Momentum * dir);
			ZKickScale.Z = ((Victims.Location.Z - HitLocation.Z) / Victims.CollisionHeight);
			NewMomentum.Z = MomentumTransfer * ZKickScale.Z * damageScale;	
			
			OldVelocity.Z = Pawn(Victims).Velocity.Z * -0.5;	
			Pawn(Victims).AddVelocity(OldVelocity);
			
			if (Victims == Instigator && xPawn(Victims) != None)
			{
				DamageAmount *= 0.5;
				NewMomentum.X *= 1.25;
				NewMomentum.Y *= 1.25;
				bHitSelf=True;
			}
			
			if (Victims != Instigator && xPawn(Victims) != None)
				bHitOthers = true;
			
			if (NewMomentum.Z > default.MomentumTransfer)
				NewMomentum.Z = default.MomentumTransfer;
			
			KM.MomentumAmmo(Pawn(Victims),(DamageScale * DamageAmount));	
			
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				NewMomentum,
				DamageType
			);
		}
		if (bHitOthers && bHitSelf)
			class'BallisticDamageType'.static.GenericHurt(Instigator, 0.5 * DamageAmount, Instigator, Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir, NullVector, DamageType);
		bHitOthers = False;
		bHitOthers = True;
	}
	bHurtEntry = false;
}

simulated state NetTrapped
{
	function BeginState()
	{
		HideProjectile();
		SetTimer(NetTrappedDelay, false);
		DestroyEffects();
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
     ImpactManager=Class'BallisticDE.IM_RSNovaProjectile'
     PenetrateManager=Class'BallisticDE.IM_RSNovaProjectile'
     bRandomStartRotaion=False
     AccelSpeed=90000.000000
     TrailClass=Class'BallisticDE.RSNova1Trail'
     MyRadiusDamageType=Class'BallisticDE.DT_RSNovaSlow'
     bTearOnExplode=False
     DamageHead=60.000000
     DamageLimb=30.000000
     DamageTypeHead=Class'BallisticDE.DT_RSNovaSlow'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=384.000000
     ShakeRotMag=(Y=200.000000,Z=128.000000)
     ShakeRotRate=(X=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Y=15.000000,Z=15.000000)
     ShakeOffsetTime=2.000000
     Speed=6000.000000
     MaxSpeed=10000.000000
     bSwitchToZeroCollision=True
     Damage=30.000000
     DamageRadius=196.000000
     MomentumTransfer=90000.000000
     MyDamageType=Class'BallisticDE.DT_RSNovaSlow'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=160
     LightSaturation=90
     LightBrightness=192.000000
     LightRadius=10.000000
     StaticMesh=StaticMesh'BWBP4-Hardware.NovaStaff.NovaProjectile'
     bDynamicLight=True
     bNetTemporary=False
     bSkipActorPropertyReplication=True
     bOnlyDirtyReplication=True
     AmbientSound=Sound'BWBP4-Sounds.NovaStaff.Nova-Fire1FlyBy'
     LifeSpan=4.000000
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bProjTarget=True
     bFixedRotationDir=True
     RotationRate=(Roll=16384)
}
