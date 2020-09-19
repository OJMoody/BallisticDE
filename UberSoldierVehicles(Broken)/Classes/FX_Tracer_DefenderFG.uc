class FX_Tracer_DefenderFG extends DKEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter10
         StaticMesh=StaticMesh'DKVehiclesMesh.Effect.TankShell'
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(Z=(Min=0.300000,Max=0.300000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         InitialParticlesPerSecond=10000.000000
         LifetimeRange=(Min=10.000000,Max=10.000000)
     End Object
     Emitters(0)=MeshEmitter'UberSoldierVehicles.FX_Tracer_DefenderFG.MeshEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter49
         UseDirectionAs=PTDU_Up
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.300000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationRange=(X=(Min=120.000000,Max=120.000000))
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.spark_stretched_a_tiled'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_Tracer_DefenderFG.SpriteEmitter49'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter50
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=60.000000)
         StartLocationRange=(X=(Min=-15.000000,Max=-15.000000))
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=10.000000,Max=10.000000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_Tracer_DefenderFG.SpriteEmitter50'

     Physics=PHYS_Trailer
     AmbientGlow=255
     bHardAttach=True
}
