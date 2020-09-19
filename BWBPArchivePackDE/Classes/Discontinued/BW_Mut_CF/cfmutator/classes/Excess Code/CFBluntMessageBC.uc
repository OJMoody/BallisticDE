//=============================================================================
// CFBluntMessageBC.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFBluntMessageBC extends CFBluntMessage;

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

		if(Switch -1 == 6)
		{
			if(RelatedPRI_2.bIsFemale)
			{
	   			str = Repl(str, "%G", default.she);
			}else
			{
				str = Repl(str, "%G", default.he);
			}
		}
		else if(Switch - 1 == 8)
		{
			if(RelatedPRI_2.bIsFemale)
			{
	   			str = Repl(str, "%G", default.her);
			}else
			{
				str = Repl(str, "%G", default.his);
			}
		}
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
     KillString(0)=
     KillString(2)="Blunt: %X is a Bruiser"
     KillString(4)="Blunt: %X smacks every gob in sight"
     KillString(6)="Blunt: %X showed what %G learned at the police academy"
     KillString(8)="Blunt: %X makes pork chop out of %G enemies"
     KillString(10)="Blunt: %X follows only his own martial laws"
     KillString(14)="Blunt: You can't touch %X"
     bIsSpecial=False
     bFadeMessage=False
     DrawColor=(B=211,G=85,R=186)
     PosY=0.758000
     FontSize=0
}
