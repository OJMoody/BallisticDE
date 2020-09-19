//  =============================================================================
//   PUGPrimaryFire.
//  
//   Rapid fire, but weak rubber shot spread
//   Shoots 4 pellets for 25. Pellets slow down targets.
//
//   Copyright 3053 Sergeant Kelly. ALL RIGHTS RESERVED BRAH.
//  =============================================================================
class PUGPrimaryFire extends BallisticRangeAttenFire;
var() class<actor>			AltBrassClass1;			//Alternate Fire's brass
var() class<actor>			AltBrassClass2;			//Alternate Fire's brass (whole FRAG-12)

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

//Spawn shell casing for first person
function EjectFRAGBrass()
{
	local vector Start, X, Y, Z;
	local Coords C;

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
	Spawn(AltBrassClass2, weapon,, Start, Rotator(C.XAxis));
}

defaultproperties
{
     CutOffDistance=12000.000000
     CutOffStartRange=8000.000000
	 AltBrassClass1=Class'BWBPAnotherPackDE.Brass_FRAGSpent'
     AltBrassClass2=Class'BWBPAnotherPackDE.Brass_FRAG'
	 TraceRange=(Min=15000.000000,Max=30000.000000)
     WaterRangeFactor=0.900000
     Damage=55
     DamageHead=82
     DamageLimb=48
     RangeAtten=0.400000
     WaterRangeAtten=0.600000
     DamageType=Class'BWBPAnotherPackDE.DTBulldog'
     DamageTypeHead=Class'BWBPAnotherPackDE.DTBulldogHead'
     DamageTypeArm=Class'BWBPAnotherPackDE.DTBulldog'
     KickForce=35000
     HookStopFactor=0.200000
     HookPullForce=-10.000000
     PenetrateForce=250
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     bDryUncock=True
     MuzzleFlashClass=Class'BWBPAnotherPackDE.PUGFlashEmitter'
     FlashScaleFactor=0.050000
     BrassClass=Class'BWBPAnotherPackDE.Brass_BOLT'
     BrassOffset=(X=-30.000000,Y=1.000000)
     RecoilPerShot=512.000000
     VelocityRecoil=200.000000
     XInaccuracy=128.000000
     YInaccuracy=128.000000
	 FireChaos=0.500000
     BallisticFireSound=(Sound=Sound'BWBPAnotherPackSounds.PUG.PUG-Fire',Volume=7.500000)
     AimedFireAnim="SightFire"
	 FireAnim="Fire"
	 FireEndAnim=
     FireAnimRate=1.300000
     FireRate=0.300000
     AmmoClass=Class'BWBPAnotherPackDE.Ammo_10GaugeDart'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
