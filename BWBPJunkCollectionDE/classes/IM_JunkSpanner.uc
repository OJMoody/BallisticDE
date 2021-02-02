//=============================================================================
// IM_JunkSpanner.
//
// Impact Manager for Spanner
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkSpanner extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBPJunkCollectionDE.IE_MetalToConcrete'
     HitEffects(1)=Class'BWBPJunkCollectionDE.IE_MetalToConcrete'
     HitEffects(2)=Class'BWBPJunkCollectionDE.IE_MetalToDirt'
     HitEffects(3)=Class'BWBPJunkCollectionDE.IE_MetalToMetal'
     HitEffects(4)=Class'BWBPJunkCollectionDE.IE_MetalToWood'
     HitEffects(5)=Class'BWBPJunkCollectionDE.IE_MetalToGrass'
     HitEffects(6)=Class'BWBPJunkCollectionDE.IE_SmallPlayer'
     HitEffects(7)=Class'BWBPJunkCollectionDE.IE_AvgSnow'
     HitEffects(8)=Class'BWBPJunkCollectionDE.IE_AvgSnow'
     HitEffects(9)=Class'BWBPJunkCollectionDE.IE_WaterHit'
     HitEffects(10)=Class'BWBPJunkCollectionDE.IE_MetalToConcrete'
     HitDecals(0)=Class'BWBPJunkCollectionDE.AD_JunkLightBluntConcrete'
     HitDecals(1)=Class'BWBPJunkCollectionDE.AD_JunkLightBluntConcrete'
     HitDecals(2)=Class'BWBPJunkCollectionDE.AD_JunkLightBluntDirt'
     HitDecals(3)=Class'BWBPJunkCollectionDE.AD_JunkLightBluntMetal'
     HitDecals(4)=Class'BWBPJunkCollectionDE.AD_JunkLightBluntWood'
     HitDecals(5)=Class'BWBPJunkCollectionDE.AD_JunkLightBluntDirt'
     HitDecals(6)=Class'BWBPJunkCollectionDE.AD_JunkLightBluntDirt'
     HitDecals(7)=Class'BWBPJunkCollectionDE.AD_JunkLightBluntConcrete'
     HitDecals(8)=Class'BWBPJunkCollectionDE.AD_JunkLightBluntDirt'
     HitDecals(9)=Class'BWBPJunkCollectionDE.AD_JunkLightBluntDirt'
     HitDecals(10)=Class'BWBPJunkCollectionDE.AD_JunkLightBluntConcrete'
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Dirt'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.Flesh.Flesh-LightBlunt'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Small'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Concrete'
     HitSoundVolume=0.900000
     HitSoundRadius=48.000000
}
