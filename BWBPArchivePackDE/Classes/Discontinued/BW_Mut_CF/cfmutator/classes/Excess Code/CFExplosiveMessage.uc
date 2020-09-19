//=============================================================================
// CFExplosiveMessage.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFExplosiveMessage extends LocalMessage;

var	localized string 	KillString[15];
var name KillSoundName[15];

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
		return Default.KillString[Min(Switch,15)-1];
}

static simulated function ClientReceive(
	PlayerController P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

	if(Default.KillSoundName[Min(Switch-1,14)] != '')
		P.PlayRewardAnnouncement(Default.KillSoundName[Min(Switch-1,14)],1,true);
}

static function int GetFontSize( int Switch, PlayerReplicationInfo RelatedPRI1, PlayerReplicationInfo RelatedPRI2, PlayerReplicationInfo LocalPlayer )
{
	if ( Switch <= 3 )
		return 0;
	if ( Switch <= 7 )
		return 1;
	if( Switch <= 11 )
		return 2;

	return 3;
}

defaultproperties
{
     KillString(0)="Fire in the hole!"
     KillString(2)="Bearded bomber!"
     KillString(4)="Its whats on the inside that counts!!"
     KillString(6)="Soup kitchen!!!"
     KillString(8)="Ketchup master!!!"
     KillString(10)="F L Y I N G  L I M B S !!"
     KillString(14)="M I N C E  M A C H I N E !"
     KillSoundName(0)="'"
     KillSoundName(1)="'"
     KillSoundName(2)="'"
     KillSoundName(3)="'"
     KillSoundName(4)="'"
     KillSoundName(5)="'"
     KillSoundName(6)="'"
     KillSoundName(7)="'"
     KillSoundName(8)="'"
     KillSoundName(9)="'"
     KillSoundName(10)="HolyShit_F"
     KillSoundName(11)="'"
     KillSoundName(12)="'"
     KillSoundName(13)="'"
     KillSoundName(14)="GodLike"
     bFadeMessage=True
     DrawColor=(B=0,G=153)
     StackMode=SM_Down
     PosY=0.242000
     FontSize=1
}
