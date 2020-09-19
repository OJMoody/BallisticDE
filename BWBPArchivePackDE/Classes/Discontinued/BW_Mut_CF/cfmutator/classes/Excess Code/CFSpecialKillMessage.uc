//=============================================================================
// CFSpecialKillMessage.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFSpecialKillMessage extends SpecialKillMessage;

static simulated function ClientReceive(
	PlayerController P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	//local HudBase.HudLocalizedMessage LocalMessages[8];
 	// get access to hud

	//LocalMessages = HudBase(P.myHUD).LocalMessages;

 	// check if message is in the message stack
//	for( i = 0; i < ArrayCount(HudBase(P.myHUD).LocalMessages); i++ )
//	{
		//log("sdgbrfgn");

		/*
		    if( P.myHUD.LocalMessages[i].Message == None )
				continue;

		    if( P.myHUD.LocalMessages[i].Message == Message )
				break;
		*/
//	}
//	s = HudBase(P.myHUD).static.LocalMessages[1].StringMessage;

	// then dont display this message after all

	Super(LocalMessage).ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

	/*if(OptionalObject.ClassIsChildOf(OptionalObject, class'BallisticV25.DT_BWBullet'))
		P.PlayRewardAnnouncement('HeadShot',1);*/
}

defaultproperties
{
     DecapitationString="Custom Head Shot!!"
}
