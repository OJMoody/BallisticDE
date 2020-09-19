//=============================================================================
// CFMGMessageBC.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFMGMessageBC extends CFMGMessage;

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
		local string str;
		str = Repl(Default.KillString[Min(Switch,20)-1], "%X", RelatedPRI_1.PlayerName);
		return Repl(str, "%Y", RelatedPRI_2.PlayerName);
}

static simulated function ClientReceive(
	PlayerController P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	Super(LocalMessage).ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
}

static function int GetFontSize( int Switch, PlayerReplicationInfo RelatedPRI1, PlayerReplicationInfo RelatedPRI2, PlayerReplicationInfo LocalPlayer )
{
	return 0;
}

defaultproperties
{
     KillString(4)="MG: %X used %Y as a target doll"
     KillString(9)="MG: %X remembered the nice times in the trenches of verdun"
     KillString(14)="MG: %X did it like Rambo in the jungle"
     KillString(19)="MG: %X lied as he promised to kill %Y last"
     bIsSpecial=False
     bFadeMessage=False
     DrawColor=(B=211,G=85,R=186)
     PosY=0.758000
     FontSize=0
}
