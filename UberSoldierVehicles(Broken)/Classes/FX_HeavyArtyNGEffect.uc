class FX_HeavyArtyNGEffect extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=60.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(1)=(RelativeTime=0.171429,Color=(B=56,G=56,R=56,A=255))
         ColorScale(2)=(RelativeTime=0.639286,Color=(B=77,G=77,R=77,A=255))
         ColorScale(3)=(RelativeTime=0.875000,Color=(B=53,G=53,R=53,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(6)=(RelativeTime=1.000000)
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.500000
         FadeOutStartTime=0.570000
         FadeInEndTime=0.240000
         MaxParticles=1500
         StartLocationOffset=(Z=100.000000)
         AddLocationFromOtherEmitter=7
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.smk_bumpy_uva'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-187.500000,Max=187.500000),Y=(Min=-187.500000,Max=187.500000),Z=(Min=187.500000,Max=312.500000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_HeavyArtyNGEffect.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.907143,Color=(B=225,G=225,R=225,A=160))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000)
         FadeOutStartTime=0.154000
         FadeInEndTime=0.044000
         MaxParticles=50
         DetailMode=DM_High
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.650000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=20.000000,Max=200.000000),Y=(Min=20.000000,Max=200.000000),Z=(Min=20.000000,Max=200.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.b801295e'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.200000,Max=2.200000)
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-500.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_HeavyArtyNGEffect.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=300.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.100000
         FadeInEndTime=0.080000
         MaxParticles=30
         StartLocationRange=(Z=(Min=1.250000,Max=1.250000))
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=50.000000
         Texture=Texture'1945.Effects.b801295e'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_HeavyArtyNGEffect.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.700000,Max=0.700000),Z=(Min=0.000000,Max=0.000000))
         MaxParticles=5
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1000.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'1945.Effects.Artificial_Light_lgA_0'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_HeavyArtyNGEffect.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.900000
         FadeInEndTime=0.300000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.300000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=700.000000,Max=700.000000),Y=(Min=700.000000,Max=700.000000),Z=(Min=700.000000,Max=700.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'1945.Effects.impflash'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=10.000000,Max=10.000000)
     End Object
     Emitters(4)=SpriteEmitter'UberSoldierVehicles.FX_HeavyArtyNGEffect.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(X=10.000000,Y=10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.300000
         FadeOutStartTime=1.690000
         FadeInEndTime=1.040000
         MaxParticles=100
         AddLocationFromOtherEmitter=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=15.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.smk_bumpy_uva'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=12.000000,Max=13.000000)
         InitialDelayRange=(Min=0.500000,Max=1.000000)
         StartVelocityRange=(Z=(Min=200.000000,Max=200.000000))
     End Object
     Emitters(5)=SpriteEmitter'UberSoldierVehicles.FX_HeavyArtyNGEffect.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Forward
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.200000
         MaxParticles=100
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=80.000000,Max=80.000000))
         Texture=Texture'1945.Effects.cb625dfe'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=6.000000,Max=6.000000)
     End Object
     Emitters(6)=SpriteEmitter'UberSoldierVehicles.FX_HeavyArtyNGEffect.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseDirectionAs=PTDU_Up
         UseCollision=True
         UseMaxCollisions=True
         UseSpawnedVelocityScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-2000.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         SpawnFromOtherEmitter=6
         SpawnAmount=1
         SpawnedVelocityScaleRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.100000
         MaxParticles=100
         SpinCCWorCW=(X=1.000000)
         StartSpinRange=(X=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.impflash'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-2000.000000,Max=2000.000000))
     End Object
     Emitters(7)=SpriteEmitter'UberSoldierVehicles.FX_HeavyArtyNGEffect.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=500.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=1600
         AddLocationFromOtherEmitter=6
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=150.000000,Max=180.000000),Y=(Min=150.000000,Max=180.000000),Z=(Min=150.000000,Max=180.000000))
         InitialParticlesPerSecond=300.000000
         Texture=Texture'1945.Effects.Explosion_Flame'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(8)=SpriteEmitter'UberSoldierVehicles.FX_HeavyArtyNGEffect.SpriteEmitter12'

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
         Acceleration=(Z=200.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=1600
         StartLocationRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000))
         AddLocationFromOtherEmitter=6
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=300.000000
         Texture=Texture'1945.Effects.impflash'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(9)=SpriteEmitter'UberSoldierVehicles.FX_HeavyArtyNGEffect.SpriteEmitter13'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=35
     LightSaturation=40
     LightBrightness=200.000000
     LightRadius=50.000000
     bDynamicLight=True
     AmbientGlow=192
}
