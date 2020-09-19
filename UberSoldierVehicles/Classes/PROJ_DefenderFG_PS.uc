class PROJ_DefenderFG_PS extends DKProjectile;

simulated function BlowUp(vector HitLocation) 
{
}

simulated function Explode(vector HitLocation,vector HitNormal) 
{
}

simulated event FellOutOfWorld(eKillZType KillType) 
{
}

simulated function HitWall(vector HitNormal,Actor Wall) 
{
}

simulated function Landed(vector HitNormal) 
{
}

simulated function PhysicsVolumeChange(PhysicsVolume Volume) 
{
}

simulated function ProcessTouch(Actor Other,vector HitLocation) 
{
}

simulated function TakeDamage(int Damage,Pawn InstigatedBy,vector HitLocation,
         vector Momentum,class<DamageType> DamageType) 
{
}

auto state Dying {
    function SpawnExplosion() 
    {
        MakeNoise(1.0);
    }
Begin:
    SpawnExplosion();
    HurtRadius(Damage*1.000,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Destroy();
}

defaultproperties
{
     Damage=9.000000
     DamageRadius=2000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FG_PS'
     bHidden=True
     bNetTemporary=False
     bCanBeDamaged=False
     bCollideActors=False
     bCollideWorld=False
     bUseCylinderCollision=False
     ForceType=FT_DragAlong
}
