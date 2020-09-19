//=============================================================================
// IM_JunkBigMace.
//
// Impact Manager for Fire Axe
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkFireAxe extends BCShakeImpact;

defaultproperties
{
     HitEffects(0)=Class'JunkWarDE.IE_ClubConcrete'
     HitEffects(1)=Class'JunkWarDE.IE_ClubConcrete'
     HitEffects(2)=Class'JunkWarDE.IE_ClubDirt'
     HitEffects(3)=Class'JunkWarDE.IE_ClubMetal'
     HitEffects(4)=Class'JunkWarDE.IE_ClubWood'
     HitEffects(5)=Class'JunkWarDE.IE_ClubGrass'
     HitEffects(6)=Class'JunkWarDE.IE_AvgPlayer'
     HitEffects(7)=Class'JunkWarDE.IE_BigSnow'
     HitEffects(8)=Class'JunkWarDE.IE_BigSnow'
     HitEffects(9)=Class'JunkWarDE.IE_WaterHit'
     HitEffects(10)=Class'JunkWarDE.IE_ClubConcrete'
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
     DecalScale=1.500000
     HitSounds(0)=SoundGroup'JunkWarSounds.Sledge.Sledge-Concrete'
     HitSounds(1)=SoundGroup'JunkWarSounds.Sledge.Sledge-Concrete'
     HitSounds(2)=SoundGroup'JunkWarSounds.Sledge.Sledge-Dirt'
     HitSounds(3)=SoundGroup'JunkWarSounds.Sledge.Sledge-Metal'
     HitSounds(4)=SoundGroup'JunkWarSounds.Sledge.Sledge-Wood'
     HitSounds(5)=SoundGroup'JunkWarSounds.Sledge.Sledge-Dirt'
     HitSounds(6)=SoundGroup'JunkWarSounds.Flesh.Flesh-HeavySharp'
     HitSounds(7)=SoundGroup'JunkWarSounds.Sledge.Sledge-Dirt'
     HitSounds(8)=SoundGroup'JunkWarSounds.Sledge.Sledge-Dirt'
     HitSounds(9)=Sound'JunkWarSounds.Misc.Water-Big'
     HitSounds(10)=SoundGroup'JunkWarSounds.Sledge.Sledge-Concrete'
     HitSoundVolume=1.300000
     HitSoundRadius=72.000000
     HitSoundPitch=1.200000
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=64.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=4.000000,Y=4.000000,Z=4.000000)
     ShakeOffsetTime=2.000000
}
