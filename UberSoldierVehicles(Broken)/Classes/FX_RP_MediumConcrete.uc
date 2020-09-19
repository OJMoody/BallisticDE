class FX_RP_MediumConcrete extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=30.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     EhoExpSound=SoundGroup'DKoppIISound.Hit.EhoExpA'
     EhoExpSoundVolume=0.500000
     EhoExpSoundRadius=100000.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
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
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         MaxParticles=30
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7730_0'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=20.000000,Max=20.000000)
         StartVelocityRange=(X=(Min=500.000000,Max=3000.000000),Y=(Min=-1500.000000,Max=1500.000000),Z=(Min=-1500.000000,Max=1500.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_RP_MediumConcrete.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.090000
         MaxParticles=30
         DetailMode=DM_High
         AddLocationFromOtherEmitter=0
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         ScaleSizeByVelocityMultiplier=(X=0.150000,Y=0.150000,Z=0.150000)
         InitialParticlesPerSecond=2000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7802_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=1
         LifetimeRange=(Min=1.500000,Max=1.500000)
         InitialDelayRange=(Min=0.150000,Max=0.150000)
         VelocityLossRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_RP_MediumConcrete.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
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
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         Opacity=0.600000
         FadeOutStartTime=0.465000
         MaxParticles=5
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.LensFlare04'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_RP_MediumConcrete.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Normal
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.010000,Max=0.010000),Y=(Min=0.010000,Max=0.010000),Z=(Min=0.010000,Max=0.010000))
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         Opacity=0.600000
         FadeOutStartTime=0.680000
         MaxParticles=5
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.LensFlare04'
         LifetimeRange=(Min=0.800000,Max=0.800000)
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_RP_MediumConcrete.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseCollision=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=5.000000
         FadeInEndTime=0.800000
         MaxParticles=50
         AddLocationFromOtherEmitter=0
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'1945.Effects.LensFlare02'
         LifetimeRange=(Min=5.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(4)=SpriteEmitter'UberSoldierVehicles.FX_RP_MediumConcrete.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         FadeOutStartTime=0.092000
         MaxParticles=50
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.LensFlare04'
         LifetimeRange=(Min=0.100000,Max=0.100000)
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         AddVelocityFromOtherEmitter=0
     End Object
     Emitters(5)=SpriteEmitter'UberSoldierVehicles.FX_RP_MediumConcrete.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
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
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=500
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7466_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         LifetimeRange=(Min=2.500000,Max=2.500000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=50.000000,Max=50.000000))
     End Object
     Emitters(6)=SpriteEmitter'UberSoldierVehicles.FX_RP_MediumConcrete.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
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
         MaxParticles=1
         StartLocationOffset=(Z=20.000000)
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.ring_08'
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(7)=SpriteEmitter'UberSoldierVehicles.FX_RP_MediumConcrete.SpriteEmitter7'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=50
     LightBrightness=255.000000
     LightRadius=30.000000
     bDynamicLight=True
}
