class FX_DecoTankDamFireL extends DKEmitter;

defaultproperties
{
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=50.000000
     FlashTimeIn=500.000000
     FlashTimeOut=500.000000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(X=-20.000000,Z=50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         Opacity=0.500000
         FadeOutStartTime=0.640000
         FadeInEndTime=0.400000
         MaxParticles=100
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.smk_bumpy_uva'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-50.000000,Max=-30.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_DecoTankDamFireL.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=193,G=224,R=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.045000
         FadeInEndTime=0.045000
         MaxParticles=50
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'1945.Effects.b801295e'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-50.000000,Max=-30.000000))
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_DecoTankDamFireL.SpriteEmitter12'

     LightType=LT_SubtlePulse
     LightEffect=LE_QuadraticNonIncidence
     LightHue=35
     LightSaturation=40
     LightBrightness=200.000000
     LightRadius=5.000000
     bDynamicLight=True
     bHardAttach=True
     SoundVolume=255
     SoundRadius=500.000000
}
