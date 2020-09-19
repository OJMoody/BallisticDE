class FX_Tracer_Libra extends DKEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter17
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
         StartSizeRange=(X=(Min=1.500000,Max=1.500000),Y=(Min=0.850000,Max=0.850000),Z=(Min=0.850000,Max=0.850000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=10.000000,Max=10.000000)
     End Object
     Emitters(0)=MeshEmitter'UberSoldierVehicles.FX_Tracer_Libra.MeshEmitter17'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter63
         UseDirectionAs=PTDU_Up
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.500000,Max=0.500000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationRange=(X=(Min=100.000000,Max=100.000000))
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.4361e4f6'
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_Tracer_Libra.SpriteEmitter63'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter64
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.500000,Max=0.500000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=60.000000)
         StartLocationRange=(X=(Min=-120.000000,Max=-120.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.LensFlare01'
         LifetimeRange=(Min=10.000000,Max=10.000000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_Tracer_Libra.SpriteEmitter64'

     Physics=PHYS_Trailer
     Skins(0)=Shader'XGameShaders.Trans.TransRing'
     AmbientGlow=255
     bHardAttach=True
}
