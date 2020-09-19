class FX_TracerOFF_DefenderAP extends DKEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'DKVehiclesMesh.Effect.TankShell'
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.450000,Max=0.450000),Z=(Min=0.450000,Max=0.450000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=20000.000000,Max=20000.000000))
     End Object
     Emitters(0)=MeshEmitter'UberSoldierVehicles.FX_TracerOFF_DefenderAP.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseDirectionAs=PTDU_Up
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationRange=(X=(Min=-100.000000,Max=-100.000000))
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=180.000000,Max=180.000000),Z=(Min=180.000000,Max=180.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.spark_stretched_a_tiled'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=20000.000000,Max=20000.000000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_TracerOFF_DefenderAP.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.300000),Z=(Min=0.500000,Max=0.500000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=60.000000)
         StartLocationRange=(X=(Min=-100.000000,Max=-100.000000))
         StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=20000.000000,Max=20000.000000))
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_TracerOFF_DefenderAP.SpriteEmitter6'

     AmbientGlow=0
}
