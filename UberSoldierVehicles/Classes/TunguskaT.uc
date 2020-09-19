class TunguskaT extends DKWeapons;

var     float           FireCountdownB,FireCountdownA;
var     float           AllowNextShoot;

function Tick(float Delta)
{
	local int i;
	local xPawn P;
	local vector NewDir, PawnDir;
	local coords WeaponBoneCoords;

	// elmuerte --
	// set FireCountdown to the current lowest value (for internal processing)
	// FireCountdown will be modified with the delta in the super.Tick() call
	FireCountdown = fmin(FireCountdownB, FireCountdownA);
	Super.Tick(Delta);
	// decrease counters
	if (FireCountdownB > 0)	FireCountdownB -= Delta;
	if (FireCountdownA > 0)	FireCountdownA -= Delta;
	if (AllowNextShoot > 0)	AllowNextShoot -= Delta;
	// -- elmuerte

	if ( (Role == ROLE_Authority) && (Base != None) )
	{
	    WeaponBoneCoords = GetBoneCoords(YawBone);
		NewDir = WeaponBoneCoords.XAxis;
		if ( (Vehicle(Base).Controller != None) && (NewDir.Z < 0.9) )
		{

				for ( i=0; i<Base.Attached.Length; i++ )
			{
				P = XPawn(Base.Attached[i]);
				if ( (P != None) && (P.Physics != PHYS_None) && (P != Vehicle(Base).Driver) )
				{
					PawnDir = P.Location - WeaponBoneCoords.Origin;
					PawnDir.Z = 0;
					PawnDir = Normal(PawnDir);
					if ( ((PawnDir.X <= NewDir.X) && (PawnDir.X > OldDir.X))
						|| ((PawnDir.X >= NewDir.X) && (PawnDir.X < OldDir.X)) )
					{
						if ( ((PawnDir.Y <= NewDir.Y) && (PawnDir.Y > OldDir.Y))
							|| ((PawnDir.Y >= NewDir.Y) && (PawnDir.X < OldDir.Y)) )
						{
							P.SetPhysics(PHYS_Falling);
							P.Velocity = WeaponBoneCoords.YAxis;
							if ( ((NewDir - OldDir) Dot WeaponBoneCoords.YAxis) < 0 )
								P.Velocity *= -1;
							P.Velocity = 500 * (P.Velocity + 0.3*NewDir);
							P.Velocity.Z = 200;
						}
					}
				}
			}
		}
		OldDir = NewDir;
    }
}
/*
function dualfire ()
{
	log("dualfire"@FireCountdownA@FireCountdownB);

	if (FireCountdownA <= 0 && FireCountdownB <= (FireInterval - 1.0))
	{
		CalcWeaponFire();
		if (bCorrectAim)
		if (Spread > 0)	WeaponFireRotation = rotator(vector(WeaponFireRotation) + VRand()*FRand()*Spread);
		DualFireOffset *= -1;
		Instigator.MakeNoise(1.0);
		FireCountdownA = FireInterval;
		AllowNextShoot = 0.03000;
		AimLockReleaseTime = Level.TimeSeconds + FireCountdown * FireIntervalAimLock;
	}

	if (FireCountdownB <= 0 && FireCountdownA <= (FireInterval - 1.0))
	{
		CalcWeaponFire();
		if (bCorrectAim)
		if (Spread > 0)	WeaponFireRotation = rotator(vector(WeaponFireRotation) + VRand()*FRand()*Spread);
		DualFireOffset *= -1;
		Instigator.MakeNoise(1.0);
		FireCountdownB = FireInterval;
		AllowNextShoot = 0.03000;
		AimLockReleaseTime = Level.TimeSeconds + FireCountdownB * FireIntervalAimLock;
	}

}
*/

event bool AttemptFire(Controller C, bool bAltFire)
{
  	if(Role != ROLE_Authority || bForceCenterAim)
		return False;

	// elmuerte --
	// AllowNextShoot adds a small delay between the fire of both barels
	// otherwise both will shoot at the same time and the user won't be able to
	// just fire one bare;
	if (AllowNextShoot > 0) return false;
	AllowNextShoot = 0.05; // don't hardcode
	// -- elmuerte

	if (FireCountdownA <= 0)
	{
		CalcWeaponFire();
		if (bCorrectAim)
			WeaponFireRotation = AdjustAim(bAltFire);
		if (Spread > 0)
			WeaponFireRotation = rotator(vector(WeaponFireRotation) + VRand()*FRand()*Spread);

		DualFireOffset *= -1;

		Instigator.MakeNoise(1.0);
		if (bAltFire)
		{
			FireCountdownA = AltFireInterval; //elmuerte: update counter A
			AltFire(C);
		}
		else
		{
			FireCountdownA = FireInterval; //elmuerte: update counter A
			Fire(C);
		}
		// elmuerte --
		// use the lowest of the two counters to calculate the aim lock release time
		AimLockReleaseTime = Level.TimeSeconds + fmin(FireCountdownB, FireCountdownA) * FireIntervalAimLock;
		// -- elmuerte

	    return True;
	}
	if (FireCountdownB <= 0)
	{
		CalcWeaponFire();
		if (bCorrectAim)
			WeaponFireRotation = AdjustAim(bAltFire);
		if (Spread > 0)
			WeaponFireRotation = rotator(vector(WeaponFireRotation) + VRand()*FRand()*Spread);

		DualFireOffset *= -1;

		Instigator.MakeNoise(1.0);
		if (bAltFire)
		{
			FireCountdownB = AltFireInterval; //elmuerte: update counter B
			AltFire(C);
		}
		else
		{
			FireCountdownB = FireInterval; //elmuerte: update counter B
			Fire(C);
		}
		// elmuerte --
		// use the lowest of the two counters to calculate the aim lock release time
		AimLockReleaseTime = Level.TimeSeconds + fmin(FireCountdownB, FireCountdownA) * FireIntervalAimLock;
		// -- elmuerte

	    return True;
	}


	return False;
}


simulated function float ChargeBar()
{
	return (1.0 - ((FireCountdownB) / FireInterval));
//	return (FireCountdownB);
}
function float ChargeBarA()
{
	return (1.0 - ((FireCountdownA) / FireInterval));
}
function float ChargeBarB()
{
	return (1.0 - ((FireCountdownB) / FireInterval));
}

simulated function Destroyed()
{
	super.Destroyed();
}

defaultproperties
{
     MinAim=0.100000
     YawBone="Turret"
     PitchBone="Barrel"
     PitchUpLimit=9000
     PitchDownLimit=63000
     WeaponFireAttachmentBone="Barrel"
     RotationsPerSecond=0.080000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.Tunguska.Tunguska'
     BlueSkin=Shader'DKVehiclesTex.Tunguska.Tunguska'
     FireInterval=0.200000
     FireSoundClass=Sound'BallisticSounds3.XMV-850.XMV-Fire-1'
     FireSoundVolume=255.000000
     FireSoundRadius=500.000000
     ProjectileClass=Class'UberSoldierVehicles.PROJ_TunguskaMG'
     Mesh=SkeletalMesh'DKVehiclesAnim.TunguskaT'
     Skins(0)=Shader'DKVehiclesTex.Tunguska.Tunguska'
}
