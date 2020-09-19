class FX_IspolinLaserEffect extends DKEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BallisticHardware2.Lasers.LaserHex'
         UseParticleColor=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         UseRotationFrom=PTRS_Actor
         StartSizeRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=1.500000,Max=1.500000))
         InitialParticlesPerSecond=1000.000000
         LifetimeRange=(Min=99999.000000,Max=99999.000000)
     End Object
     Emitters(0)=MeshEmitter'UberSoldierVehicles.FX_IspolinLaserEffect.MeshEmitter0'

     bTrailerSameRotation=True
     Physics=PHYS_Trailer
}
