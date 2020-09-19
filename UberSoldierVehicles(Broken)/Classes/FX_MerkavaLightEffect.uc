class FX_MerkavaLightEffect extends DKEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'G_FX.Flares.flare3'
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_MerkavaLightEffect.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.040000
         FadeInEndTime=0.040000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         InitialParticlesPerSecond=1.000000
         Texture=Texture'G_FX.Plasmafx.P_Membrane1c'
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_MerkavaLightEffect.SpriteEmitter4'

     bTrailerSameRotation=True
     Physics=PHYS_Trailer
}
