//=============================================================================
// GRS9LaserOnFX.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRS9LaserOnFX extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.025000
         FadeInEndTime=0.006000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=10.000000)
         StartSizeRange=(X=(Min=40.000000,Max=60.000000),Y=(Min=40.000000,Max=60.000000),Z=(Min=40.000000,Max=60.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.050000,Max=0.100000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPTestPro.GRS9LaserOnFX.SpriteEmitter26'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter27
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.460000
         FadeOutStartTime=0.147000
         FadeInEndTime=0.045000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationOffset=(X=120.000000)
         StartSizeRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=110.000000,Max=130.000000),Z=(Min=110.000000,Max=130.000000))
         Texture=Texture'BallisticEffects.Particles.WaterSpray1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
         StartVelocityRange=(X=(Min=10.000000,Max=10.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPTestPro.GRS9LaserOnFX.SpriteEmitter27'

     bHidden=True
}
