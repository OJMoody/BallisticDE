//=============================================================================
// IM_pan.
//
// Impact Manager for pan
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_pan extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBPJunkCollectionDE.IE_ClubConcrete'
     HitEffects(1)=Class'BWBPJunkCollectionDE.IE_ClubConcrete'
     HitEffects(2)=Class'BWBPJunkCollectionDE.IE_ClubDirt'
     HitEffects(3)=Class'BWBPJunkCollectionDE.IE_ClubMetal'
     HitEffects(4)=Class'BWBPJunkCollectionDE.IE_ClubWood'
     HitEffects(5)=Class'BWBPJunkCollectionDE.IE_ClubGrass'
     HitEffects(6)=Class'BWBPJunkCollectionDE.IE_AvgPlayer'
     HitEffects(7)=Class'BWBPJunkCollectionDE.IE_AvgSnow'
     HitEffects(8)=Class'BWBPJunkCollectionDE.IE_AvgSnow'
     HitEffects(9)=Class'BWBPJunkCollectionDE.IE_WaterHit'
     HitEffects(10)=Class'BWBPJunkCollectionDE.IE_ClubConcrete'
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
     DecalScale=1.250000
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Dirt'
     HitSounds(3)=Sound'BWBP_JW_Sound.pan.pansound'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Dirt'
     HitSounds(6)=Sound'BWBP_JW_Sound.pan.pansound'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Avg'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Concrete'
     HitSoundVolume=1.700000
     HitSoundRadius=48.000000
}
