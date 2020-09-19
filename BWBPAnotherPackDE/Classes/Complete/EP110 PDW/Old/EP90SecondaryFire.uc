//  =============================================================================
//   AH104PrimaryFire.
//  
//   Very powerful, long range bullet attack.
//  
//   You'll be attacked with bullets.
//   Hello whoever is reading this.
//  =============================================================================
class EP90SecondaryFire extends BallisticProInstantFire;

var() float 	ChargeRate;
var() Sound	ChargeSound;
var   float RailPower;
var bool	bIsCharging;
simulated event ModeDoFire()
{
    if (!AllowFire())
	  return;

    if (RailPower + 0.05 >= 1)
    {
        	super.ModeDoFire();
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


simulated function IgniteActor(Actor A)
{
	local XM84ActorCorrupt PF;
	PF = Spawn(class'XM84ActorCorrupt');
	PF.Instigator = Instigator;
	PF.Initialize(A);
}


function bool DoTazerBlurEffect(Actor Victim)
{
	local int i;
	local MRS138ViewMesser VM;

	if (Pawn(Victim) == None || Pawn(Victim).Health < 1 || Pawn(Victim).LastPainTime != Victim.level.TimeSeconds)
		return false;
	if (PlayerController(Pawn(Victim).Controller) != None)
	{
		for (i=0;i<Pawn(Victim).Controller.Attached.length;i++)
			if (MRS138ViewMesser(Pawn(Victim).Controller.Attached[i]) != None)
			{
				MRS138ViewMesser(Pawn(Victim).Controller.Attached[i]).AddImpulse();
				i=-1;
				break;
			}
		if (i != -1)
		{
			VM = Spawn(class'MRS138ViewMesser',Pawn(Victim).Controller);
			VM.SetBase(Pawn(Victim).Controller);
			VM.AddImpulse();
		}
	}
	else if (AIController(Pawn(Victim).Controller) != None)
	{
		AIController(Pawn(Victim).Controller).Startle(Weapon.Instigator);
		class'BC_BotStoopidizer'.static.DoBotStun(AIController(Pawn(Victim).Controller), 2, 5);
	}
	return false;
}

//function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
/*{
	if (xPawn(Other)!=None)
	{
		IgniteActor(Other);
	}
	super.DoDamage(Other, HitLocation, TraceStart, Dir, PenetrateCount, WallCount, WaterHitLocation);
	if ( Other.bCanBeDamaged )
	{
		DoTazerBlurEffect(Other);
	}
	if (Mover(Other) != None || Vehicle(Other) != None)
		return;
	TargetedHurtRadius(60, 256, class'DTXM84GrenadeRadius', 500, HitLocation, Other);
}*/

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	TargetedHurtRadius(60, 256, class'DTXM84GrenadeRadius', 500, HitLocation, Other);
	return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}

simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
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
			IgniteActor(Victims);
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
}

defaultproperties
{
     ChargeRate=0.750000
     ChargeSound=Sound'PackageSounds4.EP90.EP90-OverCharge'
     TraceRange=(Min=1500000.000000,Max=1500000.000000)
     MaxWallSize=64.000000
     MaxWalls=3
     Damage=(210.000000)
     DamageHead=(265.000000)
     DamageLimb=(185.000000)
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
     FireRate=2.800000
     BallisticFireSound=(Sound=Sound'PackageSounds4.EP90.EP90-Overblast',Volume=7.800000)
	 AmmoPerFire=1
     FireEndAnim=
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
