//=============================================================================
// AS50PrimaryFire.
//
// Ignites struck targets.
//=============================================================================
class MG42SecondaryFire extends BallisticProInstantFire;

event ModeDoFire()
{
    if (!AllowFire())
        return;

	BallisticMachinegun(Weapon).SetBeltVisibility(BallisticMachinegun(Weapon).MagAmmo);
	Super.ModeDoFire();
}

simulated function vector GetFireDir(out Vector StartTrace)
{
    if (BallisticTurret(Instigator) != None)
    	StartTrace = Instigator.Location + Instigator.EyePosition() + Vector(Instigator.GetViewRotation()) * 64;
	return super.GetFireDir(StartTrace);
}

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	BW.TargetedHurtRadius(5, 96, DamageType, 1, HitLocation,Pawn(Other));
	return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
    local int i;
	local AS50ActorFire Burner;
	
	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
    if (Pawn(Target) != None && Pawn(Target).Health > 0 && Vehicle(Target) == None)
	{
		for (i=0;i<Target.Attached.length;i++)
		{
			if (AS50ActorFire(Target.Attached[i])!=None)
			{
				AS50ActorFire(Target.Attached[i]).AddFuel(2);
				break;
			}
		}
		if (i>=Target.Attached.length)
		{
			Burner = Spawn(class'AS50ActorFire',Target,,Target.Location + vect(0,0,-30));
			Burner.Initialize(Target);
			if (Instigator!=None)
			{
				Burner.Instigator = Instigator;
				Burner.InstigatorController = Instigator.Controller;
			}
		}
	}
}

defaultproperties
{
     TraceRange=(Min=15000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     Damage=25.000000
     DamageHead=40.000000
     DamageLimb=25.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPArchivePackDE.DTMG42MG'
     DamageTypeHead=Class'BWBPArchivePackDE.DTMG42MGHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTMG42MG'
     KickForce=6000
     PDamageFactor=0.000000
     WallPDamageFactor=0.850000
     MuzzleFlashClass=Class'BallisticDE.M925FlashEmitter'
     BrassClass=Class'BWBPRecolorsDE.Brass_BMGInc'
     BrassBone="breach"
     BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
     RecoilPerShot=512.000000
     VelocityRecoil=255.000000
     FireChaos=1.000000
     BallisticFireSound=(Sound=SoundGroup'PackageSounds4Pro.AS50.AS50-Fire',Volume=5.100000,Slot=SLOT_Interact,bNoOverride=False)
     FireAnim="Fire"
	 AimedFireAnim="SightFireOld"
     FireEndAnim=
     FireRate=0.280000
	 AmmoPerFire=3
     AmmoClass=Class'BWBPArchivePackDE.Ammo_556mmBelt'
     ShakeRotMag=(X=450.000000,Y=64.000000)
     ShakeRotRate=(X=12400.000000,Y=12400.000000,Z=12400.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-5.500000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.250000
     BotRefireRate=0.50000
     WarnTargetPct=0.40000
     aimerror=950.000000
}
