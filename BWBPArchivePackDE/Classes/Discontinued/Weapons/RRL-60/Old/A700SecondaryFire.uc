//=============================================================================
// G5PrimaryFire.
//
// Rocket launching primary fire for G5
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A700SecondaryFire extends A700RedeemerFire;//BallisticGuidedFire;

var() class<Actor>	HatchSmokeClass;
var   Actor			HatchSmoke;
var() Sound			SteamSound;

simulated function bool AllowFire()
{
    return Super.AllowFire();
}

simulated event ModeDoFire()
{
    if (!AllowFire())
        return;

	if (class'BallisticReplicationInfo'.default.bNoReloading && BW.AmmoAmount(0) > 1)
		Weapon.SetBoneScale (0, 1.0, 'RocketBone');
	else if (BW.MagAmmo < 2)
		Weapon.SetBoneScale (0, 0.0, 'RocketBone');
	Super.ModeDoFire();
}

function Projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local A700RocketGuided Warhead;
	local PlayerController Possessor;
	
    Warhead = Weapon.Spawn(class'BWBPArchivePackDE.A700RocketGuided', Instigator,, Start, Dir);
    if (Warhead == None)
		Warhead = Weapon.Spawn(class'BWBPArchivePackDE.A700RocketGuided', Instigator,, Instigator.Location, Dir);
    if (Warhead != None)
    {
		Warhead.OldPawn = Instigator;
		Warhead.PlaySound(FireSound);
		Possessor = PlayerController(Instigator.Controller);
		log("Possessor is: "$Possessor);
		Possessor.bAltFire = 0;
		if ( Possessor != None )
		{
			log("In Possessor != None");
			//if ( Instigator.InCurrentCombo() )
			//	Possessor.Adrenaline = 0;
			Possessor.UnPossess();
			Instigator.SetOwner(Possessor);
			Instigator.PlayerReplicationInfo = Possessor.PlayerReplicationInfo;
			Possessor.Possess(Warhead);
			log("Warhead Controller is: "$Warhead.Controller);

			log("Wardhead mesh is: "$Warhead.StaticMesh);
		}
		Warhead.Velocity = Warhead.AirSpeed * Vector(Warhead.Rotation);
		Warhead.Acceleration = Warhead.Velocity;
		WarHead.MyTeam = Possessor.PlayerReplicationInfo.Team;
		Warhead.StartRocket();
    }
    else 
    {
	 	Weapon.Spawn(class'IE_A700RocketExplodeR');	
		Weapon.HurtRadius(180, 350, class'DTA700RocketRadius', 100000, Instigator.Location);
	}

	bIsFiring = false;
    StopFiring();
    return None;
}

defaultproperties
{
     HatchSmokeClass=Class'BallisticDE.G5HatchEmitter'
     SteamSound=Sound'BallisticSounds2.G5.G5-Steam'
     ScopeDownOn=SDO_Fire
     FireEndAnim=
     TweenTime=0.000000
     FireRate=0.800000
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetTime=2.500000
     WarnTargetPct=0.300000
}
