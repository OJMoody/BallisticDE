//=============================================================================
// N3X Fists Primary.
//
// Rapid, two handed jabs with reasonable range. Everything is timed by notifys
// from the anims
//
// by Casey "Xavious" Johnson and Azarael
//=============================================================================
class N3XPlazPrimaryFire extends BallisticMeleeFire;

var bool bPunchLeft;
var BUtil.FullSound DischargedFireSound;

event ModeDoFire()
{
	local float f;

	Super.ModeDoFire();

	f = FRand();
	if (f > 0.50)
	{
		if (bPunchLeft)
			FireAnim = 'Chop3';
		else
			FireAnim = 'Chop4';		
	}
	else
	{
		if (bPunchLeft)
			FireAnim = 'Chop1';
		else
			FireAnim = 'Chop2';	
	}

	if (bPunchLeft)
		bPunchLeft=False;
	else
		bPunchLeft=True;	
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (N3XPlaz(BW).bDischarged)
		Weapon.PlayOwnedSound(DischargedFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
}

//Do the spread on the client side
function PlayFiring()
{		
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (N3XPlaz(BW).bDischarged)
			Weapon.PlayOwnedSound(DischargedFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

simulated function bool HasAmmo()
{
	return true;
}

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	local int PrevHealth;
	local BallisticPawn BPawn;

	if (Mover(Target) != None || Vehicle(Target) != None)
		return;

	BPawn = BallisticPawn(Target);

	if(IsValidHealTarget(BPawn))
	{
		if (N3XPlaz(BW).ElectroCharge >= 30)
		{
			PrevHealth = BPawn.Health;
			BPawn.GiveAttributedHealth(15, BPawn.HealthMax, Instigator);
			N3XPlaz(Weapon).PointsHealed += BPawn.Health - PrevHealth;
			N3XPlaz(BW).ElectroCharge -= 30;
			N3XPlaz(BW).LastRegen = Level.TimeSeconds + 0.5;
		}
		return;
	}

	if (N3XPlaz(Weapon).ElectroCharge < 15)
		Damage /= 3;

	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (N3XPlaz(BW).ElectroCharge >= 30)
		N3XPlaz(BW).ElectroCharge -= 30;

	N3XPlaz(BW).LastRegen = Level.TimeSeconds + 0.5;
}

function bool IsValidHealTarget(Pawn Target)
{
	if(Target==None||Target==Instigator)
		return false;

	if(Target.Health<=0)
		return false;
	
	if (!Target.bProjTarget)
		return false;

	if(!Level.Game.bTeamGame)
		return false;

	if(Vehicle(Target)!=None)
		return false;

	return (Target.Controller!=None && Instigator.Controller.SameTeamAs(Target.Controller));
}

defaultproperties
{
     DischargedFireSound=(Sound=Sound'BallisticSounds3.M763.M763Swing',Radius=32.000000,bAtten=True)
     FatiguePerStrike=0.015000
     Damage=80.000000
     DamageHead=80.000000
     DamageLimb=80.000000
     DamageType=Class'BWBPArchivePackDE.DTShockN3X'
     DamageTypeHead=Class'BWBPArchivePackDE.DTShockN3X'
     DamageTypeArm=Class'BWBPArchivePackDE.DTShockN3X'
     KickForce=20000
     bUseWeaponMag=False
     BallisticFireSound=(Sound=SoundGroup'PackageSoundsArchive4.NEX.NEX-Slash',Radius=32.000000,bAtten=True)
     bAISilent=True
     FireAnim="Chop3"
     FireAnimRate=1.650000
     FireRate=0.600000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_N3XCharge'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=384.000000)
     ShakeRotRate=(X=3500.000000,Y=3500.000000,Z=3500.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
