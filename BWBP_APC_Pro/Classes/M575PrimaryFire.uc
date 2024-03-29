//=============================================================================
// M575PrimaryFire.
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
class M575PrimaryFire extends BallisticRangeAttenFire;

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

defaultproperties
{
	 CutOffDistance=4096
	 CutOffStartRange=2560
	 RangeAtten=0.35
     TraceRange=(Min=15000.000000,Max=15000.000000)
     WallPenetrationForce=24.000000
     
     Damage=20.000000
	 
     WaterRangeAtten=0.800000
     DamageType=Class'BWBP_APC_Pro.DTM575MG'
     DamageTypeHead=Class'BWBP_APC_Pro.DTM575MGHead'
     DamageTypeArm=Class'BWBP_APC_Pro.DTM575MG'
     KickForce=2000
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBP_APC_Pro.M575FlashEmitter'
	 FlashBone="tip"
     FlashScaleFactor=0.300000
     BrassClass=Class'BallisticProV55.Brass_MG'
     BrassOffset=(X=6.000000,Y=10.000000)
     AimedFireAnim="SightFire"
     FireRecoil=80.000000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=16.000000
     YInaccuracy=16.000000
     BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.082000
     AmmoClass=Class'BWBP_APC_Pro.Ammo_556mmBelt'
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-10.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
