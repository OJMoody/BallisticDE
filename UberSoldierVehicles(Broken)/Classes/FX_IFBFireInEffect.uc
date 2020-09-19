class FX_IFBFireInEffect extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=10.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
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
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'G_FX.Smokes.Kafire2'
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_IFBFireInEffect.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter16
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
         UseVelocityScale=True
         Acceleration=(X=-5000.000000,Z=3000.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=140,G=140,R=140,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=150,G=150,R=150))
         FadeOutStartTime=0.105000
         FadeInEndTime=0.060000
         MaxParticles=50
         AddLocationFromOtherEmitter=0
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-1.800000,Max=1.800000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'1945.Effects.fireball_animated1_sm'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Max=2000.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-500.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_IFBFireInEffect.SpriteEmitter16'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
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
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.105000
         FadeInEndTime=0.060000
         MaxParticles=5
         AddLocationFromOtherEmitter=0
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'1945.Effects.Artificial_Light_lgA_0'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_IFBFireInEffect.SpriteEmitter17'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
         UseDirectionAs=PTDU_Up
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=100))
         ColorScale(1)=(RelativeTime=0.514286,Color=(B=255,G=255,R=255,A=200))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.210000
         MaxParticles=50
         AddLocationFromOtherEmitter=0
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=80.000000,Max=80.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'1945.Effects.2bb8a332'
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=500.000000,Max=1500.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=-1000.000000,Max=1000.000000))
         VelocityLossRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_IFBFireInEffect.SpriteEmitter18'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=35
     LightSaturation=40
     LightBrightness=200.000000
     LightRadius=5.000000
     bDynamicLight=True
     AmbientGlow=255
}
