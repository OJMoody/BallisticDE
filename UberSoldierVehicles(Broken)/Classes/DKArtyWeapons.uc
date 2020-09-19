//-------------------------------------//
//  Have no experience in C++ =D       //
//  UberSoldier 2014-2019 RUSSIAN      //
//-------------------------------------//

class DKArtyWeapons extends ONSArtilleryCannon;

var vector OldDir;
var rotator OldRot;
var float MinAim;

defaultproperties
{
     FireSoundPitch=150.000000
     RotateSound=Sound'DKoppIISound.Turret.Turret_TurnA'
     bDramaticLighting=True
     bAlwaysRelevant=True
     NetUpdateFrequency=1.000000
     NetPriority=3.000000
     AmbientGlow=32
     MaxLights=24
     bCollideWhenPlacing=True
     bHardAttach=True
     bCollideActors=True
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
     bBlockProjectiles=True
     bBlockZeroExtentTraces=True
     bNetNotify=True
}
