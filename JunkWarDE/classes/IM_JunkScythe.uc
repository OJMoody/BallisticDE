//=============================================================================
// IM_JunkScythe.
//
// Impact Manager for Scythe
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkScythe extends BCImpactManager;

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
     HitDecals(0)=Class'JunkWarDE.AD_JunkBigSharpConcrete'
     HitDecals(1)=Class'JunkWarDE.AD_JunkBigSharpConcrete'
     HitDecals(2)=Class'JunkWarDE.AD_JunkBigSharpDirt'
     HitDecals(3)=Class'JunkWarDE.AD_JunkBigSharpMetal'
     HitDecals(4)=Class'JunkWarDE.AD_JunkBigSharpWood'
     HitDecals(5)=Class'JunkWarDE.AD_JunkBigSharpDirt'
     HitDecals(6)=Class'JunkWarDE.AD_JunkBigSharpDirt'
     HitDecals(7)=Class'JunkWarDE.AD_JunkBigSharpConcrete'
     HitDecals(8)=Class'JunkWarDE.AD_JunkBigSharpDirt'
     HitDecals(9)=Class'JunkWarDE.AD_JunkBigSharpDirt'
     HitDecals(10)=Class'JunkWarDE.AD_JunkBigSharpConcrete'
     DecalScale=2.000000
     HitSounds(0)=SoundGroup'JunkWarSounds.Icepick.Icepick-Concrete'
     HitSounds(1)=SoundGroup'JunkWarSounds.Icepick.Icepick-Concrete'
     HitSounds(2)=SoundGroup'JunkWarSounds.Icepick.Icepick-Dirt'
     HitSounds(3)=SoundGroup'JunkWarSounds.Icepick.Icepick-Metal'
     HitSounds(4)=SoundGroup'JunkWarSounds.Icepick.Icepick-Wood'
     HitSounds(5)=SoundGroup'JunkWarSounds.Icepick.Icepick-Dirt'
     HitSounds(6)=SoundGroup'JunkWarSounds.Flesh.Flesh-AvgSharp'
     HitSounds(7)=SoundGroup'JunkWarSounds.Icepick.Icepick-Dirt'
     HitSounds(8)=SoundGroup'JunkWarSounds.Icepick.Icepick-Dirt'
     HitSounds(9)=Sound'JunkWarSounds.Misc.Water-Avg'
     HitSounds(10)=SoundGroup'JunkWarSounds.Icepick.Icepick-Concrete'
     HitSoundVolume=1.500000
     HitSoundRadius=48.000000
     HitSoundPitch=0.800000
}
