//=============================================================================
// CFMasochistMessage.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFMasochistMessage extends LocalMessage;

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
     KillString(0)="Unlucky wretch"
     KillString(4)="Masochist !"
     KillString(9)="Deathwish !"
     KillString(14)="F L A G E L L A T I O N !!"
     KillString(19)="P U R E  I N C O M P E T E N C E !!!"
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
     KillSoundName(14)="'"
     KillSoundName(15)="'"
     KillSoundName(16)="'"
     KillSoundName(17)="'"
     KillSoundName(18)="'"
     KillSoundName(19)="'"
     bFadeMessage=True
     DrawColor=(B=0,G=153)
     StackMode=SM_Down
     PosY=0.242000
     FontSize=1
}
