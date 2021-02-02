//=============================================================================
// IM_BulletRad.
// 
// ImpactManager subclass for amp'd rad bullets
// 
// by Sarge + other pack dudes
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_BulletRad extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBPAnotherPackDE.IE_BulletRadLarge'
     HitDecals(0)=Class'BWBPAnotherPackDE.AD_SX45Scorch'
     HitSounds(0)=Sound'BWBP_SKC_SoundsExp.SX45.SX45-RadImpact'
     HitSoundVolume=1.000000
     HitSoundRadius=256.000000
}
