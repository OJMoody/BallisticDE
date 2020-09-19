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
class BarrierSecProjectile extends BarrierPriProjectile;

var   BarrierProjDamageHull DamageHull;// Da collidey fing spawned to get damaged to blow dis rocket up
var	float	StoredDamage;

simulated function InitProjectile()
{
	Super.InitProjectile();

	if (Role < ROLE_Authority)
		InitMortar();
}
simulated event Destroyed()
{
	if (DamageHull != None)
		DamageHull.Destroy();
	super.Destroyed();
}
simulated function InitMortar()
{
	if (Role == ROLE_Authority && DamageHull == None)
	{
		DamageHull = Spawn(class'BarrierProjDamageHull',Instigator,,location,Rotation);
		DamageHull.SetBase(Self);
//		DamageHull.SetOwner(Instigator);
	}
	Velocity += instigator.Velocity;
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (BarrierProjDamageHull(Other) != None && (Other == DamageHull || DamageHull == None))
		return;
	super.ProcessTouch(Other, HitLocation);
}

// Got hit, explode immediately - improved proj code handles this
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (class<BallisticDamageType>(DamageType) != None)
		return;
	StoredDamage+=Damage;	
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
	local Vector ClosestLocation, temp, BoneTestLocation;

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

	if (xPawn(Victim) != None && Pawn(Victim).Health < StoredDamage && bWasAlive)
		Dmg = Pawn(Victim).Health - 1;
	else
		Dmg = StoredDamage;	
		
	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, (Velocity * 10) * Normal(Velocity), DT);

}

defaultproperties
{
     AccelSpeed=0.000000
     DamageHead=120.000000
     DamageLimb=60.000000
     Speed=5000.000000
     Damage=0.000000
     DamageRadius=32.000000
     MomentumTransfer=0.000000
     DrawScale=1.000000
}
