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
     HitDecals(0)=Class'JunkWarDE.AD_JunkLightBluntConcrete'
     HitDecals(1)=Class'JunkWarDE.AD_JunkLightBluntConcrete'
     HitDecals(2)=Class'JunkWarDE.AD_JunkLightBluntDirt'
     HitDecals(3)=Class'JunkWarDE.AD_JunkLightBluntMetal'
     HitDecals(4)=Class'JunkWarDE.AD_JunkLightBluntWood'
     HitDecals(5)=Class'JunkWarDE.AD_JunkLightBluntDirt'
     HitDecals(6)=Class'JunkWarDE.AD_JunkLightBluntDirt'
     HitDecals(7)=Class'JunkWarDE.AD_JunkLightBluntConcrete'
     HitDecals(8)=Class'JunkWarDE.AD_JunkLightBluntDirt'
     HitDecals(9)=Class'JunkWarDE.AD_JunkLightBluntDirt'
     HitDecals(10)=Class'JunkWarDE.AD_JunkLightBluntConcrete'
     HitSounds(0)=SoundGroup'JunkWarSounds.Spanner.Spanner-Concrete'
     HitSounds(1)=SoundGroup'JunkWarSounds.Spanner.Spanner-Concrete'
     HitSounds(2)=SoundGroup'JunkWarSounds.Spanner.Spanner-Dirt'
     HitSounds(3)=SoundGroup'JunkWarSounds.Spanner.Spanner-Metal'
     HitSounds(4)=SoundGroup'JunkWarSounds.Spanner.Spanner-Wood'
     HitSounds(5)=SoundGroup'JunkWarSounds.Spanner.Spanner-Dirt'
     HitSounds(6)=SoundGroup'JunkWarSounds.Flesh.Flesh-LightBlunt'
     HitSounds(7)=SoundGroup'JunkWarSounds.Spanner.Spanner-Dirt'
     HitSounds(8)=SoundGroup'JunkWarSounds.Spanner.Spanner-Dirt'
     HitSounds(9)=Sound'JunkWarSounds.Misc.Water-Small'
     HitSounds(10)=SoundGroup'JunkWarSounds.Spanner.Spanner-Concrete'
     HitSoundVolume=0.900000
     HitSoundRadius=48.000000
}
