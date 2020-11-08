//=============================================================================
// XK2 Secondary Fire.
//
// Ice rounds. Inflict slow upon targets hit, but deal lesser damage than standard XK2 rounds.
//=============================================================================
class M575SecondaryFire extends BallisticRangeAttenFire;

var() BUtil.FullSound            IceSound;    //Crackling sound to play

simulated function ServerPlayFiring()
{
    super.ServerPlayFiring();
    if (IceSound.Sound != None)
        Weapon.PlayOwnedSound(IceSound.Sound,IceSound.Slot,IceSound.Volume,IceSound.bNoOverride,IceSound.Radius,IceSound.Pitch,IceSound.bAtten);
}

simulated function PlayFiring()
{
    super.PlayFiring();
    if (IceSound.Sound != None)
        Weapon.PlayOwnedSound(IceSound.Sound,IceSound.Slot,IceSound.Volume,IceSound.bNoOverride,IceSound.Radius,IceSound.Pitch,IceSound.bAtten);
}

simulated function bool AllowFire()
{
    if (M575Machinegun(BW).IceCharge < 1 || FireCount == 0 && M575Machinegun(BW).IceCharge < 3)
        return false;
    return Super.AllowFire();
}

function InitEffects()
{
	  if (AIController(Instigator.Controller) != None)
		    return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		    class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		    return;
	  if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
	    	return;
    if (MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);

	  if (!bBrassOnCock)
	  	  EjectBrass();
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{	
    local Inv_Slowdown Slow;

    super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);

    if (Pawn(Victim) != None && Pawn(Victim).Health > 0 && Vehicle(Victim) == None)
    {
        Slow = Inv_Slowdown(Pawn(Victim).FindInventoryType(class'Inv_Slowdown'));

        if (Slow == None)
        {
            Pawn(Victim).CreateInventory("BallisticDE.Inv_Slowdown");
            Slow = Inv_Slowdown(Pawn(Victim).FindInventoryType(class'Inv_Slowdown'));
        }

        Slow.AddSlow(0.7, 0.2);
    }
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	  M575Attachment(Weapon.ThirdPersonActor).IceUpdateHit(Other, HitLocation, HitNormal, Surf, , WaterHitLoc);
}

// Used to delay ammo consumtion
simulated event Timer()
{
    if (Weapon.Role == ROLE_Authority)
    {
        if (BW != None)
            BW.ConsumeMagAmmo(ThisModeNum,ConsumedLoad);
        else
            Weapon.ConsumeAmmo(ThisModeNum,ConsumedLoad);
        if (bPendingTryJam)
            TryJam();
    }
    M575Machinegun(BW).IceCharge--;
    ConsumedLoad=0;
}

function StopFiring()
{
	  Super.StopFiring();

	  M575Machinegun(BW).LastChargeTime = Level.TimeSeconds;
}

// Remove effects
simulated function DestroyEffects()
{
	  Super.DestroyEffects();

	  class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
}

defaultproperties
{
    CutOffDistance=2304.000000
    CutOffStartRange=1536.000000
    WallPenetrationForce=24.000000
    
    Damage=14.000000
    DamageHead=28.000000
    DamageLimb=14.000000
    RangeAtten=0.200000
    WaterRangeAtten=0.600000
    DamageType=Class'BallisticDE.DTXK2Freeze'
    DamageTypeHead=Class'BallisticDE.DTXK2Freeze'
    DamageTypeArm=Class'BallisticDE.DTXK2Freeze'
    KickForce=500
    PenetrateForce=150
    bPenetrate=True
    ClipFinishSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-2',Volume=0.800000,Radius=72.000000,bAtten=True)
    DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryPistol',Volume=0.700000)
    bDryUncock=True
	FlashBone="Muzzle"
    MuzzleFlashClass=Class'BWBPAnotherPackDE.M575FlashEmitter'
    FlashScaleFactor=0.250000
    BrassClass=Class'BallisticDE.Brass_MG'
    BrassOffset=(X=-25.000000,Z=-5.000000)
    AimedFireAnim="SightFire"
    FireRecoil=70.000000
    FireChaos=0.050000
    FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
    XInaccuracy=16.000000
    YInaccuracy=16.000000
    BallisticFireSound=(Sound=Sound'BWBPAnotherPackSounds.M575.M575-Fire',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
	IceSound=(Sound=Sound'BallisticSounds2.A42.A42-Impact',Volume=1.200000,Radius=1024.000000,Pitch=1.000000,bNoOverride=True)
    bPawnRapidFireAnim=True
    FireRate=0.090000
    AmmoClass=Class'BWBPAnotherPackDE.Ammo_556mmBelt'
    ShakeRotMag=(X=64.000000,Y=32.000000)
    ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
    ShakeRotTime=2.000000
    ShakeOffsetMag=(X=-3.000000)
    ShakeOffsetRate=(X=-1000.000000)
    ShakeOffsetTime=1.500000
}
