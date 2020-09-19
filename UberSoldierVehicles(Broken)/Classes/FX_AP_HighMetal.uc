class FX_AP_HighMetal extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=60.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseDirectionAs=PTDU_Up
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         RespawnDeadParticles=False
         DampRotation=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-2000.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         MaxCollisions=(Min=6.000000,Max=6.000000)
         ColorScale(0)=(Color=(B=100,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         MaxParticles=1
         StartLocationRange=(Z=(Min=50.000000,Max=50.000000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(Y=(Min=110.000000,Max=110.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-5000.000000,Max=5000.000000),Y=(Min=-5000.000000,Max=5000.000000),Z=(Min=-5000.000000,Max=5000.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_AP_HighMetal.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseDirectionAs=PTDU_Up
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-2000.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.240000
         FadeInEndTime=0.040000
         MaxParticles=50
         DetailMode=DM_SuperHigh
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=40.000000,Max=40.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=1.200000,Max=1.200000)
         StartVelocityRange=(X=(Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=-1000.000000,Max=1000.000000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_AP_HighMetal.SpriteEmitter7'

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
         ColorMultiplierRange=(Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=1
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.500000)
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.explosion_flash'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_AP_HighMetal.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         MaxCollisions=(Min=6.000000,Max=6.000000)
         ColorScale(0)=(Color=(B=100,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.030000
         FadeInEndTime=0.020000
         MaxParticles=1
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         LifetimeRange=(Min=1.500000,Max=1.500000)
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_AP_HighMetal.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Up
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-500.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Z=(Min=0.800000,Max=0.800000))
         FadeOutStartTime=0.240000
         FadeInEndTime=0.040000
         MaxParticles=120
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=20.000000,Max=30.000000),Z=(Min=20.000000,Max=30.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.spark_stretched_a_tiled'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-400.000000,Max=400.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Max=500.000000))
     End Object
     Emitters(4)=SpriteEmitter'UberSoldierVehicles.FX_AP_HighMetal.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-500.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.240000
         FadeInEndTime=0.040000
         MaxParticles=100
         DetailMode=DM_SuperHigh
         AddLocationFromOtherEmitter=4
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=15.000000,Max=20.000000),Z=(Min=15.000000,Max=20.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         LifetimeRange=(Min=8.000000,Max=8.000000)
         AddVelocityFromOtherEmitter=4
     End Object
     Emitters(5)=SpriteEmitter'UberSoldierVehicles.FX_AP_HighMetal.SpriteEmitter11'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=30
     LightSaturation=50
     LightBrightness=255.000000
     LightRadius=50.000000
     bDynamicLight=True
     AmbientGlow=192
}
