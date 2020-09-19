class FX_HelecopterDestroy extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=100.000000
     FlashTimeIn=0.150000
     FlashTimeOut=1.500000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
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
         FadeOutStartTime=0.040000
         FadeInEndTime=0.040000
         MaxParticles=50
         DetailMode=DM_SuperHigh
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7634_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         SubdivisionEnd=32
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=-3000.000000,Max=3000.000000))
         VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_HelecopterDestroy.SpriteEmitter1'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'ONSBP_DestroyedVehicles.Cicada.Cicada_FanBlade'
         UseParticleColor=True
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1500.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         SpawnFromOtherEmitter=5
         SpawnAmount=20
         SpawnedVelocityScaleRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         ColorScale(0)=(Color=(B=192,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.850000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128))
         MaxParticles=50
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000))
         SphereRadiusRange=(Min=8.000000,Max=8.000000)
         SpinsPerSecondRange=(Z=(Min=1.000000,Max=1.000000))
         StartSpinRange=(Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         RotationDampingFactorRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=0.500000),Y=(Min=0.500000),Z=(Min=0.500000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=10.000000,Max=10.000000)
         InitialDelayRange=(Min=0.150000,Max=0.150000)
         StartVelocityRange=(X=(Min=-1500.000000,Max=1500.000000),Y=(Min=-1500.000000,Max=1500.000000),Z=(Min=100.000000,Max=2000.000000))
         StartVelocityRadialRange=(Min=300.000000,Max=1500.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=1.000000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
     End Object
     Emitters(1)=MeshEmitter'UberSoldierVehicles.FX_HelecopterDestroy.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
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
         MaxParticles=200
         StartLocationRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.spark_stretched_a'
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=-1000.000000,Max=1000.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_HelecopterDestroy.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
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
         Opacity=0.500000
         FadeOutStartTime=0.040000
         FadeInEndTime=0.040000
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=8.000000)
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=80.000000
         Texture=Texture'1945.Effects.LensFlare03'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_HelecopterDestroy.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
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
     Emitters(4)=SpriteEmitter'UberSoldierVehicles.FX_HelecopterDestroy.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
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
     Emitters(5)=SpriteEmitter'UberSoldierVehicles.FX_HelecopterDestroy.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
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
         MaxParticles=50
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'1945.Effects.2bb8a3322'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=-500.000000,Max=1500.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(6)=SpriteEmitter'UberSoldierVehicles.FX_HelecopterDestroy.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
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
         MaxParticles=1000
         AddLocationFromOtherEmitter=6
         SpinsPerSecondRange=(X=(Min=0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_6682_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=8
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(7)=SpriteEmitter'UberSoldierVehicles.FX_HelecopterDestroy.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
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
         UseRandomSubdivision=True
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         Opacity=0.500000
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=1000
         AddLocationFromOtherEmitter=6
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=3.000000)
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.smk_bumpy_uva'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(8)=SpriteEmitter'UberSoldierVehicles.FX_HelecopterDestroy.SpriteEmitter11'

     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=35
     LightSaturation=40
     LightBrightness=200.000000
     LightRadius=80.000000
     bDynamicLight=True
}
