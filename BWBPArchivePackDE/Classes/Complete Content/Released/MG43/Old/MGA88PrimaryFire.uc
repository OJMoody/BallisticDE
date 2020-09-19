//=============================================================================
// MGA88PrimaryFire.
//
// Extremely automatic, bullet style instant hit. Shots are long ranged,
// powerful and sort of accurate when gun is mountued and used carefully.
// Accuracy decreases very quickly especially if player is moving and the
// ridiculous fire rate makes it even worse. Mounting the gun can solve the
// problem though.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MGA88PrimaryFire extends BallisticProInstantFire;

event ModeDoFire()
{
    if (!AllowFire())
        return;

    BallisticMachinegun(Weapon).SetBeltVisibility(BallisticMachinegun(Weapon).MagAmmo);
    Super.ModeDoFire();
}

defaultproperties
{
     TraceRange=(Min=12000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=32.000000
     MaxWalls=2
     Damage=30.000000
     DamageHead=60.000000
     DamageLimb=24.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPArchivePackDE.DTMGA88MG'
     DamageTypeHead=Class'BWBPArchivePackDE.DTMGA88MGHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTMGA88MG'
     KickForce=10000
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticDE.M353FlashEmitter'
     FlashScaleFactor=1.200000
     BrassClass=Class'BallisticDE.Brass_MG'
     BrassOffset=(X=6.000000,Y=10.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=64.000000
     XInaccuracy=2.000000
     YInaccuracy=2.000000
     BallisticFireSound=(Sound=Sound'BWBPArchivePackSounds.MGA88.MGA88-FireNew',Volume=1.000000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.110000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_792mmBelt'
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-10.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
