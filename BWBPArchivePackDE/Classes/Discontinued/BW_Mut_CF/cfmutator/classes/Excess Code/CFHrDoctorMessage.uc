//=============================================================================
// CFHrDoctorMessage.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFHrDoctorMessage extends LocalMessage;

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
     KillString(0)="Minor Cut!"
     KillString(2)="Autopsy!"
     KillString(4)="Sliced Bacon Bits!!"
     KillString(6)="Samurai!!!"
     KillString(8)="Butcher of Innocence!!!"
     KillString(10)="H E R R  D O C T O R !!"
     KillString(14)="S O N  O F  T Y R !"
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
     KillSoundName(14)="GodLike"
     bFadeMessage=True
     DrawColor=(B=0,G=153)
     StackMode=SM_Down
     PosY=0.242000
     FontSize=1
}
