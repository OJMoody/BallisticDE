class FX_HitEffect_MI48NG extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=60.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter44
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.344353
         FadeInEndTime=0.275482
         MaxParticles=5
         SpinsPerSecondRange=(X=(Min=-0.300000,Max=0.300000))
         StartSpinRange=(X=(Min=-0.250000,Max=0.250000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-400.000000,Max=400.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=500.000000,Max=800.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_MI48NG.SpriteEmitter44'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter45
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.154959
         FadeInEndTime=0.068871
         MaxParticles=50
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=50.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7634_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         SubdivisionStart=3
         SubdivisionEnd=64
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.721763,Max=1.721763)
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_MI48NG.SpriteEmitter45'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter46
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.344353
         FadeInEndTime=0.275482
         MaxParticles=30
         StartLocationRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000))
         SpinsPerSecondRange=(X=(Min=-0.300000,Max=0.300000))
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_6682_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=8
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.721763,Max=1.721763)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_MI48NG.SpriteEmitter46'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter47
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.344353
         FadeInEndTime=0.275482
         MaxParticles=5
         StartLocationRange=(Z=(Min=100.000000,Max=100.000000))
         SpinsPerSecondRange=(X=(Min=-0.300000,Max=0.300000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=2.000000)
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_6682_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=8
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.721763,Max=1.721763)
         StartVelocityRange=(Z=(Min=50.000000,Max=50.000000))
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_MI48NG.SpriteEmitter47'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter49
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=400.000000,Max=400.000000),Y=(Min=400.000000,Max=400.000000),Z=(Min=400.000000,Max=400.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=1.200000,Max=1.200000)
         StartVelocityRange=(Z=(Min=200.000000,Max=200.000000))
     End Object
     Emitters(4)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_MI48NG.SpriteEmitter49'

     LightType=LT_SubtlePulse
     LightEffect=LE_QuadraticNonIncidence
     LightHue=21
     LightSaturation=30
     LightBrightness=255.000000
     LightRadius=60.000000
     bDynamicLight=True
}
