//=============================================================================
// IM_Tranq.
//
// ImpactManager subclass for tranq darts
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_Tranq extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticDE.IE_BulletConcrete'
     HitEffects(1)=Class'BallisticDE.IE_BulletConcrete'
     HitEffects(2)=Class'BallisticDE.IE_BulletDirt'
     HitEffects(3)=Class'BallisticDE.IE_BulletMetal'
     HitEffects(4)=Class'BallisticDE.IE_BulletWood'
     HitEffects(5)=Class'BallisticDE.IE_BulletGrass'
     HitEffects(6)=Class'XEffects.pclredsmoke'
     HitEffects(7)=Class'BallisticDE.IE_BulletIce'
     HitEffects(8)=Class'BallisticDE.IE_BulletSnow'
     HitEffects(9)=Class'BallisticDE.IE_BulletWater'
     HitEffects(10)=Class'BallisticDE.IE_BulletGlass'
     HitDecals(0)=Class'BallisticDE.AD_BulletConcrete'
     HitDecals(1)=Class'BallisticDE.AD_BulletConcrete'
     HitDecals(2)=Class'BallisticDE.AD_BulletDirt'
     HitDecals(3)=Class'BallisticDE.AD_BulletMetal'
     HitDecals(4)=Class'BallisticDE.AD_BulletWood'
     HitDecals(5)=Class'BallisticDE.AD_BulletConcrete'
     HitDecals(6)=Class'BallisticDE.AD_BulletConcrete'
     HitDecals(7)=Class'BallisticDE.AD_BulletIce'
     HitDecals(8)=Class'BallisticDE.AD_BulletDirt'
     HitDecals(10)=Class'BallisticDE.AD_BulletConcrete'
     HitSounds(0)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(1)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(2)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(3)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(4)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(5)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(6)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(7)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(8)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSounds(9)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.BulletWater'
     HitSounds(10)=Sound'BWBP_SKC_Sounds.VSK.VSK-Impact'
     HitSoundVolume=0.700000
     HitSoundRadius=128.000000
     HitDelay=0.100000
}
