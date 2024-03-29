//=============================================================================
// IM_A73Projectile.
//
// ImpactManager subclass for A73 projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_HVPCProjectile extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBP_SKCExp_Pro.IE_HVPCGeneral'
     HitDecals(0)=Class'BallisticProV55.AD_HVCRedDecal'
     HitSounds(0)=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Impact'
     HitSoundVolume=1.500000
     HitSoundRadius=256.000000
}
