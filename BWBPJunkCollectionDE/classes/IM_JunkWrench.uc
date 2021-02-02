//=============================================================================
// IM_JunkWrench.
//
// Impact Manager for Wrench
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkWrench extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBPJunkCollectionDE.IE_MetalToConcrete'
     HitEffects(1)=Class'BWBPJunkCollectionDE.IE_MetalToConcrete'
     HitEffects(2)=Class'BWBPJunkCollectionDE.IE_MetalToDirt'
     HitEffects(3)=Class'BWBPJunkCollectionDE.IE_MetalToMetal'
     HitEffects(4)=Class'BWBPJunkCollectionDE.IE_MetalToWood'
     HitEffects(5)=Class'BWBPJunkCollectionDE.IE_MetalToGrass'
     HitEffects(6)=Class'BWBPJunkCollectionDE.IE_AvgPlayer'
     HitEffects(7)=Class'BWBPJunkCollectionDE.IE_AvgSnow'
     HitEffects(8)=Class'BWBPJunkCollectionDE.IE_AvgSnow'
     HitEffects(9)=Class'BWBPJunkCollectionDE.IE_WaterHit'
     HitEffects(10)=Class'BWBPJunkCollectionDE.IE_MetalToConcrete'
     HitDecals(0)=Class'BWBPJunkCollectionDE.AD_JunkBluntConcrete'
     HitDecals(1)=Class'BWBPJunkCollectionDE.AD_JunkBluntConcrete'
     HitDecals(2)=Class'BWBPJunkCollectionDE.AD_JunkBluntDirt'
     HitDecals(3)=Class'BWBPJunkCollectionDE.AD_JunkBluntMetal'
     HitDecals(4)=Class'BWBPJunkCollectionDE.AD_JunkBluntWood'
     HitDecals(5)=Class'BWBPJunkCollectionDE.AD_JunkBluntDirt'
     HitDecals(6)=Class'BWBPJunkCollectionDE.AD_JunkBluntDirt'
     HitDecals(7)=Class'BWBPJunkCollectionDE.AD_JunkBluntConcrete'
     HitDecals(8)=Class'BWBPJunkCollectionDE.AD_JunkBluntDirt'
     HitDecals(10)=Class'BWBPJunkCollectionDE.AD_JunkBluntConcrete'
     DecalScale=0.750000
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Dirt'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.Flesh.Flesh-AvgBlunt'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Avg'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Concrete'
     HitSoundVolume=1.300000
     HitSoundRadius=48.000000
}
