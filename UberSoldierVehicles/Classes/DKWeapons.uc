//-------------------------------------//
//  Have no experience in C++ =D       //
//  UberSoldier 2014-2019 RUSSIAN      //
//-------------------------------------//

class DKWeapons extends ONSLinkableWeapon;

var vector OldDir;
var rotator OldRot;
var float MinAim;
var class<Projectile> TeamProjectileClasses[2];

simulated function byte BestMode()
{
	local bot B;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return 1;

	if ( (Vehicle(B.Enemy) != None)
	     && (B.Enemy.bCanFly || B.Enemy.IsA('ONSWheeledCraft')) )
		return 1;

	if ( (Vehicle(B.Enemy) != None)
	     && (B.Enemy.bCanFly || B.Enemy.IsA('ONSChopperCraft')) )
		return 1;

	if ( (Vehicle(B.Enemy) != None)
	     && (B.Enemy.bCanFly || B.Enemy.IsA('UnrealPawn')) )
		return 1;
}

simulated event Destroyed()
{
	Super.Destroyed();
}

defaultproperties
{
     FireSoundPitch=150.000000
     RotateSound=Sound'DKoppIISound.Turret.Turret_TurnA'
     AIInfo(0)=(bTrySplash=True,bLeadTarget=True,WarnTargetPct=0.750000,RefireRate=1.000000)
     AIInfo(1)=(bTrySplash=True,bLeadTarget=True,WarnTargetPct=0.750000,RefireRate=1.000000)
     bDramaticLighting=True
     bAlwaysRelevant=True
     NetUpdateFrequency=1.000000
     NetPriority=3.000000
     AmbientGlow=32
     MaxLights=24
     bShadowCast=True
     bCollideWhenPlacing=True
     bHardAttach=True
     bCollideActors=True
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
     bBlockProjectiles=True
     bProjTarget=True
     bBlockZeroExtentTraces=True
     bBlockNonZeroExtentTraces=True
     bNetNotify=True
}
