//=============================================================================
// IM_Bullet.
//
// ImpactManager subclass for ordinary bullets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_ExpBullet extends IM_Bullet;

defaultproperties
{
     HitEffects(0)=Class'BWBPRecolorsDE.IE_BulletExpConcrete'
     HitEffects(1)=Class'BWBPRecolorsDE.IE_BulletExpConcrete'
     HitEffects(2)=Class'BWBPRecolorsDE.IE_BulletExpDirt'
     HitEffects(3)=Class'BWBPRecolorsDE.IE_BulletExpMetal'
     HitEffects(4)=Class'BWBPRecolorsDE.IE_BulletExpWood'
     HitEffects(5)=Class'BWBPRecolorsDE.IE_BulletExpGrass'
     HitEffects(7)=Class'BWBPRecolorsDE.IE_BulletExpIce'
     HitEffects(8)=Class'BWBPRecolorsDE.IE_BulletExpSnow'
     HitDecals(0)=Class'BallisticDE.AD_BigBulletConcrete'
     HitDecals(1)=Class'BallisticDE.AD_BigBulletConcrete'
     HitDecals(3)=Class'BallisticDE.AD_BigBulletMetal'
     HitDecals(4)=Class'BallisticDE.AD_BigBulletWood'
     HitDecals(5)=Class'BallisticDE.AD_BigBulletConcrete'
     HitDecals(6)=Class'BallisticDE.AD_BigBulletConcrete'
     HitDecals(7)=Class'BallisticDE.AD_BigBulletConcrete'
     HitDecals(10)=Class'BallisticDE.AD_BigBulletConcrete'
     HitSoundVolume=0.900000
     HitSoundRadius=124.000000
}
