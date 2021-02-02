//=============================================================================
// IM_JunkMachete.
//
// Impact Manager for Machete
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkMachete extends BCImpactManager;

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
     HitDecals(0)=Class'BWBPJunkCollectionDE.AD_JunkBigSharpConcrete'
     HitDecals(1)=Class'BWBPJunkCollectionDE.AD_JunkBigSharpConcrete'
     HitDecals(2)=Class'BWBPJunkCollectionDE.AD_JunkBigSharpDirt'
     HitDecals(3)=Class'BWBPJunkCollectionDE.AD_JunkBigSharpMetal'
     HitDecals(4)=Class'BWBPJunkCollectionDE.AD_JunkBigSharpWood'
     HitDecals(5)=Class'BWBPJunkCollectionDE.AD_JunkBigSharpDirt'
     HitDecals(6)=Class'BWBPJunkCollectionDE.AD_JunkBigSharpDirt'
     HitDecals(7)=Class'BWBPJunkCollectionDE.AD_JunkBigSharpConcrete'
     HitDecals(8)=Class'BWBPJunkCollectionDE.AD_JunkBigSharpDirt'
     HitDecals(9)=Class'BWBPJunkCollectionDE.AD_JunkBigSharpDirt'
     HitDecals(10)=Class'BWBPJunkCollectionDE.AD_JunkBigSharpConcrete'
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Dirt'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.Flesh.Flesh-AvgSharp'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Small'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Concrete'
     HitSoundVolume=1.000000
     HitSoundRadius=48.000000
     HitSoundPitch=1.100000
}
