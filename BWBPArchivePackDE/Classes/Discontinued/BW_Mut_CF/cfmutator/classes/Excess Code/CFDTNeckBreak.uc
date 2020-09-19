//=============================================================================
// CFDTNeckBreak.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFDTNeckBreak extends DamageType;

var class<LocalMessage> KillerMessage;

static function IncrementKills(Controller Killer)
{
	if ( PlayerController(Killer) == None )
		return;

	PlayerController(Killer).ReceiveLocalizedMessage( Default.KillerMessage, 0, Killer.PlayerReplicationInfo, None, None );
}

defaultproperties
{
     KillerMessage=Class'cfmutator.CFSpineTapMessage'
     DeathString="%k snapped %o's pencil neck like a twig."
     bSpecial=True
     bCausesBlood=False
}
