class IM_Raygun extends BCImpactManager;

simulated function Initialize (int HitSurfaceType, vector Norm, optional byte Flags)
{
	if (HitSurfaceType > 0)
		HitSoundRadius=256;

	super.Initialize(HitSurfaceType, Norm, Flags);
}

defaultproperties
{
     HitEffects(0)=Class'BWBPArchivePackDE.IE_RaygunChargedExplosion'
     HitEffects(1)=Class'BWBPArchivePackDE.IE_RaygunProjectile'
     HitDecals(0)=Class'BallisticDE.AD_Explosion'
     HitDecals(1)=Class'BallisticDE.AD_RSDarkFast'
     HitSounds(0)=Sound'BWBPOtherPackSound.Raygun.Raygun-ImpactBig'
     HitSounds(1)=Sound'BWBPOtherPackSound.Raygun.Raygun-Impact'
     HitSoundVolume=1.000000
     HitSoundRadius=2048.000000
}
