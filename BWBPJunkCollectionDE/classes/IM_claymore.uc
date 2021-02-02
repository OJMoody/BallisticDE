//=============================================================================
// IM_claymore.
//
// Impact Manager for Claymore
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_claymore extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticDE.IE_KnifeConcrete'
     HitEffects(1)=Class'BallisticDE.IE_KnifeConcrete'
     HitEffects(2)=Class'BallisticDE.IE_BulletDirt'
     HitEffects(3)=Class'BallisticDE.IE_KnifeMetal'
     HitEffects(4)=Class'BallisticDE.IE_BulletWood'
     HitEffects(5)=Class'BallisticDE.IE_BulletGrass'
     HitEffects(6)=Class'BallisticDE.IE_BulletDirt'
     HitEffects(7)=Class'BallisticDE.IE_BulletIce'
     HitEffects(8)=Class'BallisticDE.IE_BulletIce'
     HitEffects(9)=Class'BallisticDE.IE_ProjWater'
     HitEffects(10)=Class'BallisticDE.IE_BulletGlass'
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
     HitSounds(0)=SoundGroup'BW_Core_WeaponSound.A73.A73ConcreteHit'
     HitSounds(1)=SoundGroup'BW_Core_WeaponSound.A73.A73ConcreteHit'
     HitSounds(2)=SoundGroup'BW_Core_WeaponSound.A73.A73ConcreteHit'
     HitSounds(3)=SoundGroup'BW_Core_WeaponSound.A73.A73MetalHit'
     HitSounds(4)=SoundGroup'BW_Core_WeaponSound.A73.A73WoodHit'
     HitSounds(5)=SoundGroup'BW_Core_WeaponSound.A73.A73WoodHit'
     HitSounds(6)=SoundGroup'BW_Core_WeaponSound.A73.A73ConcreteHit'
     HitSounds(7)=SoundGroup'BW_Core_WeaponSound.A73.A73ConcreteHit'
     HitSounds(8)=SoundGroup'BW_Core_WeaponSound.A73.A73ConcreteHit'
     HitSounds(9)=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Water'
     HitSounds(10)=SoundGroup'BW_Core_WeaponSound.A73.A73ConcreteHit'
     HitSoundVolume=1.000000
     HitSoundRadius=48.000000
     HitSoundPitch=1.100000
}
