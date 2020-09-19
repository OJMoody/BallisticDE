//=============================================================================
// CFSpawnKillMessageBC.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFSpawnKillMessageBC extends CFSpawnKillMessage;

var string he;
var string she;
var string her;
var string his;

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
		local string str;
		str = Repl(Default.KillString[Min(Switch,15)-1], "%X", RelatedPRI_1.PlayerName);
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
     He="he"
     She="she"
     Her="her"
     His="his"
     KillString(0)="Spawn raid: %X provided %Y first aid"
     KillString(2)="Spawn raid: %Y wasn't on %X's guestlist"
     KillString(4)="Spawn raid: %Y shouldn't have landed on %X's window bar"
     KillString(6)="Spawn raid: %X fell upon %Y like a hungry watchdog"
     KillString(8)="Spawn raid: %X smashed the molehammer into %Y's head"
     KillString(10)="Spawn raid: %Y got robbed by %X right after he spawned"
     KillString(14)="Spawn raid: %X controls the population"
     bIsSpecial=False
     bFadeMessage=False
     DrawColor=(B=211,G=85,R=186)
     PosY=0.758000
     FontSize=0
}
