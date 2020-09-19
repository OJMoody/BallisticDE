//=============================================================================
// IM_JunkTwoByFour.
//
// Impact Manager for 2x4
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkTwoByFour extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'JunkWarDE.IE_MetalToConcrete'
     HitEffects(1)=Class'JunkWarDE.IE_MetalToConcrete'
     HitEffects(2)=Class'JunkWarDE.IE_MetalToDirt'
     HitEffects(3)=Class'JunkWarDE.IE_MetalToMetal'
     HitEffects(4)=Class'JunkWarDE.IE_MetalToWood'
     HitEffects(5)=Class'JunkWarDE.IE_MetalToGrass'
     HitEffects(6)=Class'JunkWarDE.IE_MetalToDirt'
     HitEffects(7)=Class'JunkWarDE.IE_AvgSnow'
     HitEffects(8)=Class'JunkWarDE.IE_AvgSnow'
     HitEffects(9)=Class'JunkWarDE.IE_WaterHit'
     HitEffects(10)=Class'JunkWarDE.IE_MetalToConcrete'
     HitDecals(0)=Class'JunkWarDE.AD_JunkBluntConcrete'
     HitDecals(1)=Class'JunkWarDE.AD_JunkBluntConcrete'
     HitDecals(2)=Class'JunkWarDE.AD_JunkBluntDirt'
     HitDecals(3)=Class'JunkWarDE.AD_JunkBluntMetal'
     HitDecals(4)=Class'JunkWarDE.AD_JunkBluntWood'
     HitDecals(5)=Class'JunkWarDE.AD_JunkBluntDirt'
     HitDecals(6)=Class'JunkWarDE.AD_JunkBluntDirt'
     HitDecals(7)=Class'JunkWarDE.AD_JunkBluntConcrete'
     HitDecals(8)=Class'JunkWarDE.AD_JunkBluntDirt'
     HitDecals(10)=Class'JunkWarDE.AD_JunkBluntConcrete'
     HitSounds(0)=SoundGroup'JunkWarSounds.Wood.Wood-Concrete'
     HitSounds(1)=SoundGroup'JunkWarSounds.Wood.Wood-Concrete'
     HitSounds(2)=SoundGroup'JunkWarSounds.Wood.Wood-Dirt'
     HitSounds(3)=SoundGroup'JunkWarSounds.Wood.Wood-Metal'
     HitSounds(4)=SoundGroup'JunkWarSounds.Wood.Wood-Wood'
     HitSounds(5)=SoundGroup'JunkWarSounds.Wood.Wood-Dirt'
     HitSounds(6)=SoundGroup'JunkWarSounds.Flesh.Flesh-WoodBlunt'
     HitSounds(7)=SoundGroup'JunkWarSounds.Wood.Wood-Dirt'
     HitSounds(8)=SoundGroup'JunkWarSounds.Wood.Wood-Dirt'
     HitSounds(9)=Sound'JunkWarSounds.Misc.Water-Big'
     HitSounds(10)=SoundGroup'JunkWarSounds.Wood.Wood-Concrete'
     HitSoundVolume=1.300000
     HitSoundPitch=0.900000
}
