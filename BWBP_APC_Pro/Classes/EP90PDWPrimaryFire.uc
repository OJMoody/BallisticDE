//=============================================================================
// EP90PDWPrimaryFire.
//
// Decent pistol shots that are accurate if the gun is steady enough
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class EP90PDWPrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     WaterRangeAtten=0.500000
	 DryFireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Empty',Volume=1.200000)
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-30.000000,Y=1.000000)
     AmmoClass=Class'BWBP_APC_Pro.Ammo_EP90HV'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
}
