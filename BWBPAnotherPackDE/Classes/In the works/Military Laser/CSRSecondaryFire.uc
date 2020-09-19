//=============================================================================
// CSRSecondaryFire
//
// Powerful 5-laser blast.
//
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CSRSecondaryFire extends BallisticShotgunFire;

var()	float			HeatPerShot;

//The XM20 deals increased damage to targets which have already been heated up by a previous strike.
function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{	
	if (Pawn(Target) != None && Pawn(Target).bProjTarget)
		Damage += XM20AutoLas(BW).ManageHeatInteraction(Pawn(Target), HeatPerShot);
	
	if (Monster(Target) != None)
		Damage = Min(Damage, 40);

	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
}

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
     HeatPerShot=1.000000
	 TraceCount=3
     TracerClass=Class'BWBPRecolorsDE.TraceEmitter_LS14C'
     ImpactManager=Class'BWBPRecolorsDE.IM_LS14Impacted'
     TraceRange=(Min=11000.000000,Max=12000.000000)
     Damage=12.000000
     DamageHead=18.000000
     DamageLimb=12.000000
     DamageType=Class'BWBPSomeOtherPackDE.DTXM20Body'
     DamageTypeHead=Class'BWBPSomeOtherPackDE.DTXM20Head'
     DamageTypeArm=Class'BWBPSomeOtherPackDE.DTXM20Body'
     KickForce=25000
     PenetrateForce=500
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-LastShot',Volume=1.000000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-Empty',Volume=1.200000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBPRecolorsDE.LS14FlashEmitter'
     FlashScaleFactor=0.050000
     BrassOffset=(X=-1.000000,Z=-1.000000)
     RecoilPerShot=240.000000
     VelocityRecoil=180.000000
     XInaccuracy=700.000000
     YInaccuracy=700.000000
	 FireAnim="FireHeavy"
	 AimedFireAnim="SightFireHeavy"
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.XM35.XM35-10Split',Volume=1.200000)
     FireEndAnim=
     TweenTime=0.000000
     FireRate=0.150000
	 FlashBone="Muzzle"
     AmmoClass=Class'BWBPSomeOtherPackDE.Ammo_XM20Laser'
     AmmoPerFire=3
     ShakeRotMag=(X=200.000000,Y=16.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=-2.500000)
     ShakeOffsetRate=(X=-500.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
