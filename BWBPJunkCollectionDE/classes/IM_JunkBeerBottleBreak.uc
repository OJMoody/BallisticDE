//=============================================================================
// IM_JunkBeerBottleBreak.
//
// Impact Manager for breaking beer bottle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkBeerBottleBreak extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBPJunkCollectionDE.IE_BeerBottle'
     HitEffects(1)=Class'BWBPJunkCollectionDE.IE_BeerBottle'
     HitEffects(2)=Class'BWBPJunkCollectionDE.IE_BeerBottle'
     HitEffects(3)=Class'BWBPJunkCollectionDE.IE_BeerBottle'
     HitEffects(4)=Class'BWBPJunkCollectionDE.IE_BeerBottle'
     HitEffects(5)=Class'BWBPJunkCollectionDE.IE_BeerBottle'
     HitEffects(6)=Class'BWBPJunkCollectionDE.IE_BeerBottle'
     HitEffects(7)=Class'BWBPJunkCollectionDE.IE_BeerBottle'
     HitEffects(8)=Class'BWBPJunkCollectionDE.IE_BeerBottle'
     HitEffects(9)=Class'BWBPJunkCollectionDE.IE_WaterHit'
     HitEffects(10)=Class'BWBPJunkCollectionDE.IE_BeerBottle'
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
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Break'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Break'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Break'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Break'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Break'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Break'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Break'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Break'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Break'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Small'
     HitSoundVolume=0.900000
     HitSoundRadius=48.000000
}
