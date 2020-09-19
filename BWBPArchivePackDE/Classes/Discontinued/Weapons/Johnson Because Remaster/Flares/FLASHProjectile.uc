//-----------------------------------------------------------
//Incendiary Rocket for the FLASH-1
//-----------------------------------------------------------
class FLASHProjectile extends BallisticGrenade;

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local FLASHFireControl F;
	if (ShakeRadius > 0)
		ShakeView(HitLocation);
	BlowUp(HitLocation);
    	if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	if ( Role == ROLE_Authority )
	{
		F = Spawn(class'FLASHFireControl',self,,HitLocation-HitNormal*2, rot(0,0,0));
		if (F!=None)
		{
			F.Instigator = Instigator;
			F.Initialize();
		}
	}
	Destroy();
}

defaultproperties
{
     DetonateOn=DT_Impact
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=1.000000
     ImpactDamage=110
     ImpactDamageType=Class'BWBPArchivePackDE.DT_FLASH'
     ImpactManager=Class'BWBPArchivePackDE.IM_FlareExplode'
     TrailClass=Class'BWBPArchivePackDE.FLASHRocketTrail'
     TrailOffset=(X=-8.000000)
     MyRadiusDamageType=Class'BWBPArchivePackDE.DT_FLASHRadius'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     Speed=4500.000000
     Damage=100.000000
     DamageRadius=270.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'BWBPArchivePackDE.DT_FLASHRadius'
     StaticMesh=StaticMesh'BWBP4-Hardware.MRL.MRLRocket'
     AmbientSound=Sound'PackageSounds4A.Flash.M202-Flyby'
     DrawScale=1.000000
     AmbientGlow=32
     SoundVolume=255
     RotationRate=(Roll=32768)
}
