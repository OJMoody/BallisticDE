//=============================================================================
// RGPXRocket.
//
// Rocket projectile for the RGPX RPG.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RGPXFlakRocket extends BallisticGrenade;

/*simulated function PostNetBeginPlay()
{
	Velocity = Normal(Velocity) * default.Speed;
	super.PostNetBeginPlay();
}*/

defaultproperties
{    
	 ModeIndex=1
     ImpactManager=Class'BWBP_JCF_Pro.IM_RGPX'
     bRandomStartRotation=False
	 DetonateOn=DT_Impact
	 Physics=PHYS_Falling
     TrailClass=Class'BWBP_JCF_Pro.RGPXRocketTrail'
     TrailOffset=(X=-14.000000)
     MyRadiusDamageType=Class'BWBP_JCF_Pro.DTRGPXBazookaRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=378.000000
     MotionBlurRadius=512.000000
     ShakeRotMag=(X=512.000000,Y=400.000000)
     ShakeRotRate=(X=3000.000000,Z=3000.000000)
     ShakeOffsetMag=(X=20.000000,Y=30.000000,Z=30.000000)
     Speed=0.100000
	 AccelSpeed=0.000000
     Damage=80.000000
     DamageRadius=1024.000000
     WallPenetrationForce=384
     MomentumTransfer=75000.000000
     MyDamageType=Class'BWBP_JCF_Pro.DTRGPXBazooka'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     StaticMesh=StaticMesh'BWBP_JCF_Static.RGP-X350.RGP-X350_ProjMini'
     bDynamicLight=True
     bNetTemporary=False
     bUpdateSimulatedPosition=True
     AmbientSound=Sound'BW_Core_WeaponSound.G5.G5-RocketFly'
     DrawScale=0.180000
     SoundVolume=192
     SoundRadius=128.000000
     CollisionRadius=4.000000
     CollisionHeight=4.000000
     bUseCollisionStaticMesh=True
     bFixedRotationDir=True
}
