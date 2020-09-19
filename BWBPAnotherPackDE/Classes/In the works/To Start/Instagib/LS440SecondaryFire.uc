//=============================================================================
// LS440SecondaryFire.
//
// Death super laser. Is actually primary fire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class LS440SecondaryFire extends BallisticProInstantFire;


var() Actor						MuzzleFlash2;
var   bool						bSecondBarrel;

function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	super.DoDamage(Other, HitLocation, TraceStart, Dir, PenetrateCount, WallCount, WaterHitLocation);
	if (Mover(Other) != None || Vehicle(Other) != None)
		return;
	LS440Instagib(BW).TargetedHurtRadius(50, 96, class'DTLS440Body', 0, HitLocation, Pawn(Other));
}

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	Weapon.HurtRadius(50, 96, DamageType, 0, HitLocation);
	return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}

function FlashMuzzleFlash()
{
	local Coords C;
	local vector Start, X, Y, Z;

    	if ((Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

    	if (bSecondBarrel && MuzzleFlash2 != None) //Checks to alternate
    	{
		C = Weapon.GetBoneCoords('tip2');
        	MuzzleFlash2.Trigger(Weapon, Instigator);
    	}
    	else if (MuzzleFlash != None)
    	{
		C = Weapon.GetBoneCoords('tip');
        	MuzzleFlash.Trigger(Weapon, Instigator);
    	}

    	if (!class'BallisticMod'.default.bMuzzleSmoke)
    		return;
    	Weapon.GetViewAxes(X,Y,Z);
	Start = C.Origin + X * -180 + Y * 3;
}

defaultproperties
{
     TraceRange=(Min=1500000.000000,Max=1500000.000000)
     MaxWallSize=64.000000
     MaxWalls=3
	 XInaccuracy=96
	 YInaccuracy=96
     Damage=10000.000000
     DamageHead=10000.000000
     DamageLimb=10000.000000
     DamageType=Class'BWBPArchivePackPro2.DTInstagib'
     DamageTypeHead=Class'BWBPArchivePackPro2.DTInstagib'
     DamageTypeArm=Class'BWBPArchivePackPro2.DTInstagib'
     KickForce=25000
     PenetrateForce=500
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'PackageSounds4.LS14.Gauss-LastShot',Volume=1.000000,Radius=48.000000,bAtten=True)
     MuzzleFlashClass=Class'BWBPArchivePackPro2.A48FlashEmitter'
     FlashScaleFactor=0.400000
     RecoilPerShot=100.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4.LS14.Gauss-FireInstagib',Volume=2.000000)
     FireAnim="FireBig"
     FireEndAnim=
     TweenTime=0.000000
     FireRate=1.75
     AmmoClass=Class'BWBPArchivePackPro2.Ammo_HVPCCells'
     AmmoPerFire=25
     ShakeRotMag=(X=200.000000,Y=16.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=-2.500000)
     ShakeOffsetRate=(X=-500.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=1.050000
     WarnTargetPct=0.050000
     aimerror=800.000000
}
