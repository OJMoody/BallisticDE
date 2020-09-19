class PROJ_AnakondaFP_Exp extends DKProjectile;

function BlowUp(vector HitLocation) 
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

function TakeDamage(int Damage,Pawn InstigatedBy,vector HitLocation,
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
     ImpactManager=Class'UberSoldierVehicles.IM_Ammo22FP'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     Speed=60000.000000
     MaxSpeed=60000.000000
     Damage=110.000000
     DamageRadius=220.000000
     MomentumTransfer=6000.000000
     MyDamageType=Class'UberSoldierVehicles.DT_FG'
}
