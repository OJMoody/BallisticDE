//=============================================================================
// CFMasochistMessageBC.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFMasochistMessageBC extends CFMasochistMessage;

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
		local string str;
		str = Repl(Default.KillString[Min(Switch,20)-1], "%X", RelatedPRI_1.PlayerName);
		return str;
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
     KillString(0)="Suicide: %X is an unlucky wretch as he glamourful failed"
     KillString(4)="Suicide: %X likes the pain"
     KillString(9)="Suicide: %X once more expressed his deathwish"
     KillString(14)="Suicide: %X flagellates his sinful flesh"
     KillString(19)="Suicide: %X is an expression of pure incompetence"
     bIsSpecial=False
     bFadeMessage=False
     DrawColor=(B=211,G=85,R=186)
     PosY=0.758000
     FontSize=0
}
