class FX_TankDestroy_Light extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=70.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(A=192))
         ColorScale(1)=(RelativeTime=1.000000)
         FadeOutStartTime=0.136000
         FadeInEndTime=0.048000
         DetailMode=DM_SuperHigh
         StartLocationOffset=(Z=50.000000)
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.2bb8a332'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-500.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_Light.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter16
         UseDirectionAs=PTDU_Up
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-800.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=50
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-2000.000000,Max=2000.000000),Y=(Min=-2000.000000,Max=2000.000000),Z=(Min=500.000000,Max=2000.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_Light.SpriteEmitter16'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(A=192))
         ColorScale(1)=(RelativeTime=1.000000)
         ColorMultiplierRange=(Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.040000
         FadeInEndTime=0.040000
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationOffset=(Z=200.000000)
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=8.000000)
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=80.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=1.800000,Max=1.800000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_Light.SpriteEmitter17'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
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
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=0
         StartLocationRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-2000.000000,Max=2000.000000),Y=(Min=-2000.000000,Max=2000.000000),Z=(Min=-1000.000000,Max=1000.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_Light.SpriteEmitter18'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter19
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=1000
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=10.000000,Max=10.000000))
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(4)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_Light.SpriteEmitter19'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter20
         UseDirectionAs=PTDU_Up
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-800.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.2bb8a3322'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=500.000000,Max=1000.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(5)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_Light.SpriteEmitter20'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=400
         AddLocationFromOtherEmitter=5
         SpinsPerSecondRange=(X=(Min=0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=200.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_6682_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=8
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(6)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_Light.SpriteEmitter21'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter22
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         Opacity=0.500000
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=400
         AddLocationFromOtherEmitter=5
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=200.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7466_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         LifetimeRange=(Min=6.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Max=10.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(7)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_Light.SpriteEmitter22'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter23
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
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=300
         AddLocationFromOtherEmitter=1
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=300.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Max=500.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(8)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_Light.SpriteEmitter23'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter24
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(A=192))
         ColorScale(1)=(RelativeTime=1.000000)
         FadeOutStartTime=0.136000
         FadeInEndTime=0.048000
         DetailMode=DM_SuperHigh
         StartLocationOffset=(Z=50.000000)
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.2bb8a332'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-500.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
     End Object
     Emitters(9)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_Light.SpriteEmitter24'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter25
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(A=192))
         ColorScale(1)=(RelativeTime=1.000000)
         ColorMultiplierRange=(Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.040000
         FadeInEndTime=0.040000
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationOffset=(Z=200.000000)
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=8.000000)
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=80.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=1.800000,Max=1.800000)
     End Object
     Emitters(10)=SpriteEmitter'UberSoldierVehicles.FX_TankDestroy_Light.SpriteEmitter25'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=35
     LightSaturation=40
     LightBrightness=200.000000
     LightRadius=70.000000
     bDynamicLight=True
}
