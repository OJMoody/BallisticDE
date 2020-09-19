class FX_Tracer_MI48NG extends DKEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'DKVehiclesMesh.RocketShell'
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
         StartSizeRange=(X=(Min=0.150000,Max=0.150000),Y=(Min=0.150000,Max=0.150000),Z=(Min=0.150000,Max=0.150000))
         InitialParticlesPerSecond=10000.000000
         LifetimeRange=(Min=10.000000,Max=10.000000)
     End Object
     Emitters(0)=MeshEmitter'UberSoldierVehicles.FX_Tracer_MI48NG.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter50
         UseDirectionAs=PTDU_Up
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=40.000000)
         StartLocationRange=(X=(Min=100.000000,Max=100.000000))
         StartSizeRange=(X=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_Tracer_MI48NG.SpriteEmitter50'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter51
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=100.000000)
         StartLocationRange=(X=(Min=-18.000000,Max=-18.000000))
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=10.000000,Max=10.000000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_Tracer_MI48NG.SpriteEmitter51'

     Physics=PHYS_Trailer
     bHardAttach=True
}
