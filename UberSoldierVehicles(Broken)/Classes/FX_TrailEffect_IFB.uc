class FX_TrailEffect_IFB extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         UseVelocityScale=True
         Acceleration=(Z=20.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=100))
         ColorScale(1)=(RelativeTime=0.514286,Color=(B=255,G=255,R=255,A=200))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.600000
         FadeOutStartTime=0.800000
         FadeInEndTime=0.300000
         MaxParticles=500
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=45.000000),Y=(Min=40.000000,Max=45.000000),Z=(Min=40.000000,Max=45.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'G_FX.Smokes.smoke5Qb'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=3.000000,Max=3.000000)
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_TrailEffect_IFB.SpriteEmitter21'

     AutoDestroy=True
     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
}
