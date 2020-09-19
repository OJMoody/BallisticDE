//=============================================================================
// IM_JunkSledgeHammer.
//
// Impact Manager for Sledge Hammer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkSledgeHammer extends BCShakeImpact;

defaultproperties
{
     HitEffects(0)=Class'JunkWarDE.IE_BigConcrete'
     HitEffects(1)=Class'JunkWarDE.IE_BigConcrete'
     HitEffects(2)=Class'JunkWarDE.IE_BigDirt'
     HitEffects(3)=Class'JunkWarDE.IE_BigMetal'
     HitEffects(4)=Class'JunkWarDE.IE_BigWood'
     HitEffects(5)=Class'JunkWarDE.IE_BigGrass'
     HitEffects(6)=Class'JunkWarDE.IE_BigPlayer'
     HitEffects(7)=Class'JunkWarDE.IE_BigSnow'
     HitEffects(8)=Class'JunkWarDE.IE_BigSnow'
     HitEffects(9)=Class'JunkWarDE.IE_WaterHit'
     HitEffects(10)=Class'JunkWarDE.IE_BigConcrete'
     HitDecals(0)=Class'JunkWarDE.AD_JunkHeavyConcrete'
     HitDecals(1)=Class'JunkWarDE.AD_JunkHeavyConcrete'
     HitDecals(2)=Class'JunkWarDE.AD_JunkHeavyDirt'
     HitDecals(3)=Class'JunkWarDE.AD_JunkHeavyMetal'
     HitDecals(4)=Class'JunkWarDE.AD_JunkHeavyWood'
     HitDecals(5)=Class'JunkWarDE.AD_JunkHeavyDirt'
     HitDecals(6)=Class'JunkWarDE.AD_JunkHeavyDirt'
     HitDecals(7)=Class'JunkWarDE.AD_JunkHeavyConcrete'
     HitDecals(8)=Class'JunkWarDE.AD_JunkHeavyDirt'
     HitDecals(9)=Class'JunkWarDE.AD_JunkHeavyDirt'
     HitDecals(10)=Class'JunkWarDE.AD_JunkHeavyConcrete'
     HitSounds(0)=SoundGroup'JunkWarSounds.Sledge.Sledge-Concrete'
     HitSounds(1)=SoundGroup'JunkWarSounds.Sledge.Sledge-Concrete'
     HitSounds(2)=SoundGroup'JunkWarSounds.Sledge.Sledge-Dirt'
     HitSounds(3)=SoundGroup'JunkWarSounds.Sledge.Sledge-Metal'
     HitSounds(4)=SoundGroup'JunkWarSounds.Sledge.Sledge-Wood'
     HitSounds(5)=SoundGroup'JunkWarSounds.Sledge.Sledge-Dirt'
     HitSounds(6)=SoundGroup'JunkWarSounds.Flesh.Flesh-HeavyBlunt'
     HitSounds(7)=SoundGroup'JunkWarSounds.Sledge.Sledge-Dirt'
     HitSounds(8)=SoundGroup'JunkWarSounds.Sledge.Sledge-Dirt'
     HitSounds(9)=Sound'JunkWarSounds.Misc.Water-Big'
     HitSounds(10)=SoundGroup'JunkWarSounds.Sledge.Sledge-Concrete'
     HitSoundVolume=1.500000
     HitSoundRadius=72.000000
     ShakeRotMag=(X=192.000000,Y=192.000000,Z=192.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=4.000000
     ShakeOffsetMag=(X=8.000000,Y=8.000000,Z=8.000000)
     ShakeOffsetTime=4.000000
}
