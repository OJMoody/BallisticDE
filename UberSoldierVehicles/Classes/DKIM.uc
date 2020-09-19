class DKIM extends BCImpactManager;

simulated function PostNetBeginPlay()
{
	local actor T;
	local vector HitLocation;
	local Material HitMat;

	Super.PostNetBeginPlay();

	if (HitDelay >= LifeSpan)
		LifeSpan+=HitDelay;

	if ( Role < ROLE_Authority )
	{
		T = Trace (HitLocation, HitNorm, Location - Vector(Rotation)*5, Location, false, , HitMat);
		if (T.bWorldGeometry)
			Initialize(HitMat.SurfaceType, HitNorm);
	}
}

defaultproperties
{
}
