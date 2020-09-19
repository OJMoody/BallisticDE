class FX_HitEffect_AH64Missile extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=60.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter54
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
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
         MaxParticles=300
         StartLocationOffset=(Z=100.000000)
         AddLocationFromOtherEmitter=7
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7466_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-187.500000,Max=187.500000),Y=(Min=-187.500000,Max=187.500000),Z=(Min=187.500000,Max=312.500000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_AH64Missile.SpriteEmitter54'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter55
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.907143,Color=(B=225,G=225,R=225,A=160))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000)
         FadeOutStartTime=0.154000
         FadeInEndTime=0.044000
         DetailMode=DM_High
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7634_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-800.000000,Max=800.000000),Y=(Min=-800.000000,Max=800.000000),Z=(Min=-800.000000,Max=800.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_AH64Missile.SpriteEmitter55'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter56
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=300.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.100000
         FadeInEndTime=0.080000
         MaxParticles=5
         StartLocationRange=(Z=(Min=1.250000,Max=1.250000))
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=50.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_6682_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=8
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_AH64Missile.SpriteEmitter56'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter57
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
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=1200.000000,Max=1200.000000),Y=(Min=1200.000000,Max=1200.000000),Z=(Min=1200.000000,Max=1200.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=0.800000,Max=0.800000)
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_AH64Missile.SpriteEmitter57'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter58
         UseDirectionAs=PTDU_Up
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.140000
         FadeInEndTime=0.040000
         MaxParticles=0
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.300000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-800.000000,Max=800.000000),Y=(Min=-800.000000,Max=800.000000),Z=(Min=-800.000000,Max=800.000000))
     End Object
     Emitters(4)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_AH64Missile.SpriteEmitter58'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter59
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
         MaxParticles=0
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
     Emitters(5)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_AH64Missile.SpriteEmitter59'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter60
         UseDirectionAs=PTDU_Forward
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.200000
         MaxParticles=20
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         Texture=Texture'1945.Effects.cb625dfe'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=6.000000,Max=6.000000)
     End Object
     Emitters(6)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_AH64Missile.SpriteEmitter60'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter61
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
         MaxParticles=20
         SpinCCWorCW=(X=1.000000)
         StartSpinRange=(X=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'1945.Effects.impflash'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-800.000000,Max=800.000000),Y=(Min=-800.000000,Max=800.000000),Z=(Max=1000.000000))
     End Object
     Emitters(7)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_AH64Missile.SpriteEmitter61'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter62
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=213,G=238,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=224,R=255))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=60
         StartLocationOffset=(Z=50.000000)
         AddLocationFromOtherEmitter=6
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=120.000000,Max=120.000000),Y=(Min=120.000000,Max=120.000000),Z=(Min=120.000000,Max=120.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.fire_a_anim'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         LifetimeRange=(Min=3.000000,Max=3.000000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(8)=SpriteEmitter'UberSoldierVehicles.FX_HitEffect_AH64Missile.SpriteEmitter62'

     LightType=LT_SubtlePulse
     LightEffect=LE_QuadraticNonIncidence
     LightHue=21
     LightSaturation=30
     LightBrightness=255.000000
     LightRadius=60.000000
     bDynamicLight=True
}
