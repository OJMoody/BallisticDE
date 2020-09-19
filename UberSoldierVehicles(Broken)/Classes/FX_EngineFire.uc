class FX_EngineFire extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=50.000000
     FlashTimeIn=500.000000
     FlashTimeOut=500.000000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     SpawnSound=SoundGroup'DKoppIISound.TankDestroy.ExplAmmoClose'
     SpawnSoundVolume=3.000000
     SpawnSoundRadius=100.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(X=-20.000000)
         ColorScale(0)=(Color=(B=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=193,G=224,R=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=80
         StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000))
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_6682_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=8
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=20.000000,Max=50.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_EngineFire.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.640000
         FadeInEndTime=0.400000
         MaxParticles=50
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=1.000000,Max=1.000000))
         InitialParticlesPerSecond=20.000000
         Texture=Texture'1945.Effects.LensFlare04'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=10.000000,Max=100.000000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_EngineFire.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=80.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.150000
         FadeInEndTime=0.150000
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=15.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7634_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
     End Object
     Emitters(2)=SpriteEmitter'UberSoldierVehicles.FX_EngineFire.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=80.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.150000
         FadeInEndTime=0.150000
         MaxParticles=5
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=8.000000
         Texture=Texture'1945.Effects.LensFlare04'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
     End Object
     Emitters(3)=SpriteEmitter'UberSoldierVehicles.FX_EngineFire.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.150000
         FadeInEndTime=0.150000
         MaxParticles=100
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=55.000000,Max=55.000000),Z=(Min=55.000000,Max=55.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'1945.Effects.LensFlare05'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=50.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(4)=SpriteEmitter'UberSoldierVehicles.FX_EngineFire.SpriteEmitter4'

     LightType=LT_SubtlePulse
     LightEffect=LE_QuadraticNonIncidence
     LightHue=20
     LightBrightness=200.000000
     LightRadius=10.000000
     bDynamicLight=True
     Physics=PHYS_Trailer
     bHardAttach=True
}
