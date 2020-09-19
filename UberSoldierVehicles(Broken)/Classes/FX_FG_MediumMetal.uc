class FX_FG_MediumMetal extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=60.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-3000.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         MaxCollisions=(Min=6.000000,Max=6.000000)
         ColorScale(0)=(Color=(B=100,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         Opacity=0.000000
         MaxParticles=50
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7730_0'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=20.000000,Max=20.000000)
         StartVelocityRange=(X=(Min=500.000000,Max=5000.000000),Y=(Min=-2500.000000,Max=2500.000000),Z=(Min=-2500.000000,Max=2500.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_FG_MediumMetal.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.690000
         MaxParticles=0
         DetailMode=DM_High
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=35.000000,Max=35.000000),Z=(Min=35.000000,Max=35.000000))
         ScaleSizeByVelocityMultiplier=(X=0.150000,Y=0.150000,Z=0.150000)
         InitialParticlesPerSecond=2000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7802_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=1
         LifetimeRange=(Min=3.000000,Max=3.000000)
         InitialDelayRange=(Min=0.150000,Max=0.150000)
         VelocityLossRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_FG_MediumMetal.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter37
         UseCollision=True
         UseMaxCollisions=True
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
         FadeOutStartTime=0.300000
         FadeInEndTime=0.300000
         MaxParticles=3
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=1200.000000,Max=1200.000000),Y=(Min=1200.000000,Max=1200.000000),Z=(Min=1200.000000,Max=1200.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_FG_MediumMetal.SpriteEmitter37'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter65
         UseDirectionAs=PTDU_Normal
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.010000,Max=0.010000),Y=(Min=0.010000,Max=0.010000),Z=(Min=0.010000,Max=0.010000))
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         FadeOutStartTime=0.117000
         FadeInEndTime=0.117000
         MaxParticles=3
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1000.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=0.800000,Max=0.800000)
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_FG_MediumMetal.SpriteEmitter65'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter66
         UseDirectionAs=PTDU_Up
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-1000.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=100
         AddLocationFromOtherEmitter=7
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=5.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=500.000000,Max=2000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=-1000.000000,Max=1000.000000))
     End Object
     Emitters(4)=SpriteEmitter'UberSoldierVehicles.FX_FG_MediumMetal.SpriteEmitter66'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter67
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         MaxParticles=30
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.2bb8a332'
         LifetimeRange=(Min=0.200000,Max=0.200000)
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         AddVelocityFromOtherEmitter=0
     End Object
     Emitters(5)=SpriteEmitter'UberSoldierVehicles.FX_FG_MediumMetal.SpriteEmitter67'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter68
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(X=-20.000000)
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=1000
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=200.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7466_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         LifetimeRange=(Min=2.500000,Max=2.500000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=50.000000,Max=50.000000))
     End Object
     Emitters(6)=SpriteEmitter'UberSoldierVehicles.FX_FG_MediumMetal.SpriteEmitter68'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter69
         UseDirectionAs=PTDU_Normal
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.010000,Max=0.010000),Y=(Min=0.010000,Max=0.010000),Z=(Min=0.010000,Max=0.010000))
         ColorScale(0)=(Color=(B=100,G=100,R=100))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.500000
         FadeOutStartTime=0.117000
         FadeInEndTime=0.117000
         MaxParticles=0
         StartLocationOffset=(X=20.000000)
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.ring_08'
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(7)=SpriteEmitter'UberSoldierVehicles.FX_FG_MediumMetal.SpriteEmitter69'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter70
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-2000.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         MaxCollisions=(Min=6.000000,Max=6.000000)
         ColorScale(0)=(Color=(B=100,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         MaxParticles=30
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.impflash'
         LifetimeRange=(Min=30.000000,Max=30.000000)
         StartVelocityRange=(X=(Min=800.000000,Max=1500.000000),Y=(Min=-1500.000000,Max=1500.000000),Z=(Min=-1500.000000,Max=1500.000000))
     End Object
     Emitters(8)=SpriteEmitter'UberSoldierVehicles.FX_FG_MediumMetal.SpriteEmitter70'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter71
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=0
         StartLocationOffset=(Z=20.000000)
         AddLocationFromOtherEmitter=0
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=80.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=120.000000
         Texture=Texture'1945.Effects.1545666438afg'
         TextureUSubdivisions=6
         TextureVSubdivisions=6
         LifetimeRange=(Min=2.800000,Max=2.800000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=2.000000,Max=5.000000))
     End Object
     Emitters(9)=SpriteEmitter'UberSoldierVehicles.FX_FG_MediumMetal.SpriteEmitter71'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter72
         UseDirectionAs=PTDU_Up
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=500
         AddLocationFromOtherEmitter=11
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=2.500000,Max=2.500000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(10)=SpriteEmitter'UberSoldierVehicles.FX_FG_MediumMetal.SpriteEmitter72'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter73
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1800.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.260000
         MaxParticles=20
         DetailMode=DM_SuperHigh
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=1000.000000,Max=4000.000000),Y=(Min=-2000.000000,Max=2000.000000),Z=(Min=-2000.000000,Max=2000.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(11)=SpriteEmitter'UberSoldierVehicles.FX_FG_MediumMetal.SpriteEmitter73'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=35
     LightSaturation=40
     LightBrightness=200.000000
     LightRadius=50.000000
     bDynamicLight=True
}
