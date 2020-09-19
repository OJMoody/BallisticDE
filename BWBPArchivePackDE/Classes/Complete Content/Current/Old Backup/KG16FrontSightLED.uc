//=============================================================================
// Fifty9SightLEDs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class KG16FrontSightLED extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(R=255,A=200))
         ColorScale(1)=(RelativeTime=1.000000,Color=(R=200,A=255))
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-0.200000)
         StartSizeRange=(X=(Min=0.250000,Max=0.250000),Y=(Min=0.250000,Max=0.250000),Z=(Min=0.250000,Max=0.250000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPArchivePackDE.KG16FrontSightLED.SpriteEmitter'

     bHidden=True
     bNoDelete=False
}
