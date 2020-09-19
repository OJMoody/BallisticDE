//=============================================================================
// CFExplosiveMessageBC.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFExplosiveMessageBC extends CFExplosiveMessage;

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
     KillString(0)="Explosive: %X blew %Y out of the nest"
     KillString(2)="Explosive: %X put a turban on"
     KillString(4)="Explosive: %X knows - its on the inside that counts"
     KillString(6)="Explosive: %X has some nice soup recipes"
     KillString(8)="Explosive: %X has now enough meat for a hudge Currywurst"
     KillString(10)="Explosive: %X scatters boiled body parts all over"
     KillString(14)="Explosive: %X is a running mince machine"
     bIsSpecial=False
     bFadeMessage=False
     DrawColor=(B=211,G=85,R=186)
     PosY=0.758000
     FontSize=0
}
