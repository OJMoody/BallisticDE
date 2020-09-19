//=============================================================================
// IM_JunkShankHitSec.
//
// Impact manager for Shank
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkShankHitSec extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'JunkWarDE.IE_MetalToConcrete'
     HitEffects(1)=Class'JunkWarDE.IE_MetalToConcrete'
     HitEffects(2)=Class'JunkWarDE.IE_MetalToDirt'
     HitEffects(3)=Class'JunkWarDE.IE_MetalToMetal'
     HitEffects(4)=Class'JunkWarDE.IE_MetalToWood'
     HitEffects(5)=Class'JunkWarDE.IE_MetalToGrass'
     HitEffects(6)=Class'JunkWarDE.IE_SmallPlayer'
     HitEffects(7)=Class'JunkWarDE.IE_AvgSnow'
     HitEffects(8)=Class'JunkWarDE.IE_AvgSnow'
     HitEffects(9)=Class'JunkWarDE.IE_WaterHit'
     HitEffects(10)=Class'JunkWarDE.IE_MetalToConcrete'
     HitDecals(0)=Class'JunkWarDE.AD_JunkSharpConcrete'
     HitDecals(1)=Class'JunkWarDE.AD_JunkSharpConcrete'
     HitDecals(2)=Class'JunkWarDE.AD_JunkSharpDirt'
     HitDecals(3)=Class'JunkWarDE.AD_JunkSharpMetal'
     HitDecals(4)=Class'JunkWarDE.AD_JunkSharpWood'
     HitDecals(5)=Class'JunkWarDE.AD_JunkSharpDirt'
     HitDecals(6)=Class'JunkWarDE.AD_JunkSharpDirt'
     HitDecals(7)=Class'JunkWarDE.AD_JunkSharpConcrete'
     HitDecals(8)=Class'JunkWarDE.AD_JunkSharpDirt'
     HitDecals(9)=Class'JunkWarDE.AD_JunkSharpDirt'
     HitDecals(10)=Class'JunkWarDE.AD_JunkSharpConcrete'
     DecalScale=1.750000
     HitSounds(0)=SoundGroup'JunkWarSounds.Pipe.Pipe-Concrete'
     HitSounds(1)=SoundGroup'JunkWarSounds.Pipe.Pipe-Concrete'
     HitSounds(2)=SoundGroup'JunkWarSounds.Pipe.Pipe-Dirt'
     HitSounds(3)=SoundGroup'JunkWarSounds.Pipe.Pipe-Metal'
     HitSounds(4)=SoundGroup'JunkWarSounds.Pipe.Pipe-Wood'
     HitSounds(5)=SoundGroup'JunkWarSounds.Pipe.Pipe-Dirt'
     HitSounds(6)=Sound'JunkWarSounds.Flesh.Light-SharpTwist'
     HitSounds(7)=SoundGroup'JunkWarSounds.Pipe.Pipe-Dirt'
     HitSounds(8)=SoundGroup'JunkWarSounds.Pipe.Pipe-Dirt'
     HitSounds(9)=Sound'JunkWarSounds.Misc.Water-Small'
     HitSounds(10)=SoundGroup'JunkWarSounds.Pipe.Pipe-Concrete'
     HitSoundVolume=0.900000
     HitSoundRadius=48.000000
}
