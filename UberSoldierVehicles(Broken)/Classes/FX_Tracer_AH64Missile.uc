class FX_Tracer_AH64Missile extends DKEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter3
         StaticMesh=StaticMesh'DKVehiclesMesh.AH64.AH64_Rocket'
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=40.000000)
         SpinsPerSecondRange=(Z=(Min=0.300000,Max=0.300000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=2.500000,Max=2.500000),Y=(Min=2.500000,Max=2.500000),Z=(Min=2.500000,Max=2.500000))
         InitialParticlesPerSecond=10000.000000
         LifetimeRange=(Min=10.000000,Max=10.000000)
     End Object
     Emitters(0)=MeshEmitter'UberSoldierVehicles.FX_Tracer_AH64Missile.MeshEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter24
         UseDirectionAs=PTDU_Up
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=100.000000)
         StartLocationRange=(X=(Min=100.000000,Max=100.000000))
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_Tracer_AH64Missile.SpriteEmitter24'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter31
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=130.000000)
         StartLocationRange=(X=(Min=-18.000000,Max=-18.000000))
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=10.000000,Max=10.000000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_Tracer_AH64Missile.SpriteEmitter31'

     Physics=PHYS_Trailer
     bHardAttach=True
}
