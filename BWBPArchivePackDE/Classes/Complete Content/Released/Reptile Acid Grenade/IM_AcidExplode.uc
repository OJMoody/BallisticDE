//=============================================================================
// IM_FireExplode.
//
// ImpactManager subclass for Fire Explosions
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_AcidExplode extends BCImpactManager;
/*
     HitEffects(0)=Class'BallisticDE.IE_FireExplosion'
     HitDecals(0)=Class'BallisticDE.AD_FireExplosion'
Sound'BallisticSounds3.FP7.FP7Ignition'//
*/

defaultproperties
{
     HitSounds(0)=Sound'BallisticSounds_25.Reptile.Rep_AltImpact'
     HitSoundVolume=2.000000
     HitSoundRadius=1024.000000
     EffectBackOff=32.000000
}
