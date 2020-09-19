class FX_DecoTurretFire_Small extends DKEmitter;

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
     bFlash=True
     FlashBrightness=512.000000
     FlashRadius=50.000000
     FlashTimeIn=500.000000
     FlashTimeOut=500.000000
     FlashCurveIn=0.300000
     FlashCurveOut=2.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(X=-20.000000)
         ExtentMultiplier=(X=0.000000,Y=0.000000,Z=0.000000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         Opacity=0.800000
         FadeOutStartTime=0.240000
         FadeInEndTime=0.120000
         MaxParticles=450
         StartLocationOffset=(Z=40.000000)
         StartLocationRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000))
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=10.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.Tex_7466_0'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         LifetimeRange=(Min=8.000000,Max=8.000000)
         InitialDelayRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(Z=(Min=100.000000,Max=100.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
     End Object
     Emitters(0)=SpriteEmitter'UberSoldierVehicles.FX_DecoTurretFire_Small.SpriteEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
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
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.240000
         FadeInEndTime=0.120000
         MaxParticles=450
         StartLocationOffset=(Z=40.000000)
         StartLocationRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000))
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=30.000000,Max=80.000000),Y=(Min=30.000000,Max=80.000000),Z=(Min=30.000000,Max=80.000000))
         InitialParticlesPerSecond=10.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'1945.Effects.fire_a_anim'
         TextureUSubdivisions=8
         TextureVSubdivisions=8
         LifetimeRange=(Min=3.000000,Max=3.000000)
         InitialDelayRange=(Min=3.000000,Max=3.000000)
         StartVelocityRadialRange=(Min=-100.000000,Max=-100.000000)
     End Object
     Emitters(1)=SpriteEmitter'UberSoldierVehicles.FX_DecoTurretFire_Small.SpriteEmitter15'

     LightType=LT_SubtlePulse
     LightEffect=LE_QuadraticNonIncidence
     LightHue=20
     LightBrightness=200.000000
     LightRadius=5.000000
     bDynamicLight=True
     Physics=PHYS_Trailer
     bHardAttach=True
}
