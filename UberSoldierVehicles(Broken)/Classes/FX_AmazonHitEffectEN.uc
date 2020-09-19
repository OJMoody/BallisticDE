class FX_AmazonHitEffectEN extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=60.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseDirectionAs=PTDU_Up
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         RespawnDeadParticles=False
         DampRotation=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         MaxCollisions=(Min=6.000000,Max=6.000000)
         ColorScale(0)=(Color=(B=100,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.800000,Max=0.800000))
         MaxParticles=200
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.LensFlare06'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-1500.000000,Max=1500.000000),Y=(Min=-1500.000000,Max=1500.000000),Z=(Min=-1500.000000,Max=1500.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_AmazonHitEffectEN.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=100
         DetailMode=DM_High
         AddLocationFromOtherEmitter=0
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=20.000000)
         StartSizeRange=(X=(Min=1.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         ScaleSizeByVelocityMultiplier=(X=0.150000,Y=0.150000,Z=0.150000)
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'1945.Effects.electric_radial1'
         LifetimeRange=(Min=1.500000,Max=1.500000)
         InitialDelayRange=(Min=0.150000,Max=0.150000)
         VelocityLossRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_AmazonHitEffectEN.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         StartLocationRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=400.000000,Max=400.000000),Z=(Min=400.000000,Max=400.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'1945.Effects.flash_animated_a'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=-1000.000000,Max=1000.000000))
         VelocityLossRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_AmazonHitEffectEN.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
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
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.800000,Max=0.800000))
         Opacity=0.380000
         FadeOutStartTime=0.030000
         FadeInEndTime=0.020000
         MaxParticles=5
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1000.000000))
         InitialParticlesPerSecond=10.000000
         Texture=Texture'1945.Effects.LensFlare06'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_AmazonHitEffectEN.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.010000,Max=0.010000),Y=(Min=0.010000,Max=0.010000),Z=(Min=0.010000,Max=0.010000))
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         Opacity=0.500000
         FadeOutStartTime=0.045000
         FadeInEndTime=0.030000
         MaxParticles=5
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=600.000000,Max=600.000000),Y=(Min=600.000000,Max=600.000000),Z=(Min=600.000000,Max=600.000000))
         InitialParticlesPerSecond=10.000000
         Texture=Texture'1945.Effects.electric_radial1'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(4)=SpriteEmitter'UberSoldierVehicles.FX_AmazonHitEffectEN.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
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
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=500
         AddLocationFromOtherEmitter=6
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'1945.Effects.electric_radial1'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(5)=SpriteEmitter'UberSoldierVehicles.FX_AmazonHitEffectEN.SpriteEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseDirectionAs=PTDU_Up
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.800000,Max=0.800000))
         FadeOutStartTime=0.240000
         FadeInEndTime=0.040000
         MaxParticles=30
         DetailMode=DM_SuperHigh
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.LensFlare06'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-5000.000000,Max=5000.000000),Y=(Min=-5000.000000,Max=5000.000000),Z=(Min=-5000.000000,Max=5000.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(6)=SpriteEmitter'UberSoldierVehicles.FX_AmazonHitEffectEN.SpriteEmitter15'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=160
     LightSaturation=150
     LightBrightness=255.000000
     LightRadius=60.000000
     bDynamicLight=True
     AmbientGlow=192
}
