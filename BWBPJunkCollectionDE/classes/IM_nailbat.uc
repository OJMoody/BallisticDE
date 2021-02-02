//=============================================================================
// IM_nailbat.
//
// Impact Manager for Homerun Bat
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_nailbat extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBPJunkCollectionDE.IE_MetalToConcrete'
     HitEffects(1)=Class'BWBPJunkCollectionDE.IE_MetalToConcrete'
     HitEffects(2)=Class'BWBPJunkCollectionDE.IE_MetalToDirt'
     HitEffects(3)=Class'BWBPJunkCollectionDE.IE_MetalToMetal'
     HitEffects(4)=Class'BWBPJunkCollectionDE.IE_MetalToWood'
     HitEffects(5)=Class'BWBPJunkCollectionDE.IE_MetalToGrass'
     HitEffects(6)=Class'BWBPJunkCollectionDE.IE_MetalToDirt'
     HitEffects(7)=Class'BWBPJunkCollectionDE.IE_AvgSnow'
     HitEffects(8)=Class'BWBPJunkCollectionDE.IE_AvgSnow'
     HitEffects(9)=Class'BWBPJunkCollectionDE.IE_WaterHit'
     HitEffects(10)=Class'BWBPJunkCollectionDE.IE_MetalToConcrete'
     HitDecals(0)=Class'BWBPJunkCollectionDE.AD_JunkBasicConcrete'
     HitDecals(1)=Class'BWBPJunkCollectionDE.AD_JunkBasicConcrete'
     HitDecals(2)=Class'BWBPJunkCollectionDE.AD_JunkBasicDirt'
     HitDecals(3)=Class'BWBPJunkCollectionDE.AD_JunkBasicMetal'
     HitDecals(4)=Class'BWBPJunkCollectionDE.AD_JunkBasicWood'
     HitDecals(5)=Class'BWBPJunkCollectionDE.AD_JunkBasicDirt'
     HitDecals(6)=Class'BWBPJunkCollectionDE.AD_JunkBasicDirt'
     HitDecals(7)=Class'BWBPJunkCollectionDE.AD_JunkBasicConcrete'
     HitDecals(8)=Class'BWBPJunkCollectionDE.AD_JunkBasicDirt'
     HitDecals(9)=Class'BWBPJunkCollectionDE.AD_JunkBasicDirt'
     HitDecals(10)=Class'BWBPJunkCollectionDE.AD_JunkBasicConcrete'
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Dirt'
     HitSounds(6)=Sound'BWBP_JW_Sound.Base'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Avg'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Concrete'
     HitSoundVolume=1.300000
     HitSoundPitch=0.900000
}
