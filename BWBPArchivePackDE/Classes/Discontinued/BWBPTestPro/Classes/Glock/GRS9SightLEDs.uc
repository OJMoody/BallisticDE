//=============================================================================
// GRS9SightLEDs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRS9SightLEDs extends BallisticEmitter;

function InvertZ()
{
	local int i;
	for (i=0;i<Emitters.length;i++)
	{
		Emitters[i].StartLocationOffset.Z *= -1;
//		Emitters[i].StartVelocityRange.Z.Max *= -1;
//		Emitters[i].StartVelocityRange.Z.Min *= -1;
	}
}
function InvertY()
{
	local int i;
	for (i=0;i<Emitters.length;i++)
	{
		Emitters[i].StartLocationOffset.Y *= -1;
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter28
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=83.699997,Z=11.300000)
         StartSizeRange=(X=(Min=1.300000,Max=1.300000),Y=(Min=1.300000,Max=1.300000),Z=(Min=1.300000,Max=1.300000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPTestPro.GRS9SightLEDs.SpriteEmitter28'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter29
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-37.700001,Y=-3.300000,Z=11.300000)
         StartSizeRange=(X=(Min=1.300000,Max=1.300000),Y=(Min=1.300000,Max=1.300000),Z=(Min=1.300000,Max=1.300000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPTestPro.GRS9SightLEDs.SpriteEmitter29'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter30
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-37.700001,Y=3.300000,Z=11.300000)
         StartSizeRange=(X=(Min=1.300000,Max=1.300000),Y=(Min=1.300000,Max=1.300000),Z=(Min=1.300000,Max=1.300000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPTestPro.GRS9SightLEDs.SpriteEmitter30'

     bHidden=True
     bHardAttach=True
}
