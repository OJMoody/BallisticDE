class PROJ_DefenderRadiation extends DKProjectile;

function BlowUp(vector HitLocation) {
}

simulated function Explode(vector HitLocation,vector HitNormal) {
}

simulated event FellOutOfWorld(eKillZType KillType) {
}

simulated function HitWall(vector HitNormal,Actor Wall) {
}

simulated function Landed(vector HitNormal) {
}

simulated function PhysicsVolumeChange(PhysicsVolume Volume) {
}

simulated function ProcessTouch(Actor Other,vector HitLocation) {
}

function TakeDamage(int Damage,Pawn InstigatedBy,vector HitLocation,
         vector Momentum,class<DamageType> DamageType) {
}

auto state Dying {
    function SpawnExplosion() {
        MakeNoise(1.0);
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
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Sleep(0.5);
    HurtRadius(Damage,DamageRadius*1.000,MyDamageType,MomentumTransfer,Location);
    Destroy();
}

defaultproperties
{
     Damage=10.000000
     DamageRadius=700.000000
     MyDamageType=Class'UberSoldierVehicles.DT_Radiation'
     bNetTemporary=False
     bCanBeDamaged=False
     bCollideActors=False
     bCollideWorld=False
     bUseCylinderCollision=False
     ForceType=FT_DragAlong
}
