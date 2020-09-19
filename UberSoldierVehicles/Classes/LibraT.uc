class LibraT extends DKWeapons;

var Deco_LibraTKorpus Korpus;

var FX_IspolinLightEffect Light1;
var FX_IspolinLightEffect Light2;

var     float           FireCountdownB,FireCountdownA;
var     float           AllowNextShoot;

function PostBeginPlay()
{
	super.PostBeginPlay();

         Korpus = Spawn(class'Deco_LibraTKorpus',self,, Location + (vect(0,0,0) << Rotation)); 
       AttachToBone(Korpus,'A');

         Light1 = Spawn(class'FX_IspolinLightEffect',self,,Location); 
       AttachToBone(Light1,'LightR');

         Light2 = Spawn(class'FX_IspolinLightEffect',self,,Location); 
       AttachToBone(Light2,'LightL');
}

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
		AllowNextShoot = 1.00000;
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
		AllowNextShoot = 1.00000;
		AimLockReleaseTime = Level.TimeSeconds + FireCountdownB * FireIntervalAimLock;
	}

}
*/

event bool AttemptFire(Controller C, bool bAltFire)
{
  	if(Role != ROLE_Authority || bForceCenterAim)
		return False;

	if (AllowNextShoot > 0) return false;
	AllowNextShoot = 0.25;

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

		AimLockReleaseTime = Level.TimeSeconds + fmin(FireCountdownB, FireCountdownA) * FireIntervalAimLock;


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
	    Korpus.Destroy();

	    Light1.Destroy();
	    Light2.Destroy();

	super.Destroyed();
}

defaultproperties
{
     MinAim=0.100000
     YawBone="Turret"
     PitchBone="Barrel"
     PitchUpLimit=3500
     PitchDownLimit=63000
     WeaponFireAttachmentBone="BarrelFire"
     DualFireOffset=48.000000
     RotationsPerSecond=0.150000
     Spread=0.020000
     RedSkin=Shader'DKVehiclesTex.T18.T18'
     BlueSkin=Shader'DKVehiclesTex.T18.T18'
     FireInterval=7.600000
     AltFireInterval=7.600000
     ProjectileClass=Class'UberSoldierVehicles.PROJ_LibraFG'
     AltFireProjectileClass=Class'UberSoldierVehicles.PROJ_LibraFG'
     Mesh=SkeletalMesh'DKVehiclesAnim.T18LibraT'
     Skins(0)=Shader'DKVehiclesTex.T18.T18'
     Skins(1)=Texture'DKVehiclesTex.Detail.invis'
     Skins(2)=Shader'XGameShaders.Trans.TransRing'
     Skins(3)=Shader'XGameShaders.Trans.TransRing'
}
