//=============================================================================
// CFHrDoctorMessageBC.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFHrDoctorMessageBC extends CFHrDoctorMessage;

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
     KillString(0)=
     KillString(2)="Melee: %X participated in an autopsy of %Y's corpse"
     KillString(4)="Melee: %X likes to slice bacon into tiny bits"
     KillString(6)="Melee: %X graduated as a Samurai"
     KillString(8)="Melee: %X knows how to slaughter the cattle"
     KillString(10)="Melee: %X's dissertation on jigsaw guided surgery has been published, call him 'Herr Doctor'"
     KillString(14)="Melee: %X must be a son of Tyr"
     bIsSpecial=False
     bFadeMessage=False
     DrawColor=(B=211,G=85,R=186)
     PosY=0.758000
     FontSize=0
}
