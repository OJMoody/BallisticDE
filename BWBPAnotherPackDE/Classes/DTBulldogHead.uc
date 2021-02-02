//=============================================================================
// DTBulldogHead.
//
// Damage type for the Bulldog headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBulldogHead extends DT_BWBullet;

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
     bHeaddie=True
     DeathStrings(0)="%k crushed %o's neck with a rubber slug."
     DeathStrings(1)="%k made %o choke with a huge rubber slug."
     DeathStrings(2)="%o's objections were silenced by %k's suppression cannon."
     DeathStrings(3)="%o can't cry out after taking %k's slug to the jaw."
     WeaponClass=Class'BWBPAnotherPackDE.PUGAssaultCannon'
     DeathString="%o's head got eaten by %k's Bulldog."
     FemaleSuicide="%o is tactically inept with a Bulldog."
     MaleSuicide="%o is tactically inept with a Bulldog."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
