class PROJ_DefenderFG_WT extends DKProjectile;

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
        Spawn(class'FX_FG_HighWaterHit',self,,Location); 
    }
Begin:
    SpawnExplosion();
    HurtRadius(Damage*0.500,DamageRadius*0.500,MyDamageType,MomentumTransfer,Location);
    Destroy();
}

defaultproperties
{
     ShakeRadius=900.000000
     MotionBlurRadius=900.000000
     MotionBlurFactor=10.000000
     Damage=900.000000
     DamageRadius=900.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FG'
     bHidden=True
     bNetTemporary=False
     bCanBeDamaged=False
     bCollideActors=False
     bCollideWorld=False
     bUseCylinderCollision=False
     ForceType=FT_DragAlong
}
