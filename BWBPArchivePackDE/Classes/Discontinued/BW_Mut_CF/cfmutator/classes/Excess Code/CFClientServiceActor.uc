//=============================================================================
// CFClientServiceActor.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CFClientServiceActor extends Actor;

replication
{
	reliable if(bNetDirty && (Role==ROLE_Authority))
		pri,
		iKnifeKills, iSuicides, iMGKills, iGrenadeKills, iBluntKills, iKills, iSpawnKills, iHeadshots, iPyro, iSniperKills, iRevolver, iGas;
}

var byte iKnifeKills;
var byte iSuicides;
var byte iMGKills;
var byte iGrenadeKills;
var byte iBluntKills;
var byte iSpawnKills;
var byte iHeadshots;
var byte iPyro;
var byte iRevolver;
var byte iSniperKills;
var byte iGas;

var int iKills;

var PlayerReplicationInfo pri;

defaultproperties
{
     bHidden=True
     bAlwaysRelevant=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
}
