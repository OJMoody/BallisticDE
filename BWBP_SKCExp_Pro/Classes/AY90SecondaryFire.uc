//=============================================================================
// Longhorn secondary fire
//
// Sprays clusters of death in a similar manner to a shotgun
//
// by Casey "The Xavious" Johnson
//=============================================================================
class AY90SecondaryFire extends BallisticProjectileFire;
var() float ChargeTime;
var() Sound	ChargeSound;
var() float AutoFireTime;

var() sound		ChargeFireSound;
var() sound		MaxChargeFireSound;

var byte ProjectileCount;

simulated function PlayPreFire()
{
	Weapon.AmbientSound = ChargeSound;
	//if (!BW.bScopeView)
		BW.SafeLoopAnim('PreFire', 0.15, TweenTime, ,"IDLE");
}

simulated event ModeDoFire()
{
	
	if (HoldTime >= ChargeTime && AY90SkrithBoltcaster(BW).MagAmmo >= 20)
	{
		XInaccuracy=2000;
		ProjectileCount=30;
//		AmmoPerFire=30;
		BallisticFireSound.Sound=MaxChargeFireSound;
	}
	else if (HoldTime >= (ChargeTime/2) && AY90SkrithBoltcaster(BW).MagAmmo >= 10)
	{
		XInaccuracy=1000;
		ProjectileCount=15;
//		AmmoPerFire=15;
		BallisticFireSound.Sound=ChargeFireSound;
	}
	else
	{
		XInaccuracy=500;
		ProjectileCount=5;
//		AmmoPerFire=default.AmmoPerFire;
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
	}
	
	Weapon.AmbientSound = None;
	super.ModeDoFire();
}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);

    if (bIsFiring && HoldTime >= AutoFireTime)
    {
        Weapon.StopFire(ThisModeNum);
		Weapon.AmbientSound = None;
    }
}

// Get aim then spawn projectile
function DoFireEffect()
{
    local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
    local Rotator Aim;
	local actor Other;
	local int i;

    Weapon.GetViewAxes(X,Y,Z);
    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();

    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    if(!Weapon.WeaponCentered())
	    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

	for(i=0; i < (ProjectileCount-1); i++)
	{
		Aim = GetFireAim(StartTrace);
		Aim = Rotator(GetFireSpread() >> Aim);

		End = Start + (Vector(Aim)*MaxRange());
		Other = Trace (HitLocation, HitNormal, End, Start, true);

		if (Other != None)
			Aim = Rotator(HitLocation-StartTrace);

		SpawnProjectile(StartTrace, Aim);
	}

	SendFireEffect(none, vect(0,0,0), StartTrace, 0);
	Super.DoFireEffect();
}

defaultproperties
{
     ChargeTime=4.000000
     AutoFireTime=5.000000
     ChargeSound=Sound'BWBP_SKC_Sounds.SkirthBow.SkrithBow-BlastCharge'
     ChargeFireSound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-WaveBlast'
     MaxChargeFireSound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-WaveBlastMax'
	 bFireOnRelease=True
	 ProjectileClass=Class'AY90Projectile'
     ProjectileCount=5
	 AmmoPerFire=5
    // FireRate=1.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.SkirthBow.SkrithBow-WaveFire',Volume=1.700000)
    // XInaccuracy=2000
     //YInaccuracy=10
    // VelocityRecoil=800.000000
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
     FireSpreadMode=FSM_Circle
}
