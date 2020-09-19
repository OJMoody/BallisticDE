//=============================================================================
// DTM806PistolHead.
//
// Damage type for the M806 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTDEPistolHead extends DT_BWBullet;

// HeadShot stuff from old sniper damage ------------------
static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;

	if ( PlayerController(Killer) == None )
		return;

	PlayerController(Killer).ReceiveLocalizedMessage( Class'XGame.SpecialKillMessage', 0, Killer.PlayerReplicationInfo, None, None );
	xPRI = xPlayerReplicationInfo(Killer.PlayerReplicationInfo);
	if ( xPRI != None )
	{
		xPRI.headcount++;
		if ( (xPRI.headcount == 15) && (UnrealPlayer(Killer) != None) )
			UnrealPlayer(Killer).ClientDelayedAnnouncementNamed('HeadHunter',15);
	}
}
// --------------------------------------------------------

defaultproperties
{
     DeathStrings(0)="%o took %k's DE .50 right in the eye."
     DeathStrings(1)="%k's Desert Eagle tore %o's head right off."
     DeathStrings(2)="%k sent a .50 cal through %o's ugly mug."
     bHeaddie=True
     WeaponClass=Class'BWBPArchivePackDE.DEPistol'
     DeathString="%o took %k's DE .50 right in the eye."
     FemaleSuicide="%o peered down the barrel of her Desert Eagle."
     MaleSuicide="%o peered down the barrel of his Desert Eagle."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
}
