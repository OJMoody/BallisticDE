//=============================================================================
// DTSARRifleHead.
//
// Damage type for the SAR12 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCommandoRifleHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's head was hallowed by %k's 552 Commando."
     DeathStrings(1)="%k trounced %o's head with %kh 552 Commando Rifle."
     DeathStrings(2)="%k's 552 Commando rounds snaked their way into %o's skull."
     DeathStrings(3)="%o got %vh head routed by %k's 552 Commando."
     DeathStrings(4)="%o's head was taken out by %k's 552 Commando."
     DeathStrings(5)="%k put a round through %o's head."
     EffectChance=0.500000
     bHeaddie=True
     WeaponClass=Class'BWBPArchivePackDE.CommandoAssaultRifle'
     DeathString="%o's head was hallowed by %k's 552 Commando."
     FemaleSuicide="%o routed herself."
     MaleSuicide="%o routed himself."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     VehicleDamageScaling=0.600000
}
