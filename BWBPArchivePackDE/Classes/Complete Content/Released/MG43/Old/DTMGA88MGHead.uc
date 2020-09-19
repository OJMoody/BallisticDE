//=============================================================================
// DTMGA88MGHead.
//
// Damage type for the M353 Machinegun headshot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMGA88MGHead extends DT_BWBullet;

// HeadShot stuff from old sniper damage ------------------
static function IncrementKills(Controller Killer)
{
    local xPlayerReplicationInfo xPRI;

    if ( PlayerController(Killer) == None )
        return;

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
     DeathStrings(0)="%k unleashed his beast onto %o."
     DeathStrings(1)="%k's brought %his Schwarzspecht to %Os funreal."
     DeathStrings(2)="%k's SiegHail has nailed %o into the fields of shame."
     bHeaddie=True
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBPArchivePackDE.MGA88Machinegun'
     DeathString="%k furiously machinegunned %o's head off."
     FemaleSuicide="%o shot herself in the head with the MGX4."
     MaleSuicide="%o shot himself in the head with the MGX4."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     VehicleDamageScaling=0.000000
}
