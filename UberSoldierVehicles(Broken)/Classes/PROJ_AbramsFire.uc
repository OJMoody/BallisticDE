class PROJ_AbramsFire extends DKProjectile;

function BlowUp(vector HitLocation) 
{
	MakeNoise(1.0);
	SetPhysics(PHYS_None);
	bHidden = true;
    GotoState('Dying');
}

simulated function Explode(vector HitLocation,vector HitNormal) 
{
}

simulated function HitWall(vector HitNormal, actor Wall)
{
	BlowUp(Location);
}

simulated function Landed( vector HitNormal )
{
	BlowUp(Location);
}



simulated function PhysicsVolumeChange(PhysicsVolume Volume) 
{
}

simulated function ProcessTouch (Actor Other, Vector HitLocation)
{
	if ( Other != instigator )
		Explode(HitLocation,Vect(0,0,1));
}

function TakeDamage(int Damage,Pawn InstigatedBy,vector HitLocation,
         vector Momentum,class<DamageType> DamageType) {
}

simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if ( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Hurtwall != Victims) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo') )
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			if ( Victims == LastTouched )
				LastTouched = None;
			Victims.TakeDamage
			(
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
			if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
				Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);

		}
	}
	if ( (LastTouched != None) && (LastTouched != self) && (LastTouched.Role == ROLE_Authority) && !LastTouched.IsA('FluidSurfaceInfo') )
	{
		Victims = LastTouched;
		LastTouched = None;
		dir = Victims.Location - HitLocation;
		dist = FMax(1,VSize(dir));
		dir = dir/dist;
		damageScale = FMax(Victims.CollisionRadius/(Victims.CollisionRadius + Victims.CollisionHeight),1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius));
		if ( Instigator == None || Instigator.Controller == None )
			Victims.SetDelayedDamageInstigatorController(InstigatorController);
		Victims.TakeDamage
		(
			damageScale * DamageAmount,
			Instigator,
			Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
			(damageScale * Momentum * dir),
			DamageType
		);
		if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
			Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);
	}

	bHurtEntry = false;
}

simulated event FellOutOfWorld(eKillZType KillType)
{
	BlowUp(Location);
}

auto state Dying 
{
    function SpawnExplosion() 
    {
        MakeNoise(1.0);
    }

    function BeginState()
    {
		bHidden = true;
		SetPhysics(PHYS_None);
		SetCollision(false,false,false);
		InitialState = 'Dying';
		SetTimer(0, false);
    }

Begin:
    SpawnExplosion();
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Destroy();
}

defaultproperties
{
     Damage=40.000000
     DamageRadius=200.000000
     MyDamageType=Class'UberSoldierVehicles.DT_Napalm'
     bNetTemporary=False
     Physics=PHYS_Falling
     bUnlit=False
     bCanBeDamaged=False
     bCollideActors=False
     bCollideWorld=False
     bProjTarget=True
     bUseCylinderCollision=False
     bFixedRotationDir=True
     ForceType=FT_DragAlong
}
