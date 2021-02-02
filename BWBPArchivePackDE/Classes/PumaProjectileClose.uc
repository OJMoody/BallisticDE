//=============================================================================
// PUMACloseProjectile.
//
// Energy explosive. Blows up in your face.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PUMAProjectileClose extends BallisticGrenade;

defaultproperties
{
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=0.000100
     ImpactDamage=100
     ImpactDamageType=Class'BallisticDE.DTM50Grenade'
     ImpactManager=Class'BWBPArchivePackDE.IM_PumaDetClose'
     TrailClass=Class'Onslaught.ONSSkyMineEffect'
     MyRadiusDamageType=Class'BWBPArchivePackDE.DT_PUMASelf'
     SplashManager=Class'BallisticDE.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=300.000000
     Speed=6000.000000
     Damage=110.000000
     DamageRadius=360.000000
     MomentumTransfer=60000.000000
     MyDamageType=Class'BWBPArchivePackDE.DT_PUMASelf'
     LightHue=180
     LightSaturation=100
     LightBrightness=160.000000
     LightRadius=8.000000
     StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj'
     LifeSpan=16.000000
     DrawScale=2.000000
}
