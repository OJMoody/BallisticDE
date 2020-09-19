class FX_AirTrailEffect extends DKEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'AW-2004Particles.Weapons.TurretFlash'
         UseMeshBlendMode=False
         UseParticleColor=True
         UseColorScale=True
         SpinParticles=True
         ColorScale(1)=(RelativeTime=0.317857,Color=(B=32,G=100,R=255))
         ColorScale(2)=(RelativeTime=0.657143,Color=(B=32,G=100,R=255))
         ColorScale(3)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartSpinRange=(Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1.500000,Max=1.500000),Y=(Min=1.500000,Max=1.500000),Z=(Min=1.500000,Max=1.500000))
         LifetimeRange=(Min=0.100000,Max=0.200000)
     End Object
     Emitters(0)=MeshEmitter'UberSoldierVehicles.FX_AirTrailEffect.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.125000,Color=(B=28,G=192,R=250))
         ColorScale(2)=(RelativeTime=0.400000,Color=(B=26,G=112,R=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(R=100))
         FadeOutStartTime=0.060000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=30
         StartLocationRange=(X=(Min=10.000000,Max=10.000000))
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.100000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         ParticlesPerSecond=100.000000
         InitialParticlesPerSecond=100.000000
         Texture=Texture'1945.Effects.Explosion_Flame'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-500.000000,Max=-500.000000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_AirTrailEffect.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.125000,Color=(B=28,G=192,R=250))
         ColorScale(2)=(RelativeTime=0.400000,Color=(B=26,G=112,R=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(R=100))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.600000
         FadeOutStartTime=0.400000
         FadeInEndTime=0.200000
         MaxParticles=300
         StartLocationRange=(X=(Min=-50.000000,Max=-50.000000))
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         ParticlesPerSecond=100.000000
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'G_FX.Smokes.smoke52Q'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=10.000000,Max=10.000000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_AirTrailEffect.SpriteEmitter1'

}
