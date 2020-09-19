//=============================================================================
// IM_JunkClubHammer.
//
// Impact Manager for Club Hammer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkClubHammer extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'JunkWarDE.IE_ClubConcrete'
     HitEffects(1)=Class'JunkWarDE.IE_ClubConcrete'
     HitEffects(2)=Class'JunkWarDE.IE_ClubDirt'
     HitEffects(3)=Class'JunkWarDE.IE_ClubMetal'
     HitEffects(4)=Class'JunkWarDE.IE_ClubWood'
     HitEffects(5)=Class'JunkWarDE.IE_ClubGrass'
     HitEffects(6)=Class'JunkWarDE.IE_AvgPlayer'
     HitEffects(7)=Class'JunkWarDE.IE_AvgSnow'
     HitEffects(8)=Class'JunkWarDE.IE_AvgSnow'
     HitEffects(9)=Class'JunkWarDE.IE_WaterHit'
     HitEffects(10)=Class'JunkWarDE.IE_ClubConcrete'
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
     DecalScale=1.250000
     HitSounds(0)=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Concrete'
     HitSounds(1)=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Concrete'
     HitSounds(2)=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Dirt'
     HitSounds(3)=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Metal'
     HitSounds(4)=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Wood'
     HitSounds(5)=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Dirt'
     HitSounds(6)=SoundGroup'JunkWarSounds.Flesh.Flesh-AvgBlunt'
     HitSounds(7)=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Dirt'
     HitSounds(8)=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Dirt'
     HitSounds(9)=Sound'JunkWarSounds.Misc.Water-Avg'
     HitSounds(10)=SoundGroup'JunkWarSounds.Clubhammer.Clubhammer-Concrete'
     HitSoundVolume=1.700000
     HitSoundRadius=48.000000
}
