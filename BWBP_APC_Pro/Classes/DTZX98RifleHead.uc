//=============================================================================
// DTZX98RifleHead.
//
// Damage type for the CYLO headshots
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTZX98RifleHead extends DT_BWBullet;

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
     DeathStrings(0)="%k badgered %o's head off."
     DeathStrings(1)="%k put a bullet in %o's head with his CYLO."
     DeathStrings(2)="%k's CYLO rounds badgered their way into %o's skull."
     DeathStrings(3)="%o got %vh head routed by %k's CYLO."
     DeathStrings(4)="%o's head was taken out by %k's CYLO."
     DeathStrings(5)="%k put a round through %o's head."
     EffectChance=0.500000
     bHeaddie=True
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_APC_Pro.ZX98AssaultRifle'
     DeathString="%k badgered %o's head off."
     FemaleSuicide="%o routed herself."
     MaleSuicide="%o routed himself."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
