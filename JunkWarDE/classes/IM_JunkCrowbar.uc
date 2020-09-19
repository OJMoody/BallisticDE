//=============================================================================
// IM_JunkCrowbar.
//
// Impact Manager for Crowbar
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkCrowbar extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'JunkWarDE.IE_MetalToConcrete'
     HitEffects(1)=Class'JunkWarDE.IE_MetalToConcrete'
     HitEffects(2)=Class'JunkWarDE.IE_MetalToDirt'
     HitEffects(3)=Class'JunkWarDE.IE_MetalToMetal'
     HitEffects(4)=Class'JunkWarDE.IE_MetalToWood'
     HitEffects(5)=Class'JunkWarDE.IE_MetalToGrass'
     HitEffects(6)=Class'JunkWarDE.IE_AvgPlayer'
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
     DecalScale=0.750000
     HitSounds(0)=SoundGroup'JunkWarSounds.Crowbar.Crowbar-Concrete'
     HitSounds(1)=SoundGroup'JunkWarSounds.Crowbar.Crowbar-Concrete'
     HitSounds(2)=SoundGroup'JunkWarSounds.Crowbar.Crowbar-Dirt'
     HitSounds(3)=SoundGroup'JunkWarSounds.Crowbar.Crowbar-Metal'
     HitSounds(4)=SoundGroup'JunkWarSounds.Crowbar.Crowbar-Wood'
     HitSounds(5)=SoundGroup'JunkWarSounds.Crowbar.Crowbar-Dirt'
     HitSounds(6)=SoundGroup'JunkWarSounds.Flesh.Flesh-AvgBlunt'
     HitSounds(7)=SoundGroup'JunkWarSounds.Crowbar.Crowbar-Dirt'
     HitSounds(8)=SoundGroup'JunkWarSounds.Crowbar.Crowbar-Dirt'
     HitSounds(9)=Sound'JunkWarSounds.Misc.Water-Avg'
     HitSounds(10)=SoundGroup'JunkWarSounds.Crowbar.Crowbar-Concrete'
     HitSoundVolume=1.100000
     HitSoundRadius=48.000000
}
