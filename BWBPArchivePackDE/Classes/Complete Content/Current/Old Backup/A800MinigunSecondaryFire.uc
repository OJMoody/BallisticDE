class A800MinigunSecondaryFire extends BallisticProProjectileFire;

var rotator OldLookDir, TurnVelocity;
var float	LastFireTime, MuzzleBTime, MuzzleCTime, OldFireRate;
var A800SkrithMinigun Minigun;

var float	LagTime;

var	int		ProjectileCount;

var bool	bStarted;

var float	NextTVUpdateTime;


//Do the spread on the client side
function PlayFiring()
{
	super.PlayFiring();

	if (!bStarted)
	{
		bStarted = true;
		BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		BW.PlaySound(Minigun.BarrelStartSound, SLOT_None, 0.5, , 32, 1.0, true);
	}
}

function ServerPlayFiring()
{
	super.ServerPlayFiring();
	
	if (!bStarted)
	{
		bStarted = true;
		BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		BW.PlayOwnedSound(Minigun.BarrelStartSound, SLOT_None, 0.5, , 32, 1.0, true);
	}
}

function StopFiring()
{
	super.StopFiring();
	bStarted = false;
}

simulated event PostBeginPlay()
{
	OldLookDir = BW.GetPlayerAim();

	super.PostBeginPlay();
}

defaultproperties
{
     SpawnOffset=(X=400.000000,Y=7.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BWBPArchivePackDE.A73FlashEmitter'
     FlashScaleFactor=0.800000
     RecoilPerShot=300.000000
     VelocityRecoil=150.000000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
	 FireChaos=0.9
     BallisticFireSound=(Sound=Sound'PackageSounds4.A73E.A73E-Power',Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     TweenTime=0.000000
     FireRate=0.800000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_A800Cells'
     AmmoPerFire=15
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-10.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBPArchivePackDE.A73NewPowerProjectile'
     WarnTargetPct=0.200000
	 FireLoopAnim='StillFrame'
	 FireEndAnim='StillFrame'
}
