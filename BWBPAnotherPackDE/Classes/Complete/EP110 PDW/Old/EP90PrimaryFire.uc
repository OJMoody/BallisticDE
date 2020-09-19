//  =============================================================================
//   AH104PrimaryFire.
//  
//   Very powerful, long range bullet attack.
//  
//   You'll be attacked with bullets.
//   Hello whoever is reading this.
//  =============================================================================
class EP90PrimaryFire extends BallisticProInstantFire;

var() float 	ChargeRate;
var() Sound	ChargeSound;
var() sound	ExhaustSound;
var   float RailPower;
var bool	bIsCharging;
var() sound		SuperFireSound;
var() sound		SuperFireSound2;

simulated event ModeDoFire()
{
    if (!AllowFire())
	  return;

	if (EP90Pistol(Weapon).CurrentWeaponMode == 1) 
		     BallisticFireSound.Sound=SuperFireSound;
	else if (EP90Pistol(Weapon).CurrentWeaponMode == 2) 
		     BallisticFireSound.Sound=SuperFireSound2;
	else
		     BallisticFireSound.Sound=default.BallisticFireSound.sound;

    if (RailPower + 0.05 >= 1 || EP90Pistol(Weapon).CurrentWeaponMode == 1 || EP90Pistol(Weapon).CurrentWeaponMode == 2)
    {
        	super.ModeDoFire();
		if (EP90Pistol(Weapon).CurrentWeaponMode == 1 && EP90Pistol(Weapon).FireCount == 3)
			EP90Pistol(Weapon).PlaySound(ExhaustSound, SLOT_Misc, 0.7, ,32);
		bIsCharging=False;
	  	RailPower=0;
    }
    else
    {
	if (!bIsCharging)
		EP90Pistol(Weapon).PlaySound(ChargeSound, SLOT_Misc, 2.5, ,64);
	bIsCharging=True;
    }

}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);
        if (bIsCharging)
        {

//            	Instigator.AmbientSound = ChargeSound;
            	RailPower = FMin(RailPower + ChargeRate*DT, 1);
		bIsFiring=true;
        }
        else
        {
//            Instigator.AmbientSound = BW.UsedAmbientSound;
        }
    
    if (RailPower + 0.05 >= 1)
    {
        	ModeDoFire();
    }

    if (!bIsFiring)
        return;

}

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	Weapon.HurtRadius(10, 92, DamageType, 1, HitLocation);
	return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}

//simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
/*{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( Weapon.bHurtEntry )
		return;

	Weapon.bHurtEntry = true;
	foreach Weapon.VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && UnrealPawn(Victim)==None && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim)
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		}
	}
	Weapon.bHurtEntry = false;
}*/

defaultproperties
{
     ChargeRate=2.250000
     SuperFireSound=Sound'PackageSounds4.EP90.EP90-Quick'
     SuperFireSound2=Sound'PackageSounds4.EP90.EP90-Quick2'
     ExhaustSound=Sound'PackageSounds4.EP90.EP90-Exhaust'
     ChargeSound=Sound'PackageSounds4.EP90.EP90-Charge'
     TraceRange=(Min=1500000.000000,Max=1500000.000000)
     MaxWallSize=64.000000
     MaxWalls=3
     Damage=(110.000000)
     DamageHead=(165.000000)
     DamageLimb=(85.000000)
     DamageType=Class'BWBPRecolorsDE.DTLS14Body'
     DamageTypeHead=Class'BWBPRecolorsDE.DTLS14Head'
     DamageTypeArm=Class'BWBPRecolorsDE.DTLS14Limb'
     KickForce=35000
     PenetrateForce=250
     bPenetrate=TrueClipFinishSound=(Sound=Sound'PackageSounds4.LS14.Gauss-LastShot',Volume=1.000000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'PackageSounds4.LS14.Gauss-Empty',Volume=1.200000)
     bDryUncock=False
     MuzzleFlashClass=class'BWBPRecolorsDE.LS14FlashEmitter'
     FlashScaleFactor=1.100000
     BrassClass=Class'BallisticDE.Brass_Pistol'
     BrassBone="tip"
	 AimedFireAnim="SightFire"
     BrassOffset=(X=-30.000000,Y=1.000000)
     RecoilPerShot=3072.000000
     VelocityRecoil=175.000000
     FireChaos=-10.000000
     XInaccuracy=2.500000
     YInaccuracy=2.500000
     BallisticFireSound=(Sound=Sound'PackageSounds4.EP90.EP90-Fire',Volume=9.500000,Slot=SLOT_Interact,bNoOverride=False)
     FireEndAnim=
     FireRate=1.200000
     TweenTime=0.000000
     AmmoClass=class'BallisticDE.Ammo_50HV'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
