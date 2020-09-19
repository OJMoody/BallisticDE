//=============================================================================
// CFMGMessage.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFMGMessage extends LocalMessage;

var	localized string 	KillString[20];
var name KillSoundName[20];

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
		return Default.KillString[Min(Switch,20)-1];
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

	if(Default.KillSoundName[Min(Switch-1,19)] != '')
	{
		P.PlayRewardAnnouncement(Default.KillSoundName[Min(Switch-1,19)],1,true);
	}
}

static function int GetFontSize( int Switch, PlayerReplicationInfo RelatedPRI1, PlayerReplicationInfo RelatedPRI2, PlayerReplicationInfo LocalPlayer )
{
	if ( Switch <= 4 )
		return 0;
	if ( Switch <= 9 )
		return 1;
	if( Switch <= 14 )
		return 2;

	return 3;
}

defaultproperties
{
     KillString(4)="Target Practice"
     KillString(9)="Just 08-15!"
     KillString(14)="S T A L L O W N A G E !!"
     KillString(19)="C O M M A N D O  8 4 !!!"
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
     KillSoundName(10)="'"
     KillSoundName(11)="'"
     KillSoundName(12)="'"
     KillSoundName(13)="'"
     KillSoundName(14)="SKAARJslaughter"
     KillSoundName(15)="'"
     KillSoundName(16)="'"
     KillSoundName(17)="'"
     KillSoundName(18)="'"
     KillSoundName(19)="SKAARJtermination"
     bFadeMessage=True
     DrawColor=(B=0,G=153)
     StackMode=SM_Down
     PosY=0.242000
     FontSize=1
}
