//=============================================================================
// IM_FlareExplode.
//
// ImpactManager subclass for FLASH explosions
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_FlareExplode extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBPArchivePackDE.IE_FlareExplode'
     HitDecals(0)=Class'BallisticDE.AD_FireExplosion'
     HitSounds(0)=Sound'PackageSounds4.Misc.M202-Boom3'
     HitSoundVolume=1.000000
     HitSoundRadius=512.000000
     EffectBackOff=32.000000
}
