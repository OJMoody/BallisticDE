class FX_SmallRockets extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=20.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Max=800.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-500.000000,Max=500.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_SmallRockets.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         StartLocationRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'1945.Effects.sparks_multy_tiled'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_SmallRockets.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
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
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.030000
         FadeInEndTime=0.020000
         MaxParticles=1
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=3.000000)
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_SmallRockets.SpriteEmitter5'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=35
     LightSaturation=40
     LightBrightness=200.000000
     LightRadius=10.000000
     bDynamicLight=True
     AmbientGlow=192
}
