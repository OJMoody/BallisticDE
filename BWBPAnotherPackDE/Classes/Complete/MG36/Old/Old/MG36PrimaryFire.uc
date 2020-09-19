//=============================================================================
// MG36PrimaryFire.
//
// Very accurate, long ranged and powerful bullet fire. Headshots are
// especially dangerous.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MG36PrimaryFire extends BallisticProInstantFire;

simulated function PreBeginPlay()
{
	if (MG36Rifle_TW(Weapon) != None)
		FireChaos = 0.03;
	super.PreBeginPlay();
}

defaultproperties
{
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WaterRangeFactor=0.800000
     WallPenetrationForce=128.000000
     Damage=20.000000
     DamageHead=25.000000
     DamageLimb=17.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPAnotherPackDE.DT_MG36Torso'
     DamageTypeHead=Class'BWBPAnotherPackDE.DT_MG36Head'
     DamageTypeArm=Class'BWBPAnotherPackDE.DT_MG36Torso'
     KickForce=25000
     PenetrateForce=450
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticDE.M925FlashEmitter'
     BrassClass=Class'BWBPAnotherPackDE.Brass_BMG'
     BrassBone="ejector"
     BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
     RecoilPerShot=768.000000
     VelocityRecoil=255.000000
     FireChaos=0.700000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.X82.X82-Fire',Volume=10.000000,Radius=1024.000000)
     FireEndAnim=
     FireRate=0.120000
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_50BMG'
     ShakeRotMag=(X=450.000000,Y=64.000000)
     ShakeRotRate=(X=12400.000000,Y=12400.000000,Z=12400.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-5.500000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.250000
     BotRefireRate=0.300000
     WarnTargetPct=0.700000
     aimerror=950.000000
}
