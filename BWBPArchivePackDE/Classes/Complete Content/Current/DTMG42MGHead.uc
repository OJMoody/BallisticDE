//=============================================================================
// DTMG42MGHead.
//
// Damage type for the MG42 Machinegun headshot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMG42MGHead extends DT_BWBullet;

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
     DeathStrings(0)="%k headshotted %o like it was 1999."
     DeathStrings(1)="%o's head bursted into bits by %k's MG43."
     DeathStrings(2)="%k turned %o's brains into burger meat with the MG43."
	 DeathStrings(3)="%o couldn’t headbutt all of %k's lead and died."
	 DeathStrings(4)="%k got an old school headshot on %o."
	 DeathStrings(5)="%o swallowed %k's MG43 bullets."
     bHeaddie=True
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBPArchivePackDE.MG42Machinegun'
     DeathString="%k furiously machinegunned %o's head off."
     FemaleSuicide="%o shot herself in the head with the MG43."
     MaleSuicide="%o shot himself in the head with the MG43."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
}
