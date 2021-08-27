//=============================================================================
// ChaffRifleGrenade.
//
// Chaff Grenade fired by MJ51Carbine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SHADRACHRifleGrenade extends BallisticGrenade;


simulated function Explode(vector HitLocation, vector HitNormal)
{
  	local RX22AActorFire BurnA;
  	local FP7ActorBurner BurnB;
  	local BOGPFlareActorBurner BurnC;

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

   	foreach RadiusActors( class 'RX22AActorFire', BurnA, 100, HitLocation )
   	{
    	BurnA.FuelOut();
   	}
   	foreach RadiusActors( class 'FP7ActorBurner', BurnB, 100, HitLocation )
   	{
    	BurnB.bDynamicLight=False;
    	BurnB.Destroy();
   	}
   	foreach RadiusActors( class 'BOGPFlareActorBurner', BurnC, 100, HitLocation )
   	{
    	BurnC.bDynamicLight=False;
    	BurnC.Destroy();
   	} 
	Destroy();
}

defaultproperties
{
     DetonateOn=DT_Impact
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=1.000000
     ImpactDamage=90
     ImpactDamageType=Class'BWBP_SKC_Pro.DTChaffGrenade'
     ImpactManager=Class'BWBP_APC_Pro.IM_SHADRACHChaffGrenade'
     TrailClass=Class'BWBP_APC_Pro.SRKSmgTrail'
     TrailOffset=(X=-8.000000)
     MyRadiusDamageType=Class'BWBP_SKCExp_Pro.DTChaffGrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=768.000000
     MotionBlurFactor=2.000000
     MotionBlurTime=10.000000
     Speed=3750.000000
     MaxSpeed=4500.000000
     Damage=65.000000
     DamageRadius=192.000000
     MyDamageType=Class'BWBP_SKCExp_Pro.DTChaffGrenadeRadius'
     StaticMesh=StaticMesh'BWBP_CC_Static.SPXSmg.SHADRACH_Proj'
     DrawScale=0.200000
     bUnlit=False
	 ModeIndex=1
}
