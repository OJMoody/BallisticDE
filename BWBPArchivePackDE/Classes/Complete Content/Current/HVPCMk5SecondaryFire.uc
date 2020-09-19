//=============================================================================
// HVPC alt fire.
//
// Rapid fire projectiles. Overheats gun quickly.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HVPCMk5SecondaryFire extends BallisticProProjectileFire;

simulated function bool AllowFire()
{
	if ((HVPCMk5PlasmaCannon(Weapon).HeatLevel >= 10.50) || HVPCMk5PlasmaCannon(Weapon).bIsVenting || !super.AllowFire())
		return false;
	return true;
}

function PlayFiring()
{
	Super.PlayFiring();
	HVPCMk5PlasmaCannon(BW).AddHeat(0.45);
}


function DoFireEffect()
{

	Super.DoFireEffect();
	if (level.Netmode == NM_DedicatedServer)
		HVPCMk5PlasmaCannon(Weapon).AddHeat(0.45);
}

defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BWBPArchivePackDE.A48FlashEmitter'
     RecoilPerShot=100.000000
     FireChaos=0.400000
     XInaccuracy=16.000000
     YInaccuracy=16.000000
     BallisticFireSound=(Sound=Sound'PackageSoundsArchive4.XavPlas.Xav-FireAlt',Volume=2.000000,Slot=SLOT_Interact,bNoOverride=False)
     FireAnim="Fire2"
     FireEndAnim=
     FireRate=0.160000
     AmmoClass=Class'BWBPArchivePackDE.Ammo_HVPCCells'
     ShakeRotMag=(X=16.000000,Y=4.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-4.000000)
     ShakeOffsetRate=(X=-1200.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBPArchivePackDE.HVPCMk5ProjectileSmall'
     WarnTargetPct=0.200000
}
