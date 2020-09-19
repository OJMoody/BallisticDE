//=============================================================================
// CFBluntMessage.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFBluntMessage extends LocalMessage;

#exec OBJ LOAD File=CFMutatorSnd.uax

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

	if(Switch -1 == 14)
	{
		P.LastPlaySound = P.Level.TimeSeconds;  // so voice messages won't overlap
		P.LastPlaySpeech = P.Level.TimeSeconds;	// don't want chatter to overlap announcements

		P.ClientPlaySound(Sound'CFMutatorSnd.Reward.CantTouchThis', true, FClamp(0.1 + float(P.AnnouncerVolume)*2.0,0.2,2.0), SLOT_Interface);
	}
	else if(Default.KillSoundName[Min(Switch-1,14)] != '')
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
     KillString(0)="Nudge!"
     KillString(2)="Bruiser!"
     KillString(4)="Gobsmacker!!"
     KillString(6)="Police violence!!!"
     KillString(8)="Meat knocker!!!"
     KillString(10)="M O B  J U S T I C E !!"
     KillString(14)="H A M M E R  T I M E !"
     KillSoundName(0)="one"
     KillSoundName(1)="two"
     KillSoundName(2)="three"
     KillSoundName(3)="four"
     KillSoundName(4)="five"
     KillSoundName(5)="six"
     KillSoundName(6)="seven"
     KillSoundName(7)="eight"
     KillSoundName(8)="nine"
     KillSoundName(9)="ten"
     KillSoundName(10)="HolyShit_F"
     KillSoundName(11)="'"
     KillSoundName(12)="'"
     KillSoundName(13)="'"
     KillSoundName(14)="'"
     bFadeMessage=True
     DrawColor=(B=0,G=153)
     StackMode=SM_Down
     PosY=0.242000
     FontSize=1
}
