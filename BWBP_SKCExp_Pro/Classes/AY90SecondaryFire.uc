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
		AmmoPerFire=30;
		Load=30;
		BallisticFireSound.Sound=MaxChargeFireSound;
	}
	else if (HoldTime >= (ChargeTime/2) && AY90SkrithBoltcaster(BW).MagAmmo >= 10)
	{
		XInaccuracy=1000;
		ProjectileCount=15;
		AmmoPerFire=15;
		Load=15;
		BallisticFireSound.Sound=ChargeFireSound;
	}
	else
	{
		XInaccuracy=500;
		ProjectileCount=5;
		AmmoPerFire=5;
		Load=5;
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
	}
	
	if (!AllowFire())
        return;
    if (bIsJammed)
    {
    	if (BW.FireCount == 0)
    	{
    		bIsJammed=false;
			if (bJamWastesAmmo && Weapon.Role == ROLE_Authority)
			{
				ConsumedLoad += Load;
				Timer();
			}
	   		if (UnjamMethod == UJM_FireNextRound)
	   		{
		        NextFireTime += FireRate;
   			    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
				BW.FireCount++;
    			return;
    		}
    		if (!AllowFire())
    			return;
    	}
    	else
    	{
	        NextFireTime += FireRate;
   		    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		return;
   		}
    }

	if (BW != None)
	{
		BW.bPreventReload=true;
		BW.FireCount++;

		if (BW.ReloadState != RS_None)
		{
			if (weapon.Role == ROLE_Authority)
				BW.bServerReloading=false;
			BW.ReloadState = RS_None;
		}
	}

    if (MaxHoldTime > 0.0)
        HoldTime = FMin(HoldTime, MaxHoldTime);

	ConsumedLoad += Load;
	SetTimer(FMin(0.1, FireRate/2), false);
    // server
    if (Weapon.Role == ROLE_Authority)
    {
        //Weapon.ConsumeAmmo(ThisModeNum, Load);
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
    }
    else if (!BW.bUseNetAim && !BW.bScopeView)
    	ApplyRecoil();
	
	BW.LastFireTime = Level.TimeSeconds;

    // client
    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else // server
    {
        ServerPlayFiring();
    }

    // set the next firing time. must be careful here so client and server do not get out of sync
    if (bFireOnRelease)
    {
        if (bIsFiring)
            NextFireTime += MaxHoldTime + FireRate;
        else
            NextFireTime = Level.TimeSeconds + FireRate;
	}
	
    else if (bBurstMode)
    {
		BurstCount++;
    	if (BurstCount >= MaxBurst)
    	{
    		NextFireTime += FireRate * (1 + (MaxBurst * (1.0f - BurstFireRateFactor)));
    		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		BurstCount = 0;
    	}
    	else
    	{
    		NextFireTime += FireRate * BurstFireRateFactor;
  			NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
  		}
	}
	
    else
    {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }
	
    Load = AmmoPerFire;
    HoldTime = 0;


    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

	if (BW != None)
	{
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
		if (bCockAfterFire || (bCockAfterEmpty && BW.MagAmmo - ConsumedLoad < 1))
			BW.bNeedCock=true;
	}
	
	Weapon.AmbientSound = Weapon.default.AmbientSound;
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

/*
function SpawnProjectile (Vector Start, Rotator Dir)
{
	local int i;
	local rotator R;

    Shots = FMin(default.Shots, BW.MagAmmo);

	ConsumedLoad = (AmmoPerFire * Shots);
	for (i=0;i<Shots;i++)
	{
        R.Roll = (65536.0 / 3) * Cycle + (65536.0 / 12);
        Dir = Rotator(GetFireSpread() >> Dir);

		Proj = Spawn (ProjectileClass,,, Start, rotator((Vector(rot(0,1,0)*FireSpread) >> R) >> Dir) );
		Proj.Instigator = Instigator;

        Cycle++;
		if (Cycle > 3)
            Cycle = 1;
	}
}

// Returns normal for some random spread. This is seperate from GetFireDir for shotgun reasons mainly...
simulated function vector GetFireSpread()
{
	local float fX;
    local Rotator R;

	switch (FireSpreadMode)
	{
		case FSM_Scatter:
			fX = frand();
			R.Yaw =   XInaccuracy * (frand()*2-1) * sin(fX*1.5707963267948966);
			R.Pitch = YInaccuracy * (frand()*2-1) * cos(fX*1.5707963267948966);
			break;
		case FSM_Circle:
			fX = frand();
			R.Yaw =   XInaccuracy * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
			R.Pitch = YInaccuracy * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
			break;
		default:
			R.Yaw =   XInaccuracy * (frand()*2-1);
			R.Pitch = YInaccuracy * (frand()*2-1);
			break;
	}
	return Vector(R);
}*/

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
     ChargeSound=Sound'BWBP_SKC_Sounds.SkirthBow.SkrithBow-WaveCharge'
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
