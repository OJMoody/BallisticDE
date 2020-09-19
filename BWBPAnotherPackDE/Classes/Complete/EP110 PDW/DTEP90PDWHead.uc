//=============================================================================
// DTM806PistolHead.
//
// Damage type for the M806 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTEP90PDWHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's mind and brains were blown with %k's EP110."
     DeathStrings(1)="%k made room in %o's skull for some EP110 bullets."
	 DeathStrings(2)="%o couldn’t take the mind altering weapon that %k had."
	 DeathStrings(3)="%k gave %o a lethal form of DMT with a headshot."
	 DeathStrings(4)="%o's gray matter was forever scrambled by %k's EP110."
	 DeathStrings(5)="%k showed %o who had the superior mind melter."
     bHeaddie=True
     WeaponClass=Class'BWBPAnotherPackDE.EP90PDW'
     DeathString="%o was decapitated by %k with the EP110."
     FemaleSuicide="%o peered down the barrel of her EP110."
     MaleSuicide="%o peered down the barrel of his EP110."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
}
