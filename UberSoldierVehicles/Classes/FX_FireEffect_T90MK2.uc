class FX_FireEffect_T90MK2 extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=50.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     EhoFireSound=SoundGroup'DKoppIISound.Hit.EhoC'
     EhoFireSoundVolume=1.000000
     EhoFireSoundRadius=100000.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter24
         RespawnDeadParticles=False
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,R=255))
         Opacity=0.000000
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=130.000000,Max=130.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'G_FX.Smokes.Kafire2'
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_FireEffect_T90MK2.SpriteEmitter24'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter25
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorScale(0)=(Color=(B=140,G=140,R=140,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=150,G=150,R=150))
         FadeOutStartTime=0.105000
         FadeInEndTime=0.060000
         MaxParticles=50
         AddLocationFromOtherEmitter=0
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.800000,Max=0.800000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_6682_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=8
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Max=50.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-500.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_FireEffect_T90MK2.SpriteEmitter25'

     Begin Object Class=MeshEmitter Name=MeshEmitter4
         StaticMesh=StaticMesh'BallisticHardware2.M353.M353MuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.016000
         FadeInEndTime=0.010000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         AddLocationFromOtherEmitter=0
         StartSpinRange=(Z=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.750000,RelativeSize=3.000000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         InitialParticlesPerSecond=10000.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(2)=MeshEmitter'UberSoldierVehicles.FX_FireEffect_T90MK2.MeshEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         Acceleration=(Z=5.000000)
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255,A=150))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.500000
         FadeOutStartTime=0.210000
         MaxParticles=50
         AddLocationFromOtherEmitter=0
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=50.000000,Max=80.000000),Y=(Min=50.000000,Max=80.000000),Z=(Min=50.000000,Max=80.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7466_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=30.000000,Max=5000.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-300.000000,Max=300.000000))
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         AddVelocityFromOtherEmitter=0
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_FireEffect_T90MK2.SpriteEmitter26'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter27
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         Acceleration=(Z=20.000000)
         ColorScale(1)=(RelativeTime=0.514286,Color=(B=255,G=255,R=255,A=150))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.500000
         FadeOutStartTime=0.210000
         MaxParticles=50
         AddLocationFromOtherEmitter=0
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=10.000000),Y=(Min=10.000000),Z=(Min=10.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7466_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=10.000000,Max=150.000000),Y=(Min=-1500.000000,Max=1500.000000),Z=(Min=-1500.000000,Max=1500.000000))
         VelocityLossRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(4)=SpriteEmitter'UberSoldierVehicles.FX_FireEffect_T90MK2.SpriteEmitter27'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter28
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorScale(0)=(Color=(B=140,G=140,R=140,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=150,G=150,R=150))
         FadeOutStartTime=0.105000
         FadeInEndTime=0.060000
         MaxParticles=50
         AddLocationFromOtherEmitter=0
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.800000,Max=0.800000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=0.200000)
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_6682_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=8
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Max=2000.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(5)=SpriteEmitter'UberSoldierVehicles.FX_FireEffect_T90MK2.SpriteEmitter28'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter29
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorScale(0)=(Color=(B=140,G=140,R=140,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=150,G=150,R=150))
         FadeOutStartTime=0.105000
         FadeInEndTime=0.060000
         MaxParticles=1
         AddLocationFromOtherEmitter=0
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=700.000000,Max=700.000000),Y=(Min=700.000000,Max=700.000000),Z=(Min=700.000000,Max=700.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(6)=SpriteEmitter'UberSoldierVehicles.FX_FireEffect_T90MK2.SpriteEmitter29'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter30
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorScale(0)=(Color=(B=140,G=140,R=140,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=150,G=150,R=150))
         FadeOutStartTime=0.105000
         FadeInEndTime=0.060000
         MaxParticles=1
         AddLocationFromOtherEmitter=0
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=400.000000,Max=400.000000),Y=(Min=400.000000,Max=400.000000),Z=(Min=400.000000,Max=400.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=2000.000000,Max=2000.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(7)=SpriteEmitter'UberSoldierVehicles.FX_FireEffect_T90MK2.SpriteEmitter30'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter31
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=100))
         ColorScale(1)=(RelativeTime=0.514286,Color=(B=255,G=255,R=255,A=200))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.210000
         MaxParticles=100
         AddLocationFromOtherEmitter=0
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=10.000000,Max=2000.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-500.000000,Max=500.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(8)=SpriteEmitter'UberSoldierVehicles.FX_FireEffect_T90MK2.SpriteEmitter31'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=30
     LightSaturation=50
     LightBrightness=255.000000
     LightRadius=50.000000
     bDynamicLight=True
     AmbientGlow=255
}
