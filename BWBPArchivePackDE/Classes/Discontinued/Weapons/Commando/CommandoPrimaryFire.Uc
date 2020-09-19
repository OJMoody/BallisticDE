//=============================================================================
// SARPrimaryFire.
//
// Average power, 600RpM, rifle range, low accuracy assault rifle fire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class CommandoPrimaryFire extends BallisticProInstantFire;

function PlayFiring()
{
	if (SARAssaultRifle(Weapon).bStockOpen && !SARAssaultRifle(Weapon).bStockOpenRotated)
		SARAssaultRifle(Weapon).SetStockRotation();

	super.PlayFiring();
}

//Spawn shell casing for first person
function EjectBrass()
{
	local vector Start, X, Y, Z;
	local Coords C;
	local actor BrassActor;

	if (Level.NetMode == NM_DedicatedServer)
		return;
	if (!class'BallisticMod'.default.bEjectBrass || Level.DetailMode < DM_High)
		return;
	if (BrassClass == None)
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
	if (AIController(Instigator.Controller) != None)
		return;
	C = Weapon.GetBoneCoords(BrassBone);
//	Start = C.Origin + C.XAxis * BrassOffset.X + C.YAxis * BrassOffset.Y + C.ZAxis * BrassOffset.Z;
    Weapon.GetViewAxes(X,Y,Z);
	Start = C.Origin + X * BrassOffset.X + Y * BrassOffset.Y + Z * BrassOffset.Z;
	BrassActor = Spawn(BrassClass, weapon,, Start, Rotator(C.XAxis));
	if (BrassActor != None)
	{
		BrassActor.bHidden=true;
		SARAssaultRifle(Weapon).UziBrassList.length = SARAssaultRifle(Weapon).UziBrassList.length + 1;
		SARAssaultRifle(Weapon).UziBrassList[SARAssaultRifle(Weapon).UziBrassList.length-1].Actor = BrassActor;
		SARAssaultRifle(Weapon).UziBrassList[SARAssaultRifle(Weapon).UziBrassList.length-1].KillTime = level.TimeSeconds + 0.2;
	}
}

defaultproperties
{
     TraceRange=(Min=10000.000000,Max=12000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=32.000000
     MaxWalls=3
     Damage=25.000000
     DamageHead=50.000000
     DamageLimb=15.000000
     RangeAtten=0.800000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPArchivePackDE.DTCommandoRifle'
     DamageTypeHead=Class'BWBPArchivePackDE.DTCommandoRifleHead'
     DamageTypeArm=Class'BWBPArchivePackDE.DTCommandoRifle'
     KickForce=20000
     PenetrateForce=150
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticDE.XK2FlashEmitter'
     FlashScaleFactor=2.000000
     BrassClass=Class'BWBPArchivePackDE.Brass_Commando'
     BrassBone="tip"
     BrassOffset=(X=-105.000000,Y=-10.000000,Z=-1.000000)
     RecoilPerShot=96.000000
     FireChaos=0.040000
     XInaccuracy=128.000000
     YInaccuracy=128.000000
     BallisticFireSound=(Sound=Sound'BWWeaponPack2-Sounds.DE.CommandoFire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.100000
     AmmoClass=Class'BallisticDE.Ammo_556mm'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
