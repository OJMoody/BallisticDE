//=============================================================================
// IM_IncendiaryBulletMinigun.
//
// ImpactManager subclass for incendiary minigun bullets which need to be faster
// and get custom effects. Reduced effects from regular.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_IncendiaryBulletMinigun extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBPArchivePackDE.IE_IncMinigunBulletConcrete'
     HitEffects(1)=Class'BWBPArchivePackDE.IE_IncMinigunBulletConcrete'
     HitEffects(2)=Class'BWBPArchivePackDE.IE_IncBulletDirt'
     HitEffects(3)=Class'BWBPArchivePackDE.IE_IncMinigunBulletMetal'
     HitEffects(4)=Class'BWBPArchivePackDE.IE_IncBulletWood'
     HitEffects(5)=Class'BWBPArchivePackDE.IE_IncBulletGrass'
     HitEffects(6)=Class'XEffects.pclredsmoke'
     HitEffects(7)=Class'BWBPArchivePackDE.IE_IncBulletIce'
     HitEffects(8)=Class'BWBPArchivePackDE.IE_IncBulletSnow'
     HitEffects(9)=Class'BallisticDE.IE_BulletWater'
     HitEffects(10)=Class'BWBPArchivePackDE.IE_IncBulletGlass'
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
     HitSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(1)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(2)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSounds(3)=SoundGroup'BallisticSounds2.BulletImpacts.BulletMetal'
     HitSounds(4)=SoundGroup'BallisticSounds2.BulletImpacts.BulletWood'
     HitSounds(5)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSounds(6)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(7)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(8)=SoundGroup'BallisticSounds2.BulletImpacts.BulletDirt'
     HitSounds(9)=SoundGroup'BallisticSounds2.BulletImpacts.BulletWater'
     HitSounds(10)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSoundVolume=0.850000
     HitSoundRadius=160.000000
     HitDelay=0.080000
}
