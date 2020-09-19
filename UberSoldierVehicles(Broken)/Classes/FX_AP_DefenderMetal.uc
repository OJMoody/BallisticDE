class FX_AP_DefenderMetal extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=50.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.018000
         MaxParticles=5
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=70.000000,Max=70.000000),Y=(Min=70.000000,Max=70.000000),Z=(Min=70.000000,Max=70.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.Artificial_Light_lgA_0'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         VelocityLossRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_AP_DefenderMetal.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseDirectionAs=PTDU_Up
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=0.240000
         FadeInEndTime=0.040000
         MaxParticles=70
         DetailMode=DM_SuperHigh
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=100.000000,Max=2200.000000),Y=(Min=-1800.000000,Max=1800.000000),Z=(Min=-1800.000000,Max=1800.000000))
         VelocityLossRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_AP_DefenderMetal.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.018000
         MaxParticles=200
         AddLocationFromOtherEmitter=1
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=3.500000,Max=3.500000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=100.000000,Max=100.000000))
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_AP_DefenderMetal.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.018000
         MaxParticles=200
         AddLocationFromOtherEmitter=2
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.LensFlare02'
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_AP_DefenderMetal.SpriteEmitter8'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=78
     LightSaturation=74
     LightBrightness=255.000000
     LightRadius=40.000000
     bDynamicLight=True
     AmbientGlow=192
}
