class FX_DecoTireFire extends DKEmitter;

var   actor				ActorFire;

simulated function PostBeginPlay()
{
		ActorFire=Spawn(class'Snd_Fire',self,,location);
}

simulated function Destroyed()
{
     ActorFire.Destroy();
	super.Destroyed();
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(X=-20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         Opacity=0.800000
         FadeOutStartTime=0.640000
         FadeInEndTime=0.400000
         MaxParticles=100
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.smk_bumpy_uva'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=5.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=100.000000,Max=100.000000))
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_DecoTireFire.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         BlendBetweenSubdivisions=True
         Acceleration=(Z=67.500000)
         ColorScale(0)=(Color=(B=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.144000
         FadeInEndTime=0.064000
         MaxParticles=50
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=0.300000)
         StartSizeRange=(X=(Min=18.000000,Max=18.000000),Y=(Min=18.000000,Max=18.000000),Z=(Min=18.000000,Max=18.000000))
         InitialParticlesPerSecond=22.500000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_6682_0'
         TextureUSubdivisions=4
         TextureVSubdivisions=8
         LifetimeRange=(Min=1.600000,Max=1.600000)
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_DecoTireFire.SpriteEmitter1'

     Physics=PHYS_Trailer
     bHardAttach=True
}
