//=============================================================================
// IM_JunkEmptyCapacitor.
//
// Impact Manager for Empty Capacitor
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkEmptyCapacitor extends BCImpactManager;

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
     HitDecals(0)=Class'JunkWarDE.AD_JunkBasicConcrete'
     HitDecals(1)=Class'JunkWarDE.AD_JunkBasicConcrete'
     HitDecals(2)=Class'JunkWarDE.AD_JunkBasicDirt'
     HitDecals(3)=Class'JunkWarDE.AD_JunkBasicMetal'
     HitDecals(4)=Class'JunkWarDE.AD_JunkBasicWood'
     HitDecals(5)=Class'JunkWarDE.AD_JunkBasicDirt'
     HitDecals(6)=Class'JunkWarDE.AD_JunkBasicDirt'
     HitDecals(7)=Class'JunkWarDE.AD_JunkBasicConcrete'
     HitDecals(8)=Class'JunkWarDE.AD_JunkBasicDirt'
     HitDecals(9)=Class'JunkWarDE.AD_JunkBasicDirt'
     HitDecals(10)=Class'JunkWarDE.AD_JunkBasicConcrete'
     DecalScale=0.800000
     HitSounds(0)=SoundGroup'JunkWarSounds.Hammer.Hammer-Concrete'
     HitSounds(1)=SoundGroup'JunkWarSounds.Hammer.Hammer-Concrete'
     HitSounds(2)=SoundGroup'JunkWarSounds.Hammer.Hammer-Dirt'
     HitSounds(3)=SoundGroup'JunkWarSounds.Hammer.Hammer-Metal'
     HitSounds(4)=SoundGroup'JunkWarSounds.Hammer.Hammer-Wood'
     HitSounds(5)=SoundGroup'JunkWarSounds.Hammer.Hammer-Dirt'
     HitSounds(6)=SoundGroup'JunkWarSounds.Flesh.Flesh-AvgBlunt'
     HitSounds(7)=SoundGroup'JunkWarSounds.Hammer.Hammer-Dirt'
     HitSounds(8)=SoundGroup'JunkWarSounds.Hammer.Hammer-Dirt'
     HitSounds(9)=Sound'JunkWarSounds.Misc.Water-Small'
     HitSounds(10)=SoundGroup'JunkWarSounds.Hammer.Hammer-Concrete'
     HitSoundVolume=0.800000
     HitSoundRadius=48.000000
     HitSoundPitch=1.300000
}
