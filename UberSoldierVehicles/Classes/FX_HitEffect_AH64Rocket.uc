class FX_HitEffect_AH64Rocket extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=30.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter67
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
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=2.000000)
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7634_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.721763,Max=1.721763)
         StartVelocityRange=(Z=(Min=50.000000,Max=50.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_AH64Rocket.SpriteEmitter67'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter68
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
         SpinsPerSecondRange=(Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=400.000000,Max=400.000000),Y=(Min=400.000000,Max=400.000000),Z=(Min=400.000000,Max=400.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=1.200000,Max=1.200000)
         StartVelocityRange=(Z=(Min=200.000000,Max=200.000000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_AH64Rocket.SpriteEmitter68'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter69
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.344353
         FadeInEndTime=0.275482
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=-1000.000000,Max=1000.000000))
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_AH64Rocket.SpriteEmitter69'

     LightType=LT_SubtlePulse
     LightEffect=LE_QuadraticNonIncidence
     LightHue=21
     LightSaturation=30
     LightBrightness=255.000000
     LightRadius=20.000000
     bDynamicLight=True
}
