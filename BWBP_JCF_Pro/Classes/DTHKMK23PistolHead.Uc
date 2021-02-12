//=============================================================================
// DTGRS9PistolHead.
//
// Damage type for GRS9 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHKMK23PistolHead extends DT_BWBullet;

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
     DeathStrings(0)="%k put %kh MK23 to %o's temple and fired."
     DeathStrings(1)="%k's HK MK23 delivered a .45 to %o's smiling face."
     DeathStrings(2)="%o took %k's Mark 23 .45 to the head and went silent."
     DeathStrings(3)="%k put a .45 through the back of %o's head."
     bHeaddie=True
     WeaponClass=Class'BWBP_JCF_Pro.HKMK23Pistol'
     DeathString="%k put %kh MK23 to %o's temple and fired."
     FemaleSuicide="%o litigated her own head off."
     MaleSuicide="%o litigated his own head off."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
